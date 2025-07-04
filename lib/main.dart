import 'package:delivery/screens/login.dart';
import 'package:delivery/screens/order.dart';
import 'package:delivery/screens/report.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DeliveryApp());
}

class DeliveryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'تطبيق التوصيل',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Tajawal',
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => ProfessionalLoginScreen(),
        '/orders': (context) => OrdersScreen(),
        '/report': (context) => CustomerReportsScreen(),
      },
    );
  }
}
