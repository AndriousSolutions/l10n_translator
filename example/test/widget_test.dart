import 'package:flutter_test/flutter_test.dart' show WidgetTester, testWidgets;

import 'package:integration_test/integration_test.dart'
    show IntegrationTestWidgetsFlutterBinding;

import 'package:example/src/view.dart';

void main() => testApp();

/// Also called in package's own testing file, test/widget_test.dart
void testApp() {
  //
  final app = MyApp(key: UniqueKey());

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
}
