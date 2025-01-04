package com.example.shiv_status_video

//import io.flutter.embedding.android.FlutterActivity
import com.example.shiv_status_video.facebook_audience_network.FacebookAudienceNetworkPlugin
import android.app.Activity
import java.io.FileOutputStream
import android.graphics.Bitmap
import android.os.Build
import java.io.File
import android.content.Intent
import android.net.Uri
import androidx.core.content.FileProvider
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel
import java.io.IOException
import android.media.MediaMetadataRetriever
import java.io.FileInputStream
import java.util.concurrent.Executors
import java.io.ByteArrayOutputStream

import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

class MainActivity : FlutterActivity() {

    private val CHANNEL = "share_to_whatsapp"
    private val THUMBNAIL_CHANNEL = "thumbnail_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        GeneratedPluginRegistrant.registerWith(flutterEngine)

        flutterEngine.plugins.add(FacebookAudienceNetworkPlugin())

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "shareFile") {
                val filePath = call.argument<String>("filePath")
                val text = call.argument<String>("text")

                if (filePath != null && text != null) {
                    shareFile(filePath, text)
                    result.success(null)
                } else {
                    result.error("UNAVAILABLE", "File path or text not available.", null)
                }
            } else {
                result.notImplemented()
            }
        }

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            THUMBNAIL_CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "file" -> {
                    val videoPath = call.argument<String>("video")
                    val headers = call.argument<Map<String, String>>("headers")
                    val format = call.argument<Int>("format") ?: 0
                    val maxh = call.argument<Int>("maxh") ?: 0
                    val maxw = call.argument<Int>("maxw") ?: 0
                    val timeMs = call.argument<Int>("timeMs") ?: 0
                    val quality = call.argument<Int>("quality") ?: 100
                    val thumbnailPath = call.argument<String>("path")

                    if (videoPath != null) {
                        val thumbnailFilePath =
                            buildThumbnailFile(
                                videoPath,
                                headers,
                                thumbnailPath,
                                format,
                                maxh,
                                maxw,
                                timeMs,
                                quality
                            )
                        result.success(thumbnailFilePath)
                    } else {
                        result.error("INVALID_ARGUMENT", "Video path is required", null)
                    }
                }

                "data" -> {
                    val videoPath = call.argument<String>("video")
                    val headers = call.argument<Map<String, String>>("headers")
                    val format = call.argument<Int>("format") ?: 0
                    val maxh = call.argument<Int>("maxh") ?: 0
                    val maxw = call.argument<Int>("maxw") ?: 0
                    val timeMs = call.argument<Int>("timeMs") ?: 0
                    val quality = call.argument<Int>("quality") ?: 100

                    if (videoPath != null) {
                        try {
                            val thumbnailData =
                                buildThumbnailData(
                                    videoPath,
                                    headers,
                                    format,
                                    maxh,
                                    maxw,
                                    timeMs,
                                    quality
                                )
                            result.success(thumbnailData)
                        } catch (e: Exception) {
                            result.error(
                                "ERROR",
                                "Failed to generate thumbnail data: ${e.message}",
                                null
                            )
                        }
                    } else {
                        result.error("INVALID_ARGUMENT", "Video path is required", null)
                    }
                }

                else -> result.notImplemented()
            }
        }
    }


    private fun shareFile(filePath: String, text: String) {
        val file = File(filePath)
        val uri: Uri =
            FileProvider.getUriForFile(this, "com.example.shiv_status_video.fileprovider", file)

        val shareIntent = Intent(Intent.ACTION_SEND).apply {
            putExtra(Intent.EXTRA_TEXT, text)
            putExtra(Intent.EXTRA_STREAM, uri)
            type = "video/*"
            setPackage("com.whatsapp")
            addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
        }
        startActivity(Intent.createChooser(shareIntent, "Share Video"))
    }


    private fun buildThumbnailData(
        videoPath: String,
        headers: Map<String, String>?,
        format: Int,
        maxh: Int,
        maxw: Int,
        timeMs: Int,
        quality: Int
    ): ByteArray {
        val bitmap = createVideoThumbnail(videoPath, headers, maxh, maxw, timeMs)
            ?: throw NullPointerException("Thumbnail creation failed")

        val stream = ByteArrayOutputStream()
        bitmap.compress(intToFormat(format), quality, stream)
        bitmap.recycle()
        return stream.toByteArray()
    }

    private fun intToFormat(format: Int): Bitmap.CompressFormat {
        return when (format) {
            1 -> Bitmap.CompressFormat.PNG
            2 -> Bitmap.CompressFormat.WEBP
            else -> Bitmap.CompressFormat.JPEG
        }
    }

    private fun buildThumbnailFile(
        videoPath: String,
        headers: Map<String, String>?,
        thumbnailPath: String?,
        format: Int,
        maxh: Int,
        maxw: Int,
        timeMs: Int = 7000, // Default to 3 seconds
        quality: Int
    ): String? {
        val bitmap = createVideoThumbnail(videoPath, headers, timeMs, maxh, maxw)
            ?: return null // Early exit if thumbnail creation failed

        val file = File(thumbnailPath)
        if (file.exists()) {
            file.delete()
        }

        try {
            FileOutputStream(file).use { outputStream ->
                bitmap.compress(intToFormat(format), quality, outputStream)
                outputStream.flush()
            }
            bitmap.recycle()
        } catch (e: IOException) {
            e.printStackTrace()
            return null
        }

        return file.absolutePath
    }


    private fun createVideoThumbnail(
        video: String,
        headers: Map<String, String>?,
        timeMs: Int,
        targetH: Int,
        targetW: Int
    ): Bitmap? {
        var bitmap: Bitmap? = null
        val retriever = MediaMetadataRetriever()

        try {
            when {
                video.startsWith("/") -> setDataSource(video, retriever)
                video.startsWith("file://") -> setDataSource(video.substring(7), retriever)
                else -> retriever.setDataSource(video, headers ?: HashMap())
            }

            bitmap = if (targetH > 0 && targetW > 0) {
                if (Build.VERSION.SDK_INT >= 27) {
                    retriever.getScaledFrameAtTime(
                        timeMs * 1000L,
                        MediaMetadataRetriever.OPTION_CLOSEST,
                        targetW,
                        targetH
                    )
                } else {
                    val originalBitmap = retriever.getFrameAtTime(
                        timeMs * 1000L,
                        MediaMetadataRetriever.OPTION_CLOSEST
                    )
                    if (originalBitmap != null) {
                        Bitmap.createScaledBitmap(originalBitmap, targetW, targetH, true)
                    } else {
                        null
                    }
                }
            } else {
                retriever.getFrameAtTime(timeMs * 1000L, MediaMetadataRetriever.OPTION_CLOSEST)
            }
        } catch (ex: Exception) {
            ex.printStackTrace()
        } finally {
            retriever.release()
        }

        return bitmap
    }


    @Throws(IOException::class)
    private fun setDataSource(video: String, retriever: MediaMetadataRetriever) {
        val videoFile = File(video)
        FileInputStream(videoFile.absolutePath).use {
            retriever.setDataSource(it.fd)
        }
    }

}
