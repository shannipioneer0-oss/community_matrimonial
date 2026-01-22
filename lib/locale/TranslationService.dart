import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class TranslationService {
  static Map<String, dynamic> _localizedStrings = {};

  static Future load(String languageCode) async {
    String jsonString = await rootBundle.loadString('assets/locale/$languageCode.json');
    _localizedStrings = json.decode(jsonString);

  }

 static String translate(String key) {
    return _localizedStrings[key];
  }

}