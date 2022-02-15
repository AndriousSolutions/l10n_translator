import 'package:example/src/view.dart'
    show L10nTranslations, Locale, arSA, esAR, frFR, hiIN, koKP, ptPT, zhCN;

class AppTranslations extends L10nTranslations {
  factory AppTranslations() => _this ??= AppTranslations._();
  AppTranslations._();
  static AppTranslations? _this;

  /// The app's default Locale
  @override
  Locale get textLocale => const Locale('en', 'US');

  /// The app's translations.
  @override
  Map<Locale, Map<String, String>> get l10nMap => {
        const Locale('ar', 'SA'): arSA,
        const Locale('hi', 'IN'): hiIN,
        const Locale('es', 'AR'): esAR,
        const Locale('fr', 'FR'): frFR,
        const Locale('pt', 'PT'): ptPT,
        const Locale('ko', 'KP'): koKP,
        const Locale('zh', 'CN'): zhCN,
      };
}

class AppLocales {
  factory AppLocales() => _this ??= AppLocales._();
  AppLocales._();
  static AppLocales? _this;

  final List<Map<Locale, String>> localeNames = [
    {const Locale('en', 'US'): 'English'},
    {const Locale('ar', 'SA'): 'العربية'},
    {const Locale('hi', 'IN'): 'हिंदी'},
    {const Locale('es', 'AR'): 'Español'},
    {const Locale('fr', 'FR'): 'Français'},
    {const Locale('pt', 'PT'): 'Portugues'},
    {const Locale('ko', 'KP'): '한국어'},
    {const Locale('zh', 'CN'): '汉语'},
  ];
}
