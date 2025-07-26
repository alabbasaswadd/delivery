import 'package:delivery/core/constants/colors.dart';
import 'package:delivery/core/widgets/my_app_bar.dart';
import 'package:delivery/presentation/business_logic/cubit/order/order_cubit.dart';
import 'package:delivery/presentation/business_logic/cubit/order/order_state.dart';
import 'package:delivery/presentation/screens/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});
  static String id = "order";
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late OrderCubit cubit;
  @override
  void initState() {
    cubit = OrderCubit();
    cubit.getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: myAppBar(context: context, title: "orders".tr),
      body: Column(
        children: [
          // _buildStatusFilter(),
          Expanded(
            child: BlocConsumer<OrderCubit, OrderState>(
              bloc: cubit,
              listener: (context, state) {
                if (state is OrderError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error)),
                  );
                }
              },
              builder: (context, state) {
                if (state is OrderLoading) {
                  return Center(
                    child: SpinKitChasingDots(color: AppColor.kPrimaryColor),
                  );
                } else if (state is OrderLoaded) {
                  final allOrders = state.orders;
                  return ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: allOrders.length,
                    itemBuilder: (context, index) {
                      final order = allOrders[index];
                      return OrderCard(order: order);
                    },
                  );
                } else if (state is OrderEmpty) {
                  return Center(child: Text('لا توجد طلبات حاليًا.'));
                } else {
                  return Center(child: Text('حدث خطأ غير متوقع.'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildStatusFilter() {
  //   final statuses = ['الكل', 'قيد التوصيل', 'تم التوصيل'];
  //   return Container(
  //     height: 60,
  //     padding: EdgeInsets.symmetric(horizontal: 16),
  //     child: ListView.separated(
  //       scrollDirection: Axis.horizontal,
  //       itemCount: statuses.length,
  //       separatorBuilder: (_, __) => SizedBox(width: 8),
  //       itemBuilder: (_, index) {
  //         final status = statuses[index];
  //         final isSelected = _selectedFilter == status;
  //         return ChoiceChip(
  //           label: Text(status),
  //           selected: isSelected,
  //           onSelected: (_) => setState(() => _selectedFilter = status),
  //           labelStyle: TextStyle(
  //             color: isSelected ? Colors.white : Colors.blue[800],
  //             fontWeight: FontWeight.bold,
  //           ),
  //           selectedColor: Colors.blue[800],
  //           backgroundColor: Colors.grey[200],
  //         );
  //       },
  //     ),
  //   );
  // }
}
