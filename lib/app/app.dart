import 'package:flutter/material.dart';

import 'routes/app_router.dart';
import 'theme/app_theme.dart';

class SmartBDApp extends StatelessWidget {
  const SmartBDApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Smart BD',
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}