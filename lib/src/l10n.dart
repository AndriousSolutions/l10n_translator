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
  String get tr => L10nLocale().translate(this);
}

///
///  Supply the 'translation Map objects'
///
///
///  e.g.  //ignore: non_constant_identifier_names
///        final AppTrs = AppTranslations();
///
abstract class L10nTranslations {
  L10nTranslations() {
    // Important to set textLocale first.
    L10n.textLocale = textLocale;
    L10n.addTranslations(l10nMap);
  }

  /// The text's original Locale
  Locale get textLocale;

  /// The app's translations
  Map<Locale, Map<String, String>> get l10nMap;

  /// Use this getter below for your MaterialApp supportedLocales parameter
  /// It will also load the translations defined above.
  List<Locale> get supportedLocales => L10n.supportedLocales;

  /// Record the device's Locale at that point in time.
  /// Traditionally placed in a build() function.
  Locale? localeOf(BuildContext? context, {bool? allowLocaleChange}) =>
      L10n.localeOf(context, allowLocaleChange: allowLocaleChange);

  /// Supply the Localization Delegate
  LocalizationsDelegate<L10nLocale> get delegate => L10n.delegate;

  /// Explicitly set a supported Locale using this class
  /// Allow your App to not reference L10n or L10nLocale at all.
  /// Set the Locale to translate
  /// Returns true if set to that Locale
  bool setLocale(Locale? locale) => L10n.setAppLocale(locale);

  /// Get a Locale from the List of 'supported' Locales.
  Locale? getLocale(int index) => L10n.getLocale(index);

  /// Return a Locale object from the provided String
  Locale? toLocale(String? _locale) => L10n.toLocale(_locale);

  /// Convert a Text object to one with a translation.
  Text of(
    Text? text, {
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
  }) =>
      L10n.of(
        text,
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
      );

  /// Supply a Text object for the translation.
  Text t(
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
      L10n.t(
        data,
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
  String s(String? word) => L10n.s(word);
}

//ignore: non_constant_identifier_names
final L10n = L10nLocale();

/// The Translations Manager Class
class L10nLocale {
  factory L10nLocale() => _this ??= L10nLocale._();
  L10nLocale._();
  static L10nLocale? _this;

  /// Record the device's Locale at that point in time.
  /// Traditionally placed in a build() function.
  Locale? localeOf(BuildContext? context, {bool? allowLocaleChange}) {
    Locale? locale;
    if (context != null) {
      // May return null if unable to determine Localization.
      locale = Localizations.maybeLocaleOf(context);
    }
    if (locale != null) {
      // Assign it as the App's Locale if not assigned yet.
      _appLocale ??= locale;
      // Assign it as the 'text' used.
      textLocale ??= locale;
      if (_deviceLocale == null) {
        _deviceLocale = locale;
      } else if (locale != _deviceLocale) {
        // The device's Locale has changed.
        _deviceLocale = locale;
        // allowLocaleChange parameter takes precedence over the field, allowDeviceChangeLocale
        final change = allowLocaleChange == null && allowDeviceChangeLocale;
        if (change || allowLocaleChange!) {
          // The App is to change Locale with this device.
          setAppLocale(locale);
        }
      }
    }
    return locale;
  }

  /// The Locale of the original text at times being translated.
  Locale? get textLocale => _textLocale ?? const Locale('en', 'US');

  /// Set the Locale of the app's visible text if any.
  set textLocale(Locale? locale) {
    if (locale != null) {
      _textLocale = locale;
    }
  }

  Locale? _textLocale;

  /// A flag allowing the Locale to change dynamically or not.
  bool allowDeviceChangeLocale = false;

  // A flag indicating the appropriate locale has been determined
  // It may mean translations are required. It may not.
  bool _localeSet = false;

  /// Intended to store the device's original Locale.
  Locale? get deviceLocale => _deviceLocale;
  Locale? _deviceLocale;

  /// The App's Locale
  Locale? get appLocale => _appLocale;
  Locale? _appLocale;

  /// Supply the 'backup' Locale if any.
  Locale? get backupLocale => _backupLocale;
  Locale? _backupLocale;

  /// Set the 'backup' Locale to use.
  void setAppBackupLocale(Locale? locale) {
    if (locale != null) {
      _backupLocale = locale;
    }
  }

  /// Use this getter below for your MaterialApp supportedLocales parameter
  /// It will also load the translations defined above.
  List<Locale> get supportedLocales => _supportedLocales.isEmpty
      ? const <Locale>[Locale('en', 'US')]
      : _supportedLocales;

  //ignore: prefer_final_fields
  final List<Locale> _supportedLocales = [];

  /// Contains the app's 'current' translations.
  final Map<String, String> _thisTranslation = {};

  /// Translation Map
  Map<Locale, Map<String, String>> get translations => _translations;
  final Map<Locale, Map<String, String>> _translations = {};

  /// Supply the translations
  /// Return true if successful
  bool addTranslations(Map<Locale, Map<String, String>>? map) {
    // Initialize only once.
    var init = _translations.isEmpty;
    if (init) {
      init = map != null;
    }
    if (init) {
      final size = _translations.length;
      _translations.addAll(map!);
      if (textLocale != null) {
        // Framework picks the first one.
        _supportedLocales.add(textLocale!);
      }
      _supportedLocales.addAll(map.keys);
      init = _translations.length > size;
    }
    return init;
  }

  /// Clear the Translations Map variable
  void clearTranslations() => _translations.clear();

  /// Add additional Translations
  /// Overwrite existing Translation
  void appendTranslations(Map<Locale, Map<String, String>> tr) {
    tr.forEach((key, map) {
      if (_translations.containsKey(key)) {
        _translations[key]!.addAll(map);
      } else {
        _translations[key] = map;
      }
    });
  }

  /// Possibly translate the supplied word.
  String translate(String word) {
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

  /// Retrieve the translations for the specific Locale.
  Map<String, String>? _getTranslations(Locale? thisLocale) {
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

  /// Convert a Text object to one with a translation.
  Text of(
    Text? text, {
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
  }) =>
      t(
        text?.data,
        key: key ?? text?.key,
        style: style ?? text?.style,
        strutStyle: strutStyle ?? text?.strutStyle,
        textAlign: textAlign ?? text?.textAlign,
        textDirection: textDirection ?? text?.textDirection,
        locale: locale ?? text?.locale,
        softWrap: softWrap ?? text?.softWrap,
        overflow: overflow ?? text?.overflow,
        textScaleFactor: textScaleFactor ?? text?.textScaleFactor,
        maxLines: maxLines ?? text?.maxLines,
        semanticsLabel: semanticsLabel ?? text?.semanticsLabel,
        textWidthBasis: textWidthBasis ?? text?.textWidthBasis,
      );

  /// Supply a Text object for the translation.
  Text t(
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
  String s(String? word) => translate(word ?? '');

  ///=======================================================
  ///  Code from the older version.
  ///

  /// Supply the Localization Delegate
  LocalizationsDelegate<L10nLocale> get delegate => L10nDelegate();

  /// Called by the LocalizationsDelegate object
  Future<L10nLocale> load([Locale? locale]) {
    setAppLocale(locale);
    return SynchronousFuture<L10nLocale>(this);
  }

  /// Called by the LocalizationsDelegate. Possibly needed to resolve current Locale.
  Locale? localeResolutionCallback(
      Locale? systemLocale, Iterable<Locale>? supportedLocales) {
    //
    final _appLocale = appLocale;

    // Override the system's preferred locale with the app's preferred locale.
    if (_appLocale != null) {
      systemLocale = _appLocale;
    }

    if (systemLocale == null) {
      // Retrieve the 'first' locale in the supported locales.
      final locales = _supportedLocales;

      if (locales.isNotEmpty) {
        //
        if (supportedLocales == null) {
          // Use the first supported locale.
          systemLocale = locales[0];
        } else {
          // Find the first supported locale
          for (final _locale in supportedLocales.toList(growable: false)) {
            //
            if (locales.contains(_locale)) {
              systemLocale = _locale;
            }
          }
        }
      }
    }
    return systemLocale;
  }

  /// Explicitly set a supported Locale using this class
  /// Allow your App to not reference L10n or L10nLocale at all.
  /// Set the Locale to translate
  /// Returns true if set to that Locale
  bool setAppLocale(Locale? locale) {
    final set = locale != null &&
        // If there's translations, it must be found among them.
        (_translations.isEmpty ||
            _translations.containsKey(locale) ||
            _textLocale == null ||
            locale == _textLocale);
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
  Locale? toLocale(String? _locale) {
    Locale? locale;

    if (_locale != null && _locale.isNotEmpty) {
      //
      final localeCode = _locale.split('-');
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
}

/// The L10n package's locale delegate
/// Referenced by frameworks (eg. mvc_applicaiton)
class L10nDelegate extends LocalizationsDelegate<L10nLocale> {
  // No need for more than one instance.
  factory L10nDelegate() => _this ??= L10nDelegate._();
  L10nDelegate._();
  static L10nDelegate? _this;

  Locale? _locale;

  /// Return an instance of the L10Locale class
  /// Really not needed. L10n. prefix can be used instead. Merely for conformity.
  static L10nLocale? of(BuildContext context) =>
      Localizations.of<L10nLocale>(context, L10nLocale);

  /// Indicate to the Flutter framework this delegate can support the passed Locale.
  @override
  bool isSupported(Locale locale) {
    //
    bool supported;

    final l10n = L10nLocale();

    supported = locale == l10n._appLocale;

    if (!supported) {
      supported = locale == l10n._deviceLocale;
    }

    if (!supported) {
      supported = l10n._supportedLocales.contains(locale);
    }

    // Assume you're supplied the App's Locale to this class as well.
    if (l10n.appLocale == null) {
      supported = l10n.setAppLocale(locale);
    }

    return supported;
  }

  /// Explicitly load the Locale provided by the Flutter framework.
  @override
  Future<L10nLocale> load(Locale locale) {
    _locale = locale;
    return L10nLocale().load(locale);
  }

  /// Reload if the delegate has changed.
  @override
  bool shouldReload(L10nDelegate old) => _locale != old._locale;
}
