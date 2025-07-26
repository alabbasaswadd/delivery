import 'package:delivery/presentation/screens/home_screen.dart';
import 'package:delivery/presentation/screens/onboarding.dart';
import 'package:delivery/presentation/screens/order.dart';
import 'package:delivery/presentation/screens/settings.dart';
import 'package:delivery/presentation/screens/splash.dart';
import 'package:flutter/material.dart';
import 'presentation/screens/auth/signup.dart';
import 'presentation/screens/auth/login.dart';

Map<String, Widget Function(BuildContext)> routes = {
  Login.id: (context) => Login(),
  SignUp.id: (context) => SignUp(),
  Splash.id: (context) => Splash(),
  Onboarding.id: (context) => Onboarding(),
  SettingsScreen.id: (context) => SettingsScreen(),
  HomeScreen.id: (context) => HomeScreen(),
  OrdersScreen.id: (context) => OrdersScreen(),
};
