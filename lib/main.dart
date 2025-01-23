import 'package:flutter/material.dart';
import 'package:todo_app/application/features/general/presentation/screens/home/home.dart';

import 'application/config/themes/theme.dart';
import 'application/di/di_container.dart';


void main() {
  setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo',
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const HomeScreen(),
    );
  }
}

