import 'package:google_maps_flutter/google_maps_flutter.dart';

class Order {
  final String id;
  final String customerName;
  final String address;
  final double total;
  final String status;
  final List<String> items;
  final LatLng storeLocation;
  final LatLng deliveryLocation;
  final List<LatLng>? routePolyline; // خط سير التوصيل
  final LatLng? currentDriverLocation; // موقع السائق الحالي

  Order({
    required this.id,
    required this.customerName,
    required this.address,
    required this.total,
    required this.status,
    required this.items,
    required this.storeLocation,
    required this.deliveryLocation,
    this.routePolyline,
    this.currentDriverLocation,
  });
}

class Customer {
  final String id;
  final String name;
  final String email;
  final String phone;
  final DateTime joinDate;
  final int orderCount;
  final double totalSpending;
  final String? lastOrderDate;

  Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.joinDate,
    required this.orderCount,
    required this.totalSpending,
    this.lastOrderDate,
  });
}
