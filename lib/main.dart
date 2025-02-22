import 'package:antisleep/app.dart';
import 'package:antisleep/data/storage.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Storage.instance.init();
  runApp(const MainApp());
}
