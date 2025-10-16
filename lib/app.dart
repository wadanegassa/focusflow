import 'package:flutter/material.dart';
import 'package:task/route.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Focus Flow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[200],
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: Routes.getRoutes(),
    );
  }
}