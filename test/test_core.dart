import 'dart:io';

import 'package:test/test.dart' as native_test;

import 'automation.dart';

void test(String name, Function() body, {native_test.Timeout? timeout}) {
  native_test.test(
    name,
        () async {
      try {
        await body();
      } catch (e) {
        createScreenshot(name);
        rethrow;
      }
    },
    timeout: timeout,
  );
}

void createScreenshot(String name) {
  if (!Automation.driverInitialized) return;
  var location = createShotsDir();
  var fileName = createFileName(name);
  File('./${location.path}/$fileName.png').writeAsBytesSync(Automation.driver.captureScreenshotAsList());
}

Directory createShotsDir() {
  var location = Directory('screenshots');
  if (!location.existsSync()) {
    location.createSync();
  }
  return location;
}

String createFileName(String testName) {
  var script = Platform.script.toString();
  var fileName = RegExp('.*\/([^\/]+)\.dart').firstMatch(script)!.group(1);
  var unitCaseName = fileName!.split('_').reversed.join('.');
  return unitCaseName + '.' + testName.replaceAll(' ', '_').replaceAll('.', '');
}