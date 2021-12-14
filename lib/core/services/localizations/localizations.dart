import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _supportedLocales = ['en'];

class AppLocalization {
  final Locale locale;

  AppLocalization(this.locale);

  static AppLocalization? of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  static const LocalizationsDelegate<AppLocalization> delegate =
      _AppLocalizationsDelegate();

  Map<String, String> _localizedStrings = {};

  Future<bool> load() async {
    String jsonString = await rootBundle.loadString(
        'i18n/${isLocaleSupported(locale) ? locale.languageCode : 'en'}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  bool isLocaleSupported(Locale locale) {
    return _supportedLocales.contains(locale.languageCode);
  }

  String getString(String key) {
    return _localizedStrings[key] ?? "";
  }

  List<String> getStringArray(String key) {
    return _localizedStrings[key]
            ?.replaceFirst("[", "")
            .replaceFirst("]", "")
            .split(_localizedStrings[key]?.contains("\\,") == true
                ? "\\,"
                : ",") ??
        [];
  }

  String getCurrentLanguage() {
    return "${locale.languageCode}-${locale.countryCode}";
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalization> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return _supportedLocales.contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization localizations = AppLocalization(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

const welcomeMovieChat = "welcome_movie_chat";
const whatsYourName = "whats_your_name";
const signIn = "sign_in";

const moviesList = "movies_list";

const moviesListLoading = "movies_list_loading";

const writeComment = "write_comment";

const errorDefaultMessage = "error_default_message";
const errorEmptyName = "error_empty_name";
