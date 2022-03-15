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

/// The Translations Manager Class
abstract class L10n extends LocalizationsDelegate<L10n> {
  //
  /// The text's original Locale
  Locale get textLocale;

  /// The app's translations
  Map<Locale, Map<String, String>> get l10nMap;

  /// Record the device's Locale at that point in time.
  /// Traditionally placed in a build() function.
  @Deprecated('This function was found to be unhelpful.')
  static Locale? localeOf(BuildContext? context, {bool? allowLocaleChange}) {
    Locale? locale;
    if (context != null) {
      // May return null if unable to determine Localization.
      locale = Localizations.maybeLocaleOf(context);
    }
    if (locale != null) {
      // Assign it as the App's Locale if not assigned yet.
      _appLocale ??= locale;
      if (_deviceLocale == null) {
        _deviceLocale = locale;
      } else if (locale != _deviceLocale) {
        // The device's Locale has changed.
        _deviceLocale = locale;
        // allowLocaleChange parameter takes precedence over the field, allowDeviceChangeLocale
        final change = allowLocaleChange == null && allowDeviceChangeLocale;
        if (change || allowLocaleChange!) {
          // The App is to change Locale with this device.
          setLocale(locale);
        }
      }
    }
    return locale;
  }

  /// A flag allowing the Locale to change dynamically or not.
  static bool allowDeviceChangeLocale = false;

  // A flag indicating the appropriate locale has been determined
  // It may mean translations are required. It may not.
  static bool _localeSet = false;

  /// Supported Locales
  List<Locale> get supportedLocales {
    if (_initLocales(textLocale, l10nMap)) {
      _localesSupported = _supportedLocales;
    }
    return _supportedLocales;
  }

  final List<Locale> _supportedLocales = [];

  static late List<Locale> _localesSupported = [];

  /// Intended to store the device's original Locale.
  static Locale? get deviceLocale => _deviceLocale;
  static Locale? _deviceLocale;

  /// The App's Locale
  static Locale? get appLocale => _appLocale;
  static Locale? _appLocale;

  /// Supply the 'backup' Locale if any.
  static Locale? get backupLocale => _backupLocale;
  static Locale? _backupLocale;

  /// Set the 'backup' Locale to use.
  void setAppBackupLocale(Locale? locale) {
    if (locale != null) {
      _backupLocale = locale;
    }
  }

  /// Translation Map
  static Map<Locale, Map<String, String>> get translations => _translations;
  static final Map<Locale, Map<String, String>> _translations = {};

  /// Supply the translations
  /// Return true if successful
  bool _initLocales(Locale textLocale, Map<Locale, Map<String, String>>? map) {
    // Initialize only once.
    var init = _translations.isEmpty;
    if (init) {
      init = map != null;
    }
    if (init) {
      _translations.clear();
      _supportedLocales.clear();
      final size = _translations.length;
      _translations.addAll(map!);
      // Framework picks the first one.
      _supportedLocales.add(textLocale);
      _supportedLocales.addAll(map.keys);
      init = _translations.length > size;
      // Assign as the delegate
      delegate = this;
    }
    return init;
  }

  /// Clear the Translations Map variable
  @Deprecated('Not a wise capability.')
  static void clearTranslations() {}

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
    if (appLocale?.languageCode == null) {
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

    var translations = _getTranslations(appLocale);

    if (translations == null && _backupLocale != null) {
      //
      translations = _getTranslations(_backupLocale);
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
  Locale? localeResolutionCallback(
      Locale? preferredLocale, Iterable<Locale>? supportedLocales) {
    //
    // In case this function was not called yet.
    _initLocales(textLocale, l10nMap);

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
          for (final _locale in supportedLocales.toList(growable: false)) {
            //
            if (locales.contains(_locale)) {
              preferredLocale = _locale;
            }
          }
        }
      }
    }

    // The full system-reported supported locales of the device.
    final systemLocales = WidgetsBinding.instance!.window.locales;

    if (_appLocale == null) {
      _appLocale = preferredLocale;
      _deviceLocale = systemLocales.isNotEmpty ? systemLocales.first : null;
      if (supportedLocales != null && supportedLocales.length > 1) {
        final list = supportedLocales.toList(growable: false);
        // Assume the second Locale a suitable backup.
        _backupLocale = list[1];
      }
    } else {
      // If the passed Locale is unique but supported.
      if (systemLocales.isNotEmpty) {
        if (!systemLocales.contains(preferredLocale) &&
            supportedLocales != null &&
            supportedLocales.contains(preferredLocale)) {
          // It's a specific Locale assigned to the app
          _appLocale = preferredLocale;
        } else {
          // Override with the app's preferred locale.
          preferredLocale = _appLocale;
        }
      }
    }
    return preferredLocale;
  }

  /// A more verbose method name
  static bool setAppLocale(Locale? locale) => setLocale(locale);

  /// Explicitly set a supported Locale using this class
  /// Set the Locale to translate
  /// Returns true if set to that Locale
  static bool setLocale(Locale? locale) {
    final set = locale != null &&
        // If there's translations, it must be found among them.
        (_localesSupported.isEmpty || _localesSupported.contains(locale));
    if (set) {
      if (_appLocale == null) {
        _appLocale = locale;
      } else {
        if (locale != _appLocale) {
          // Important to reset to false to find any new translations.
          _localeSet = false;
          _appLocale = locale;
        }
        // else, if they're the same, don't change anything.
      }
    }
    return set;
  }

  /// Get a Locale from the List of 'supported' Locales.
  Locale? getLocale(int index) {
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

  /// Supply the Localization Delegate (It's itself!)
  static LocalizationsDelegate<L10n>? delegate;

  Locale? _locale;

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
      supported = L10n.setLocale(locale);
    } else {
      supported = locale == L10n._appLocale;
    }

    if (!supported) {
      supported = locale == L10n._deviceLocale;
    }

    if (!supported) {
      supported = L10n._localesSupported.contains(locale);
    }

    return supported;
  }

  @override
  Future<L10n> load([Locale? locale]) {
    L10n.setLocale(locale);
    return SynchronousFuture<L10n>(this);
  }

  /// Reload if the delegate has changed.
  @override
  bool shouldReload(L10n old) => _locale != old._locale;
}
