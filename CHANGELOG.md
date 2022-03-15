
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