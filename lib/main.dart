import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'presentation/screens/myapp_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}
