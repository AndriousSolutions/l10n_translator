///
///
///

import 'package:example/src/view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    langPopup();
  }

  final List<PopupMenuItem<String>> _menuItems = [];

  @override
  Widget build(BuildContext context) {
    /// Always test if the App has changed Locale.
    L10n.localeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo App'.tr),
        actions: [_popupMenu],
      ),
      body: CustomScrollView(
        primary: false,
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.only(top: 15),
            sliver: SliverGrid.count(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 18,
              crossAxisCount: 1,
              children: <Widget>[
                _Row(children: [const Text('Parent'), Text('Parent'.tr)]),
                _Row(children: [const Text('Child'), Text('Child'.tr)]),
                _Row(children: [
                  const Text('Quickstart'),
                  Text('Quickstart'.tr)
                ]),
                _Row(children: [
                  const Text('Get Started'),
                  Text('Get Started'.tr)
                ]),
                _Row(children: [const Text('Parents'), Text('Parents'.tr)]),
                _Row(children: [const Text('Students'), Text('Students'.tr)]),
                _Row(children: [const Text('Teachers'), Text('Teachers'.tr)]),
                _Row(children: [const Text('Sign in'), Text('Sign in'.tr)]),
                _Row(children: [
                  const Text('Choose a password'),
                  Text('Choose a password'.tr)
                ]),
                _Row(children: [const Text('Next'), Text('Next'.tr)]),
                _Row(children: [const Text('Yes'), Text('Yes'.tr)]),
                _Row(children: [const Text('No'), Text('No'.tr)]),
                _Row(children: [const Text('Name'), Text('Name'.tr)]),
                _Row(children: [const Text('Age'), Text('Age'.tr)]),
                _Row(children: [const Text('Add'), Text('Add'.tr)]),
                _Row(children: [
                  const Text('Email address'),
                  Text('Email address'.tr)
                ]),
                _Row(children: [
                  const Text('Remember Me'),
                  Text('Remember Me'.tr)
                ]),
                _Row(children: [
                  const Text('Forgot Password?'),
                  Text('Forgot Password?'.tr)
                ]),
                _Row(children: [
                  const Text("Don't have an Account?"),
                  Text("Don't have an Account?".tr)
                ]),
                _Row(children: [
                  const Text('New Account'),
                  Text('New Account'.tr)
                ]),
                _Row(children: [const Text('Sign Up'), Text('Sign Up'.tr)]),
                _Row(children: [const Text('Courses'), Text('Courses'.tr)]),
                _Row(children: [const Text('Subject'), Text('Subject'.tr)]),
                _Row(children: [const Text('Exams'), Text('Exams'.tr)]),
                _Row(children: [const Text('Premium'), Text('Premium'.tr)]),
                _Row(children: [const Text('Free'), Text('Free'.tr)]),
                _Row(children: [
                  const Text('Enrollments'),
                  Text('Enrollments'.tr)
                ]),
                _Row(children: [
                  const Text('Subscription'),
                  Text('Subscription'.tr)
                ]),
                _Row(children: [const Text('Messages'), Text('Messages'.tr)]),
                _Row(children: [
                  const Text('Transactions'),
                  Text('Transactions'.tr)
                ]),
                _Row(children: [const Text('Link'), Text('Link'.tr)]),
                _Row(children: [
                  const Text('Bad Request'),
                  Text('Bad Request'.tr)
                ]),
                _Row(children: [const Text('Forbidden'), Text('Forbidden'.tr)]),
                _Row(children: [
                  const Text('Unauthorized'),
                  Text('Unauthorized'.tr)
                ]),
                _Row(children: [const Text('Internal'), Text('Internal'.tr)]),
                _Row(children: [const Text('Unknown'), Text('Unknown'.tr)]),
                _Row(children: [const Text('Timeout'), Text('Timeout'.tr)]),
                _Row(children: [const Text('Default'), Text('Default'.tr)]),
                _Row(children: [const Text('Cache'), Text('Cache'.tr)]),
                _Row(children: [const Text('Internet'), Text('Internet'.tr)]),
                _Row(children: [const Text('Content'), Text('Content'.tr)]),
                _Row(children: [
                  const Text('Change Language'),
                  Text('Change Language'.tr)
                ]),
                _Row(children: [const Text('Logout'), Text('Logout'.tr)]),
                _Row(children: [const Text('Log In'), Text('Log In'.tr)]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// A Popupmenu to display the app's available Locales.
  void langPopup() {
    //
    final locales = AppLocales().localeNames;

    for (int cnt = 0; cnt < locales.length; cnt++) {
      //
      _menuItems.add(
        PopupMenuItem(
          onTap: () {
            L10n.setAppLocale(locales[cnt].keys.first);
            setState(() {});
          },
          child: Text(locales[cnt].values.first),
        ),
      );
    }
  }

  /// Popup menu
  Widget get _popupMenu {
    return PopupMenuButton<String>(
      initialValue: 'English',
      itemBuilder: (context) => _menuItems,
    );
  }
}

class _Row extends Row {
  _Row({
    Key? key,
    MainAxisAlignment? mainAxisAlignment,
    MainAxisSize? mainAxisSize,
    CrossAxisAlignment? crossAxisAlignment,
    TextDirection? textDirection,
    VerticalDirection? verticalDirection,
    TextBaseline? textBaseline,
    List<Widget>? children,
  }) : super(
          key: key,
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.spaceAround,
          mainAxisSize: mainAxisSize ?? MainAxisSize.min,
          crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
          textDirection: textDirection,
          verticalDirection: verticalDirection ?? VerticalDirection.down,
          textBaseline: textBaseline,
          children: children ?? const <Widget>[],
        );
}
