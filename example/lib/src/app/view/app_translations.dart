///
///
///

import 'package:example/src/view.dart';

/// Supply names of Locales to the App's popupmenu.
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
