import 'package:flutter/material.dart';

import 'app/main_app.dart';
import 'core/di/injectable_init.dart';

void main() {
  configureDependencies();
  runApp(const MainApp());
}
