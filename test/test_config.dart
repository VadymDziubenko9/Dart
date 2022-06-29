import 'dart:io';

import 'package:yaml/yaml.dart';

class TestConfiguration {
  TestConfiguration(String fileName) {
    var yaml = loadYaml(File(fileName).readAsStringSync());
    driverPath = yaml['driverPath'];
    headless = yaml['headless'];
    maxWaitMillis = yaml['maxWaitMillis'];
    ignoreSetup = yaml['ignoreSetup'];
  }

  late final String driverPath;

  late final bool headless;

  late final int maxWaitMillis;

  late final bool ignoreSetup;
}