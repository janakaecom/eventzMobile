import 'package:eventz/utils/translation/english.dart';
import 'package:eventz/utils/translation/sinhala.dart';
import 'package:eventz/utils/translation/tamil.dart';
import 'package:get/get.dart';

class FLTranslations extends Translations {
  Map<String, Map<String, String>> get keys => {
        'en': EnglishTranslations.en_text,
        'si-LK': SinhalaTranslations.sin_text,
        'ta-LK': TamilTranslations.tm_text
      };
}
