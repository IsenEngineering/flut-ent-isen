import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flut/main.dart';
import 'package:flut/services/token_service.dart';
import 'package:flut/services/user_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Screenshot tests', () {
    setUpAll(() {
      TokenManager.getInstance().setToken('FAKETOKEN');
      UserManager.getInstance().setUsername('ronald.weasley');
      return Future(() async {
        WidgetsApp.debugAllowBannerOverride = false; // Hide the debug banner
        if (Platform.isAndroid) {
          await binding.convertFlutterSurfaceToImage();
        }
      });
    });

    testWidgets('render home', (tester) async {
      await testRenderHome(tester, binding);
    });

    testWidgets('render planning', (tester) async {
      await testRenderPlanning(tester, binding);
    });

    testWidgets('render notes', (tester) async {
      await testRenderNotes(tester, binding);
    });

    testWidgets('render absences', (tester) async {
      await testRenderAbsences(tester, binding);
    });
  });
}

Future<void> testRenderHome(
    WidgetTester tester, IntegrationTestWidgetsFlutterBinding binding) async {
  await tester.pumpWidget(MyApp(initialPage: 0));
  await tester.pumpAndSettle();
  await binding.takeScreenshot('0-home');
}

Future<void> testRenderPlanning(
    WidgetTester tester, IntegrationTestWidgetsFlutterBinding binding) async {
  await tester.pumpWidget(MyApp(initialPage: 1));
  await tester.pumpAndSettle();
  await binding.takeScreenshot('1-planning');
}

Future<void> testRenderNotes(
    WidgetTester tester, IntegrationTestWidgetsFlutterBinding binding) async {
  await tester.pumpWidget(MyApp(initialPage: 2));
  await tester.pumpAndSettle();
  await binding.takeScreenshot('2-notes');
}

Future<void> testRenderAbsences(
    WidgetTester tester, IntegrationTestWidgetsFlutterBinding binding) async {
  await tester.pumpWidget(MyApp(initialPage: 3));
  await tester.pumpAndSettle();
  await binding.takeScreenshot('3-absences');
}
