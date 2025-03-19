import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  // Define the translations
  final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      "q1": "What is Flutter?",
      "q2": "Which language is primarily used to write Flutter applications?",
      "q3": "What is a 'Widget' in Flutter?",
      "q4":
          "Which of the following is used for creating a new Flutter project?",
      "q5":
          "What is the purpose of the pubspec.yaml file in a Flutter project?",
      "q6": "Which widget should you use to create a scrollable list of items?",
      "q7": "What is the build method in a Flutter widget?",
      "q8": "What does the 'setState' method do in a StatefulWidget?",
      "q9":
          "Which command is used to run a Flutter app on an emulator or physical device?",
      "q10": "What is the 'MaterialApp' widget used for?"
    },
    'ta': {
      "q1": "Flutter என்றால் என்ன?",
      "q2":
          "Flutter பயன்பாடுகளை எழுத எந்த மொழி முதன்மையாகப் பயன்படுத்தப்படுகிறது?",
      "q3": "Flutter-ல் 'விட்ஜெட்' என்றால் என்ன?",
      "q4":
          "புதிய Flutter திட்டத்தை உருவாக்க பின்வருவனவற்றில் எது பயன்படுத்தப்படுகிறது?",
      "q5": "Flutter திட்டத்தில் pubspec.yaml கோப்பின் நோக்கம் என்ன?",
      "q6":
          "உருட்டக்கூடிய உருப்படிகளின் பட்டியலை உருவாக்க எந்த விட்ஜெட்டைப் பயன்படுத்த வேண்டும்?",
      "q7": "Flutter விட்ஜெட்டில் உருவாக்க முறை என்ன?",
      "q8": "ஸ்டேட்ஃபுல் விட்ஜெட்டில் 'செட்ஸ்டேட்' முறை என்ன செய்கிறது?",
      "q9":
          "எமுலேட்டர் அல்லது இயற்பியல் சாதனத்தில் ஃப்ளட்டர் பயன்பாட்டை இயக்க எந்த கட்டளை பயன்படுத்தப்படுகிறது?",
      "q10": "'MaterialApp' விட்ஜெட் எதற்காகப் பயன்படுத்தப்படுகிறது?"
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ta'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
