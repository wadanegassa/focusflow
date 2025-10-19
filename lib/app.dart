import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/route.dart';
import 'package:task/services/theme_service.dart';
import 'package:task/services/task_service.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeService()),
        ChangeNotifierProvider(create: (_) => TaskService()),
      ],
      child: Consumer<ThemeService>(
        builder: (context, themeService, child) {
          return MaterialApp(
            title: 'Focus Flow',
            debugShowCheckedModeBanner: false,
            theme: themeService.lightTheme,
            darkTheme: themeService.darkTheme,
            themeMode: themeService.themeMode,
            initialRoute: '/',
            routes: Routes.getRoutes(),
          );
        },
      ),
    );
  }
}