import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flut/main_handler.dart';
import 'package:flut/services/token_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Screenshot tests', () {
    setUpAll(() {
      TokenManager.getInstance().setToken('FAKETOKEN');
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
  });
}

Future<void> testRenderHome(
    WidgetTester tester, IntegrationTestWidgetsFlutterBinding binding) async {
  await tester.pumpWidget(MainHandler());
  await tester.pumpAndSettle();
  await binding.takeScreenshot('0-home');
}
