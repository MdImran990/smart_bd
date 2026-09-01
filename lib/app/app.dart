import 'package:flutter/material.dart';

import '../features/home/presentation/screens/home_screen.dart';
import 'theme/app_theme.dart';

class SmartBDApp extends StatelessWidget {
  const SmartBDApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart BD',

      theme: AppTheme.lightTheme,

      home: const HomeScreen(),
    );
  }
}