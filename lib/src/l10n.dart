library l10n_translator;

///
/// Copyright (C) 2019 Andrious Solutions
///
/// This program is free software; you can redistribute it and/or
/// modify it under the terms of the GNU General Public License
/// as published by the Free Software Foundation; either version 3
/// of the License, or any later version.
///
/// You may obtain a copy of the License at
///
///  http://www.apache.org/licenses/LICENSE-2.0
///
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
///          Created  06 Oct 2019
///
///
import 'dart:async' show Future;

import 'dart:ui' as ui show TextHeightBehavior;

import 'package:flutter/foundation.dart' show SynchronousFuture;

import 'package:flutter/material.dart';

/// For example, the Map variables would be defined in separate .dart files
///
/// @override
/// Map<Locale, Map<String, String>> get l10nMap => {
///   const Locale('ar', 'SA'): arSA,
///   const Locale('hi', 'IN'): hiIN,
///   const Locale('es', 'AR'): esAR,
///   const Locale('fr', 'FR'): frFR,
///   const Locale('pt', 'PT'): ptPT,
///   const Locale('ko', 'KP'): koKP,
///   const Locale('zh', 'CN'): zhCN,
/// };
///
///    /// The text's original Locale
///   static Locale get textLocale => const Locale('en', 'US');
///
/// Each file will be dedicated to one particular Localization language:
/// translations_arSA.dart
/// translations_hiIN.dart
/// translations_esAR.dart
/// translations_frFR.dart
/// translations_ptPT.dart
/// translations_zhCN.dart
///
/// As an example, in the file translations_frFR.dart below:
///
/// Map<String, String> frFR = {
///   'Parent': 'Parent',
///   'Child': 'Enfant',
///   'Quickstart': 'Démarrage rapide',
///   'Get Started': 'Commencer',
///   'Parents': 'Parents',
///   'Students': 'Étudiants',
///   'Teachers': 'Enseignants',
///   'Sign in': "S'identifier",
///   'Information': 'Information',
///   'Choose a password': 'Choisissez un mot de passe',
///   'Next': 'Suivant',
///   'Yes': 'Oui',
///   'No': 'Non',
///   'Name': 'Nom',
///   'Age': 'Âge',
///   'Add': 'Ajouter',
///   'Email address': 'Adresse e-mail',
///   'Password': 'Mot de passe',
///   'Remember Me': 'Souviens-toi de moi',
///   'Forgot Password?': 'Mot de passe oublié?',
///   "Don't have an Account?": "Vous n'avez pas de compte ?",
///   'New Account': 'Nouveau compte',
///   'Sign Up': "S'inscrire",
///   'Courses': 'Cours',
///   'Subject': 'Sujet',
///   'Exams': 'Examens',
///   'Premium': 'Prime',
///   'Free': 'Libérer',
///   'Enrollments': 'Inscriptions',
///   'Subscription': 'Abonnement',
///   'Messages': 'Messages',
///   'Transactions': 'Transactions',
///   'Link': 'Lien',
///   'Bad Request': 'Mauvaise demande',
///   'Forbidden': 'Interdit',
///   'Unauthorized': 'Non autorisé',
///   'Try again later': 'Réessayez plus tard',
///   'Internal': 'Interne',
///   'Unknown': 'Inconnue',
///   'Timeout': 'Temps libre',
///   'Default': 'Défaut',
///   'Cache': 'Cache',
///   'Internet': "l'Internet",
///   'Content': 'Contenu',
///   'Change Language': 'Changer de langue',
///   'Logout': 'Se déconnecter',
///   'Log In': 'Connexion',
/// };

/// Provide the suffix on every string for translation.
/// Append to the end of Strings to change to a translation.
extension L10nTranslate on String {
  //
  String get tr => L10n.translate(this);
}

/// The Localization Class
class L10n extends LocalizationsDelegate<L10n> {
  factory L10n() => _this ??= L10n._();
  L10n._();
  static L10n? _this;
  //
  /// The current Locale
  static Locale get locale {
    Locale locale;
    if (_appLocale != null) {
      locale = _appLocale!;
    } else {
      final preferredLocales =
          WidgetsBinding.instance.platformDispatcher.locales;
      if (preferredLocales.isNotEmpty) {
        locale = preferredLocales.first;
        _appLocale = locale;
        _prevLocale ??= locale;
      } else {
        locale = const Locale('en', 'US');
      }
    }
    return locale;
  }

  /// Assign a new Locale
  static set locale(Locale? locale) {
    //
    if (locale == null) {
      return;
    }
    // Has to be among the supported Locales
//    if (_localesSupported.isEmpty || _localesSupported.contains(locale)) {
    if (_appLocale == null) {
      _appLocale = locale;
      // Record the 'previous' assigned Locale
      _prevLocale ??= locale;
    } else {
      // We're changing the Locale
      if (locale != _appLocale) {
        // Important to reset to false to find any new translations.
        _localeSet = false;
        _prevLocale = _appLocale;
        _appLocale = locale;
      }
      // else, if they're the same, don't change anything.
    }
//    }
  }

  // The app's current Locale
  static Locale? _appLocale;

  /// The previous Locale
  static Locale get prevLocale => _prevLocale ??= locale;
  static Locale? _prevLocale;

  /// The app's translations
  static Map<Locale, Map<String, String>> get translations => _translations;
  static set translations(Map<Locale, Map<String, String>>? translateMap) {
    // Can only assign it once
    if (_translations.isEmpty && translateMap != null) {
      _translations.addAll(translateMap);
    }
  }

  static final Map<Locale, Map<String, String>> _translations = {};

  /// Supply the Localization Delegate (It's itself!)
  static LocalizationsDelegate<L10n> get delegate => L10n();

  /// A flag allowing the Locale to change dynamically or not.
  static bool allowDeviceChangeLocale = false;

  // A flag indicating the appropriate locale has been determined
  // It may mean translations are required. It may not.
  static bool _localeSet = false;

  /// Supported Locales
  static List<Locale> get supportedLocales {
    // Assume it's supported.
    if (_supportedLocales.isEmpty || _supportedLocales.length == 1) {
      //
      final _locale = locale;
      // If not already there
      if (!_supportedLocales.contains(_locale)) {
        if (_translations.isNotEmpty && !_translations.keys.contains(_locale)) {
          _supportedLocales.add(_locale);
        }
      }
      // Loads only once.
      if (_translations.isNotEmpty) {
        // Record the app's translated Locales.
        _supportedLocales.addAll(_translations.keys);
      }
    }
    // _localesSupported = _supportedLocales;
    return _supportedLocales;
  }

  static set supportedLocales(List<Locale>? locales) {
    // Can only set once!
    if (locales != null && supportedLocales.isEmpty) {
      _supportedLocales.addAll(locales);
    }
  }

  static final List<Locale> _supportedLocales = [];

  // static late List<Locale> _localesSupported = [];

  /// Intended to store the device's original Locale.
  static Locale? get deviceLocale {
    if (_deviceLocale == null) {
      // The full system-reported supported locales of the device.
      final systemLocales = WidgetsBinding.instance.window.locales;
      // Determine the device's default Locale. Assume the first will do it.
      _deviceLocale ??= systemLocales.isNotEmpty ? systemLocales.first : null;
    }
    return _deviceLocale;
  }

  // The device's original Locale
  static Locale? _deviceLocale;

  /// Supply the 'backup' Locale if any.
  static Locale? get backupLocale {
    if (_backupLocale == null) {
      if (supportedLocales.length > 1) {
        // Assume the second Locale a suitable backup.
        _backupLocale = _supportedLocales[1];
      } else {
        _backupLocale = locale;
      }
    }
    return _backupLocale;
  }

  static set backupLocale(Locale? locale) {
    if (locale != null) {
      // Only assign once.
      _backupLocale ??= locale;
    }
  }

  static Locale? _backupLocale;

  /// Get a Locale from the List of 'supported' Locales.
  static Locale? getLocale(int index) {
    Locale? locale;
    final localesList = _supportedLocales;
    if (localesList.isNotEmpty && index >= 0) {
      locale = localesList[index];
    }
    return locale;
  }

  /// Return a Locale object from the provided String
  static Locale? toLocale(String? _locale) {
    Locale? locale;

    if (_locale != null && _locale.isNotEmpty) {
      //
      var localeCode = _locale.split('_');
      if (localeCode.length == 1) {
        // Possibly it's in a language tag format
        localeCode = _locale.split('-');
      }
      String languageCode;
      String? countryCode;
      if (localeCode.length == 2) {
        languageCode = localeCode.first;
        countryCode = localeCode.last;
      } else {
        languageCode = localeCode.first;
      }
      locale = Locale(languageCode, countryCode);
    }
    return locale;
  }

  /// Add additional Translations
  /// Overwrite existing Translation
  static void appendTranslations(Map<Locale, Map<String, String>> tr) {
    tr.forEach((key, map) {
      if (_translations.containsKey(key)) {
        _translations[key]!.addAll(map);
      } else {
        _translations[key] = map;
      }
    });
  }

  /// Possibly translate the supplied word.
  static String translate(String word) {
    // If we have no means to determine the translation.
    // Keep testing. It could change.
    if (_appLocale?.languageCode == null) {
      //
      return word;
    }

    // Established the right translation.
    if (_localeSet) {
      if (_thisTranslation.isEmpty || !_thisTranslation.containsKey(word)) {
        // No translation available.
        return word;
      } else {
        // Translate.
        return _thisTranslation[word]!;
      }
    } else {
      // The Translations have possibly changed.
      if (_thisTranslation.isNotEmpty) {
        _thisTranslation.clear();
      }
    }

    // If a new Locale occurs this will be reset.
    _localeSet = true;

    var translations = _getTranslations(_appLocale);

    if (translations == null) {
      // If not the 'default' Locale, assign instead the backup.
      if (_appLocale != _prevLocale && _backupLocale != null) {
        //
        translations = _getTranslations(_backupLocale);
      }
    }

    String firstWord = word;

    if (translations != null) {
      // Record the translations to use.
      _thisTranslation.addAll(translations);

      if (translations.containsKey(firstWord)) {
        //
        firstWord = translations[firstWord]!;
      }
    }

    return firstWord;
  }

  /// Contains the app's 'current' translations.
  static final Map<String, String> _thisTranslation = {};

  /// Retrieve the translations for the specific Locale.
  static Map<String, String>? _getTranslations(Locale? thisLocale) {
    //
    if (thisLocale == null) {
      return null;
    }

    var _translations = translations[thisLocale];

    if (_translations == null) {
      // Try again but with no 'country' code.
      final translationsWithNoCountry = translations.map(
          (key, value) => MapEntry(key.languageCode.split('_').first, value));

      _translations =
          translationsWithNoCountry[thisLocale.languageCode.split('_').first];
    }

    return _translations;
  }

  /// Supply a Text object for the translation.
  static Text t(
    String? data, {
    Key? key,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    ui.TextHeightBehavior? textHeightBehavior,
  }) =>
      Text(
        s(data),
        key: key,
        style: style,
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: overflow,
        textScaleFactor: textScaleFactor,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
      );

  /// Translate the String
  static String s(String? word) => translate(word ?? '');

  /// Called by the LocalizationsDelegate. Possibly needed to resolve current Locale.
  static Locale? localeResolutionCallback(
      Locale? preferredLocale, Iterable<Locale>? supportedLocales) {
    //
    if (preferredLocale == null) {
      // Retrieve the 'first' locale in the supported locales.
      final locales = _supportedLocales;

      if (locales.isNotEmpty) {
        //
        if (supportedLocales == null) {
          // Use the first supported locale.
          preferredLocale = locales.first;
        } else {
          // Find the first supported locale
          for (final locale in supportedLocales.toList(growable: false)) {
            //
            if (locales.contains(locale)) {
              preferredLocale = locale;
            }
          }
        }
      }
    }
    return preferredLocale;
  }

  /// Return an instance of the L10Locale class
  /// Really not needed. L10n. prefix can be used instead. Merely for conformity.
  static L10n? of(BuildContext context) =>
      Localizations.of<L10n>(context, L10n);

  /// Indicate to the Flutter framework this delegate can support the passed Locale.
  @override
  bool isSupported(Locale locale) {
    //
    bool supported;

    // Assume you're supplied the App's Locale.
    if (L10n._appLocale == null) {
      L10n.locale = locale;
      supported = L10n._appLocale == locale;
    } else {
      supported = locale == L10n._appLocale;
    }
    // The device's Locale
    if (!supported) {
      supported = locale == L10n.deviceLocale;
    }
    // Check the supported Locales
    if (!supported) {
      // supported = L10n._localesSupported.contains(locale);
      supported = L10n.supportedLocales.contains(locale);
    }
    return supported;
  }

  @override
  Future<L10n> load([Locale? locale]) {
    L10n.locale = locale;
    return SynchronousFuture<L10n>(this);
  }

  /// Reload if the delegate has changed.
  @override
  bool shouldReload(L10n old) => L10n._appLocale != L10n._prevLocale;
}
