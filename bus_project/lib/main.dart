import 'package:flutter/material.dart';
import 'package:mid_bus_project/Screens/splash.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:Splash(),
        
      )
    ;
  }
}
