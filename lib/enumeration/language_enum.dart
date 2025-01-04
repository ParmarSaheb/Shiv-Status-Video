import 'dart:ui';
import 'package:shiv_status_video/utils/string_file.dart';

enum LanguageEnum {
  en(StringFile.en, StringFile.english),
  gu(StringFile.gu, StringFile.gujarati),
  hi(StringFile.hi, StringFile.hindi),
  mr(StringFile.mr, StringFile.marathi),
  ta(StringFile.ta, StringFile.tamil);

  final String localeCode;
  final String name;

  const LanguageEnum(this.localeCode, this.name);

  Locale get locale => Locale(localeCode);
}
