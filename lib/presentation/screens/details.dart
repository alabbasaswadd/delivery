import 'package:delivery/core/constants/const.dart';
import 'package:delivery/core/widgets/my_text.dart';
import 'package:delivery/presentation/business_logic/cubit/order/order_cubit.dart';
import 'package:delivery/presentation/business_logic/cubit/order/order_state.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:delivery/data/model/order/order_data_model.dart';

class OrderDetailScreen extends StatefulWidget {
  final OrderDataModel order;

  const OrderDetailScreen({required this.order, super.key});
  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  late OrderCubit cubit;

  @override
  void initState() {
    cubit = OrderCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'ar', symbol: 'ر.س');
    final isOnDelivery = widget.order.orderState == 'جاري التوصيل';

    return Scaffold(
      appBar: AppBar(
        title: Text('الطلب #${widget.order.id}'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _rowInfo(
                    'الحالة الحالية:', widget.order.orderState?.name ?? ""),
                const SizedBox(height: 16),
                const SizedBox(height: 12),
                _buildProductTable(),
                const Divider(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'الإجمالي الكلي:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      currencyFormat.format(widget.order.totalAmount ?? 0),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton.icon(
          icon: const Icon(Icons.delivery_dining),
          label: Text(isOnDelivery ? 'جاري التوصيل' : 'بدء التوصيل'),
          style: ElevatedButton.styleFrom(
            backgroundColor: isOnDelivery ? Colors.grey : Colors.orange,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: isOnDelivery ? null : () => _startDelivery(context),
        ),
      ),
    );
  }

  Widget _buildProductTable() {
    final items = widget.order.orderItems ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Expanded(
                flex: 6,
                child: Text('المنتج',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            Expanded(
                flex: 2,
                child: Text('الكمية',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            Expanded(
                flex: 3,
                child: Text('السعر',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            Expanded(
                flex: 3,
                child: Text('الإجمالي',
                    style: TextStyle(fontWeight: FontWeight.bold))),
          ],
        ),
        const Divider(),
        ...items.map((item) {
          final name = item.productName ?? '—';
          final qty = item.quantity ?? 0;
          final price = item.price ?? 0.0;
          final total = qty * price;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Expanded(
                    flex: 6,
                    child: CairoText(
                      name,
                      fontSize: 11,
                      maxLines: 5,
                    )),
                Expanded(flex: 2, child: CairoText('$qty', fontSize: 13)),
                Expanded(
                    flex: 3,
                    child: CairoText(price.toStringAsFixed(2), fontSize: 13)),
                Expanded(
                    flex: 3,
                    child: CairoText(total.toStringAsFixed(2), fontSize: 13)),
              ],
            ),
          );
        }),
      ],
    );
  }

  void _startDelivery(BuildContext context) {
    widget.order.orderState = OrderStateEnum.inTransit;
    cubit.updateOrder(widget.order.id!, widget.order);
  }

  Widget _rowInfo(String label, String value) {
    return Row(
      children: [
        Expanded(
            child: Text(label, style: const TextStyle(color: Colors.grey))),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
