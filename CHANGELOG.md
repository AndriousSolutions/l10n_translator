
## 4.1.4
March 17, 2024
- Removed _localeSet from if (locale != _appLocale) {

## 4.1.3
June 16, 2023
- _supportedLocales when defined defaults to Locale('en', 'US').

## 4.1.2+1
May 31, 2023
- if (_localeSet && locale != _appLocale)
  /// The full system-reported supported locales of the device.
- WidgetsBinding.instance.platformDispatcher.locales; 
- Upgraded to Dart 3

## 4.1.1
September 18, 2022
- _translations.isNotEmpty && !_translations.keys.contains(_locale)

## 4.1.0+02
September 14, 2022
- static Locale get prevLocale
- static Locale? getLocale(int index) {
- static set supportedLocales

## 4.0.0
September 14, 2022
- factory L10n() Back to a Singleton pattern

## 3.2.0
June 27, 2022
- get delegate => this; Changed from an static to an instance reference.

## 3.1.0
June 01, 2022
- Updated Dart   sdk: '>=2.17.1 <3.0.0'
- Null operator '!' not longer necessary for 'WidgetsBinding' in Flutter 3.x

## 3.0.1
March 15, 2022
- _deviceLocale ??= systemLocales.isNotEmpty

## 3.0.0+01
March 15, 2022
- Merged L10nTranslations and L10nDelegate into one class, L10n
- Replaced L10n.setAppLocale() with L10n.setLocale()
- Deprecated localeOf() and clearTranslations()
- Updated localeResolutionCallback()

## 2.0.0+01
March 05, 2022
- Renamed extension to L10nTranslate
- Rewrote abstract class L10nTranslations

## 1.3.1
March 03, 2022
- Removed i10n_translator class

## 1.3.0
February 18, 2022
- Localizations.maybeLocaleOf(context);
- allowLocaleChange parameter takes precedence over allowDeviceChangeLoc
- include localizationsDelegates in example app

## 1.2.0
February 16, 2022
- Removed functions, trArgs trPlural trParams trPluralParams

## 1.1.0
February 15, 2022
- of(context) function to retrieve an instance of l10nLocale

## 1.0.0+04
February 13, 2022
- initial commit
- Include 'Demo App' title in translations