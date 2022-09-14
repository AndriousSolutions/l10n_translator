///
///
///

import 'package:example/src/view.dart';

/// Highlights UI while debugging.
import 'package:flutter/rendering.dart' as debug;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  // A static reference used to change the app's Locale
  static ValueNotifier<Locale> currentLocale =
      ValueNotifier<Locale>(const Locale('en', 'US'));

  @override
  State createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //
  @override
  void initState() {
    //
    super.initState();
    //
    assert(() {
      /// Highlights UI while debugging.
      debug.debugPaintSizeEnabled = false;
      debug.debugPaintBaselinesEnabled = false;
      debug.debugPaintPointersEnabled = false;
      debug.debugPaintLayerBordersEnabled = false;
      debug.debugRepaintRainbowEnabled = false;
      debug.debugRepaintTextRainbowEnabled = false;
      return true;
    }());

    // Supply some translations
    L10n.translations = {
      const Locale('ar', 'SA'): arSA,
      const Locale('hi', 'IN'): hiIN,
      const Locale('es', 'AR'): esAR,
      const Locale('fr', 'FR'): frFR,
      const Locale('pt', 'PT'): ptPT,
      const Locale('ko', 'KP'): koKP,
      const Locale('zh', 'CN'): zhCN,
    };

    MyApp.currentLocale.addListener(() {
      L10n.locale = MyApp.currentLocale.value;
      // Call the build() again.
      setState(() {});
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        locale: L10n.locale,
        supportedLocales: L10n.supportedLocales,
        localeResolutionCallback: L10n.localeResolutionCallback,
        localizationsDelegates: [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          L10n.delegate,
        ],
        home: const MyHomePage(),
      );
}
