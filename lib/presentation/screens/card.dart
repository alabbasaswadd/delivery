import 'package:delivery/core/constants/colors.dart';
import 'package:delivery/core/widgets/my_animation.dart';
import 'package:delivery/core/widgets/my_card.dart';
import 'package:delivery/core/widgets/my_text.dart';
import 'package:delivery/presentation/screens/details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:delivery/data/model/order/order_data_model.dart';

class OrderCard extends StatelessWidget {
  final OrderDataModel order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return MyAnimation(
      child: InkWell(
        onTap: () {
          Get.to(OrderDetailScreen(order: order));
        },
        child: MyCard(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with order number and status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CairoText(
                      "الطلب #${order.totalAmount}",
                      color: Colors.black87,
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // Order details in a beautiful layout
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        shape: BoxShape.circle,
                      ),
                      child:
                          Icon(Icons.store, color: Colors.blue[700], size: 20),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CairoText(
                            "المتجر",
                            color: Colors.grey[600],
                          ),
                          CairoText(
                              '${order.shop?.firstName ?? "غير"} ${order.shop?.lastName ?? "معروف"}'),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.orange[50],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.access_time,
                          color: Colors.orange[700], size: 20),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CairoText(
                            "تاريخ الطلب",
                            color: Colors.grey[600],
                          ),
                          CairoText(
                              formatDateString(order.orderDate.toString())),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey[200],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CairoText("الإجمالي", color: Colors.grey[600]),
                    CairoText(
                      "${order.totalAmount?.toStringAsFixed(2) ?? "0.00"} ر.س",
                      color: AppColor.kPrimaryColor,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _getStatusColor(
                            order.orderState?.name ?? "غير معروف"),
                        borderRadius: BorderRadius.circular(20),
                        gradient: _getStatusGradient(
                            order.orderState?.name ?? "غير معروف"),
                      ),
                      child: CairoText(
                        order.orderState?.name ?? "غير معروف",
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey[500]),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String formatDateString(String? rawDate) {
    if (rawDate == null || rawDate.isEmpty) return '';

    try {
      final utcDate = DateTime.parse(rawDate).toLocal();
      final formatter = DateFormat(
          'd MMMM yyyy - hh:mm:ss a', 'ar'); // 12 ساعة و صباحًا/مساءً
      return formatter.format(utcDate);
    } catch (e) {
      return '';
    }
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'مكتمل':
        return Colors.green;
      case 'قيد التنفيذ':
        return Colors.orange;
      case 'ملغى':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  LinearGradient _getStatusGradient(String status) {
    switch (status.toLowerCase()) {
      case 'مكتمل':
        return LinearGradient(colors: [Colors.green[400]!, Colors.green[600]!]);
      case 'قيد التنفيذ':
        return LinearGradient(
            colors: [Colors.orange[400]!, Colors.orange[600]!]);
      case 'ملغى':
        return LinearGradient(colors: [Colors.red[400]!, Colors.red[600]!]);
      default:
        return LinearGradient(colors: [Colors.grey[400]!, Colors.grey[600]!]);
    }
  }
}
