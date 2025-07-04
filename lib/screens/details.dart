import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:delivery/models.dart';
import 'package:delivery/screens/map.dart';
import 'package:delivery/screens/tracking.dart';

class OrderDetailScreen extends StatelessWidget {
  final Order order;
  final VoidCallback onTrackOrder;

  const OrderDetailScreen({
    required this.order,
    required this.onTrackOrder,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDelivered = order.status == 'تم التوصيل';
    final theme = Theme.of(context);
    final currencyFormat = NumberFormat.currency(locale: 'ar', symbol: 'ر.س');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تفاصيل الطلب #${order.id}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => _shareOrderDetails(context),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: _buildStatusHeader(isDelivered),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildCustomerCard(theme),
                const SizedBox(height: 16),
                _buildOrderDetailsCard(theme, currencyFormat),
                const SizedBox(height: 24),
                _buildDeliveryMap(),
                const SizedBox(height: 24),
              ]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildActionButtons(isDelivered, context),
    );
  }

  Widget _buildStatusHeader(bool isDelivered) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDelivered ? Colors.green[50] : Colors.orange[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDelivered ? Colors.green[100]! : Colors.orange[100]!,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isDelivered ? Icons.check_circle : Icons.timer,
            color: isDelivered ? Colors.green : Colors.orange,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'حالة الطلب: ${order.status}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDelivered ? Colors.green[800] : Colors.orange[800],
                  ),
                ),
                if (!isDelivered)
                  Text(
                    'الوقت المتوقع للتوصيل: خلال 30 دقيقة',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
              ],
            ),
          ),
          if (!isDelivered)
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
              strokeWidth: 3,
            ),
        ],
      ),
    );
  }

  Widget _buildCustomerCard(ThemeData theme) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.person_outline, color: theme.primaryColor),
                const SizedBox(width: 8),
                Text(
                  'معلومات العميل',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildDetailRow('الاسم', order.customerName),
            _buildDetailRow('رقم الهاتف', '0501234567'),
            _buildDetailRow('العنوان', order.address),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderDetailsCard(ThemeData theme, NumberFormat currencyFormat) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.shopping_bag_outlined, color: theme.primaryColor),
                const SizedBox(width: 8),
                Text(
                  'تفاصيل الطلب',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildDetailRow('رقم الطلب', '#${order.id}'),
            _buildDetailRow('تاريخ الطلب', '2023-11-15 10:30 ص'),
            const Divider(height: 24),
            Text(
              'المنتجات',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            ...order.items.map((item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Icon(Icons.circle, size: 6, color: Colors.grey[500]),
                      const SizedBox(width: 12),
                      Text(item),
                    ],
                  ),
                )),
            const Divider(height: 24),
            _buildDetailRow(
              'الإجمالي',
              currencyFormat.format(order.total),
              valueStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: theme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {TextStyle? valueStyle}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: valueStyle ??
                  TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800],
                  ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryMap() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Icon(Icons.location_on_outlined, color: Colors.blue[700]),
              const SizedBox(width: 8),
              Text(
                'مسار التوصيل',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: MapWidget(
              initialLocation: order.storeLocation,
              destination: order.address,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(bool isDelivered, BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            if (!isDelivered)
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.directions_bike),
                  label: const Text('تتبع الطلب'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: onTrackOrder,
                ),
              ),
            if (!isDelivered) const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isDelivered ? Colors.grey[300] : Colors.green,
                  foregroundColor:
                      isDelivered ? Colors.grey[600] : Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: isDelivered
                    ? null
                    : () {
                        // تحديث حالة الطلب
                        _confirmDelivery(context);
                      },
                child: Text(isDelivered ? 'تم التوصيل' : 'تأكيد التسليم'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _shareOrderDetails(BuildContext context) {
    // TODO: تنفيذ مشاركة تفاصيل الطلب
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم نسخ تفاصيل الطلب للمشاركة')),
    );
  }

  void _confirmDelivery(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تأكيد التسليم'),
        content: const Text('هل أنت متأكد من أن الطلب قد تم تسليمه للعميل؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم تحديث حالة الطلب بنجاح')),
              );
            },
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );
  }
}
