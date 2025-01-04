#Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

-keep class com.facebook.ads.** { *; }
-keep class com.facebook.internal.** { *; }

# Keep Play Core classes
-keep class com.google.android.play.core.** { *; }
-dontwarn com.google.android.play.core.**