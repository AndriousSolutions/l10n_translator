///
///
///

import 'package:example/src/view.dart';

/// Highlights UI while debugging.
import 'package:flutter/rendering.dart' as debug;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      locale: AppTrs.textLocale,
      supportedLocales: AppTrs.supportedLocales,
      localeResolutionCallback: AppTrs.localeResolutionCallback,
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        L10n.delegate!,
      ],
      home: const MyHomePage(),
    );
  }
}
