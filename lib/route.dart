import 'package:flutter/material.dart';
import 'package:task/screens/home.dart';
import 'package:task/screens/login.dart';
import 'package:task/screens/onboarding.dart';
import 'package:task/screens/register.dart';
import 'package:task/screens/splash_screen.dart';



class Routes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login'; // Added login route
  static const String register = '/register'; 
  static const String home = '/home';// Added register route



static Map<String, WidgetBuilder> getRoutes() {
  return {
    Routes.splash: (context) => const SplashScreen(),
    Routes.onboarding: (context) => const OnboardingScreen(),
    Routes.login: (context) => const LoginScreen(),
    Routes.register: (context) => const RegisterScreen(),
    Routes.home: (context) => const HomeScreen(), // Placeholder for HomeScreen
  };
 }
}