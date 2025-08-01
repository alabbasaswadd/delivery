import 'package:delivery/core/constants/colors.dart';
import 'package:delivery/core/constants/const.dart';
import 'package:delivery/core/widgets/my_animation.dart';
import 'package:delivery/core/widgets/my_app_bar.dart';
import 'package:delivery/core/widgets/my_card.dart';
import 'package:delivery/core/widgets/my_text.dart';
import 'package:delivery/data/model/delivery/delivery_detail_model.dart';
import 'package:delivery/presentation/business_logic/cubit/delivery/delivery_cubit.dart';
import 'package:delivery/presentation/business_logic/cubit/delivery/delivery_state.dart';
import 'package:delivery/presentation/screens/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class Deliveries extends StatefulWidget {
  const Deliveries({super.key});
  static String id = "deliveries";

  @override
  State<Deliveries> createState() => _DeliveriesState();
}

class _DeliveriesState extends State<Deliveries> with TickerProviderStateMixin {
  late DeliveryCubit cubit;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    cubit = DeliveryCubit();
    cubit.getDeliveries();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: myAppBar(context: context, title: 'deliveries'.tr),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: TabBar(
              labelStyle: TextStyle(fontFamily: "Cairo-Bold", fontSize: 10),
              controller: _tabController,
              labelColor: AppColor.kPrimaryColor,
              unselectedLabelColor: Colors.grey,
              indicatorColor: AppColor.kPrimaryColor,
              tabs: [
                Tab(text: 'all'.tr),
                Tab(text: 'in_transit'.tr),
                Tab(text: 'delivered'.tr),
                Tab(text: 'cancelled'.tr),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<DeliveryCubit, DeliveryState>(
              bloc: cubit,
              builder: (context, state) {
                if (state is DeliveryLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is DeliveryLoaded) {
                  final all = state.deliveries;
                  final inTransit = all
                      .where((d) =>
                          d.order?.orderState == OrderStateEnum.inTransit)
                      .toList();
                  final delivered = all
                      .where((d) =>
                          d.order?.orderState == OrderStateEnum.delivered)
                      .toList();
                  final cancelled = all
                      .where((d) =>
                          d.order?.orderState == OrderStateEnum.cancelled)
                      .toList();

                  return TabBarView(
                    controller: _tabController,
                    children: [
                      buildDeliveryList(all),
                      buildDeliveryList(inTransit),
                      buildDeliveryList(delivered),
                      buildDeliveryList(cancelled),
                    ],
                  );
                }
                if (state is DeliveryEmpty) {
                  return Center(child: CairoText("no_orders".tr));
                } else if (state is DeliveryError) {
                  return Center(child: CairoText("error_occurred".tr));
                } else {
                  return Center(child: CairoText("error_occurred".tr));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDeliveryList(List<DeliveryDetailModel> list) {
    if (list.isEmpty) {
      return Center(child: CairoText("no_orders_in_category".tr));
    }
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final delivery = list[index];
        return MyAnimation(
          child: InkWell(
            onTap: () => Get.to(deliveryDetails(delivery: delivery)),
            child: MyCard(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: buildDeliveryCard(delivery),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildDeliveryCard(DeliveryDetailModel delivery) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CairoText(
              "${'order_number'.tr} #${delivery.order?.totalAmount}",
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green[50],
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.person, color: Colors.green, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CairoText("customer".tr, color: Colors.grey[600]),
                  CairoText(
                    '${delivery.customer?.firstName ?? "unknown".tr} ${delivery.customer?.lastName ?? "unknown".tr}',
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.store, color: Colors.blue[700], size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CairoText("store".tr, color: Colors.grey[600]),
                  CairoText(
                    '${delivery.shop?.firstName ?? "unknown".tr} ${delivery.shop?.lastName ?? "unknown".tr}',
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                shape: BoxShape.circle,
              ),
              child:
                  Icon(Icons.access_time, color: Colors.orange[700], size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CairoText("order_date".tr, color: Colors.grey[600]),
                  CairoText(
                      formatDateString(delivery.order?.orderDate.toString())),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Divider(height: 1, thickness: 1, color: Colors.grey[200]),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CairoText("total".tr, color: Colors.grey[600]),
            CairoText(
              "${(delivery.order?.totalAmount ?? 0).toStringAsFixed(2)}\$",
              color: AppColor.kPrimaryColor,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: getStatusColor(delivery.order?.orderState),
                borderRadius: BorderRadius.circular(20),
                gradient: getStatusGradient(delivery.order?.orderState),
              ),
              child: CairoText(
                delivery.order?.orderState?.name.tr ?? "unknown".tr,
                color: Colors.white,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String formatDateString(String? rawDate) {
    if (rawDate == null || rawDate.isEmpty) return '';
    try {
      final utcDate = DateTime.parse(rawDate);
      final formatter = DateFormat('d MMMM yyyy - hh:mm:ss a', 'ar');
      return formatter.format(utcDate);
    } catch (e) {
      return '';
    }
  }

  LinearGradient getStatusGradient(OrderStateEnum? status) {
    switch (status) {
      case OrderStateEnum.pending:
        return LinearGradient(colors: [Colors.blue[300]!, Colors.blue[600]!]);
      case OrderStateEnum.scheduled:
        return LinearGradient(colors: [Colors.teal[300]!, Colors.teal[600]!]);
      case OrderStateEnum.inTransit:
        return LinearGradient(
            colors: [Colors.orange[300]!, Colors.orange[600]!]);
      case OrderStateEnum.delivered:
        return LinearGradient(colors: [Colors.green[400]!, Colors.green[600]!]);
      case OrderStateEnum.cancelled:
        return LinearGradient(colors: [Colors.red[300]!, Colors.red[600]!]);
      case OrderStateEnum.failed:
        return LinearGradient(colors: [Colors.grey[400]!, Colors.grey[700]!]);
      default:
        return LinearGradient(colors: [Colors.grey[400]!, Colors.grey[600]!]);
    }
  }

  Color getStatusColor(OrderStateEnum? status) {
    switch (status) {
      case OrderStateEnum.pending:
        return Colors.blue;
      case OrderStateEnum.scheduled:
        return Colors.teal;
      case OrderStateEnum.inTransit:
        return Colors.orange;
      case OrderStateEnum.delivered:
        return Colors.green;
      case OrderStateEnum.cancelled:
        return Colors.red;
      case OrderStateEnum.failed:
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }
}
