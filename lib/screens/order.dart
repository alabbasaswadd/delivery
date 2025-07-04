import 'package:flutter/material.dart';
import 'package:delivery/models.dart';
import 'package:delivery/screens/card.dart';
import 'package:delivery/screens/details.dart';
import 'package:delivery/screens/tracking.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order> orders = [
    Order(
      id: '12345',
      customerName: 'محمد أحمد',
      address: 'شارع الملك فهد، الرياض',
      total: 120.0,
      status: 'قيد التوصيل',
      items: ['حاسوب محمول', 'هاتف ذكي'],
      storeLocation: const LatLng(24.7136, 46.6753),
      deliveryLocation: const LatLng(24.7236, 46.6853),
      currentDriverLocation: const LatLng(24.7156, 46.6783),
      routePolyline: [
        const LatLng(24.7136, 46.6753),
        const LatLng(24.7145, 46.6762),
        const LatLng(24.7156, 46.6783),
        const LatLng(24.7180, 46.6810),
        const LatLng(24.7236, 46.6853),
      ],
    ),
    Order(
      id: '12346',
      customerName: 'أحمد خالد',
      address: 'حي النخيل، جدة',
      total: 85.5,
      status: 'تم التوصيل',
      items: ['سماعات لاسلكية', 'حافظة هاتف'],
      storeLocation: const LatLng(21.5433, 39.1728),
      deliveryLocation: const LatLng(21.5533, 39.1828),
      currentDriverLocation: null,
      routePolyline: null,
    ),
  ];

  String _selectedFilter = 'الكل';

  @override
  Widget build(BuildContext context) {
    final filteredOrders = _selectedFilter == 'الكل'
        ? orders
        : orders.where((o) => o.status == _selectedFilter).toList();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'الطلبات',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue[800],
        actions: [
          IconButton(
            icon: Icon(Icons.search, size: 28),
            onPressed: () {
              // إضافة وظيفة البحث هنا
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _selectedFilter = value;
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'الكل',
                child: Text('عرض الكل'),
              ),
              PopupMenuItem(
                value: 'قيد التوصيل',
                child: Text('قيد التوصيل'),
              ),
              PopupMenuItem(
                value: 'تم التوصيل',
                child: Text('تم التوصيل'),
              ),
            ],
            icon: Icon(Icons.filter_list, size: 28),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildStatusFilter(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                // إضافة وظيفة تحديث البيانات هنا
                await Future.delayed(Duration(seconds: 1));
              },
              child: ListView.separated(
                padding: EdgeInsets.all(16),
                itemCount: filteredOrders.length,
                separatorBuilder: (context, index) => SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetailScreen(
                            order: filteredOrders[index],
                            onTrackOrder: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      TrackingScreen(order: filteredOrders[index]),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                    child: OrderCard(order: filteredOrders[index]),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusFilter() {
    final statuses = ['الكل', 'قيد التوصيل', 'تم التوصيل'];
    
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: statuses.length,
        separatorBuilder: (context, index) => SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = _selectedFilter == statuses[index];
          return ChoiceChip(
            label: Text(statuses[index]),
            selected: isSelected,
            onSelected: (selected) {
              setState(() {
                _selectedFilter = statuses[index];
              });
            },
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : Colors.blue[800],
              fontWeight: FontWeight.bold,
            ),
            selectedColor: Colors.blue[800],
            backgroundColor: Colors.grey[200],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          );
        },
      ),
    );
  }
}