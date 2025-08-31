import 'package:delivery/core/constants/colors.dart';
import 'package:delivery/core/constants/const.dart';
import 'package:delivery/core/constants/functions.dart';
import 'package:delivery/core/widgets/my_animation.dart';
import 'package:delivery/core/widgets/my_app_bar.dart';
import 'package:delivery/core/widgets/my_button.dart';
import 'package:delivery/core/widgets/my_card.dart';
import 'package:delivery/core/widgets/my_snackbar.dart';
import 'package:delivery/core/widgets/my_text.dart';
import 'package:delivery/data/model/delivery/delivery_company_data_model.dart';
import 'package:delivery/data/model/delivery/delivery_detail_model.dart';
import 'package:delivery/presentation/business_logic/cubit/delivery/delivery_cubit.dart';
import 'package:delivery/presentation/business_logic/cubit/delivery/delivery_state.dart';
import 'package:delivery/presentation/business_logic/cubit/order/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';

class deliveryDetails extends StatefulWidget {
  final DeliveryDetailModel delivery;

  const deliveryDetails({super.key, required this.delivery});

  @override
  State<deliveryDetails> createState() => _deliveryDetailsState();
}

class _deliveryDetailsState extends State<deliveryDetails> {
  late OrderCubit orderCubit;
  late DeliveryCubit deliveryCubit;
  DeliveryCompanyDataModel? selectedDeliveryCompany;
  bool showDeliveryDetails = false;
  bool noDeliverySelected = false;
  OrderStateEnum? selectedStatus;
  @override
  void initState() {
    orderCubit = OrderCubit();
    deliveryCubit = DeliveryCubit();
    deliveryCubit.getDeliveryCompanyById();
    deliveryCubit.getDeliveries();
    super.initState();
    selectedStatus = null;
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'ar', symbol: '\$');
    final isOnDelivery = widget.delivery.order?.orderState == 'جاري التوصيل';

    return Scaffold(
      appBar: myAppBar(
        title: "orderDetails".tr,
        context: context,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Status Card
            _buildInfoCard(
              "currentStatus".tr,
              widget.delivery.order?.orderState?.name ?? "",
              icon: Icons.info_outline,
              iconColor: AppColor.kPrimaryColor,
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              "deliveryCompany".tr,
              CompanySession.name ?? "unknown".tr,
              icon: Icons.card_membership_outlined,
              iconColor: AppColor.kPrimaryColor,
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              "customerNote".tr,
              widget.delivery.notes ?? "unknown".tr,
              icon: Icons.info_outline,
              iconColor: AppColor.kPrimaryColor,
            ),

            // Products Table
            _buildProductTable(currencyFormat),
            const SizedBox(height: 24),
            // Total Section
            _buildTotalSection(currencyFormat),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomActionBar(isOnDelivery),
    );
  }

  Widget _buildInfoCard(String label, String value,
      {IconData? icon, Color? iconColor}) {
    return MyAnimation(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColor.kSecondColor)),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: iconColor),
              const SizedBox(width: 8),
            ],
            Expanded(
                child: CairoText(
              label,
              color: Colors.grey[600],
              fontSize: 11,
            )),
            CairoText(
              value,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductTable(NumberFormat currencyFormat) {
    final items = widget.delivery.order?.orderItems ?? [];

    return MyAnimation(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.primary),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(6),
                1: FlexColumnWidth(4),
                2: FlexColumnWidth(3),
                3: FlexColumnWidth(4),
              },
              border: TableBorder.symmetric(
                inside:
                    BorderSide(color: Theme.of(context).colorScheme.primary),
              ),
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                          child: CairoText(
                        "productName".tr,
                        color: Colors.white,
                        fontSize: 13,
                      )),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                          child: CairoText(
                        "quantity".tr,
                        fontSize: 13,
                        color: Colors.white,
                      )),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                          child: CairoText(
                        'price'.tr,
                        fontSize: 13,
                        color: Colors.white,
                      )),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                          child: CairoText(
                        'total'.tr,
                        fontSize: 13,
                        color: Colors.white,
                      )),
                    ),
                  ],
                ),
                ...items.map((item) {
                  final name = item.productName ?? '—';
                  final qty = item.quantity ?? 0;
                  final price = item.price ?? 0.0;
                  final total = qty * price;

                  return TableRow(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSurface ==
                                Colors.white
                            ? Colors.transparent
                            : Colors.white
                        //  Colors.grey[300],
                        ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: CairoText(name, fontSize: 11)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: CairoText('$qty', fontSize: 11)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: CairoText(price.toStringAsFixed(2),
                                fontSize: 11)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: CairoText(total.toStringAsFixed(2),
                                fontSize: 11)),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalSection(NumberFormat currencyFormat) {
    double deliveryCost = selectedDeliveryCompany?.basePrice ?? 0;
    double orderTotal = widget.delivery.order?.totalAmount ?? 0;
    double grandTotal = orderTotal + deliveryCost;

    return MyAnimation(
      child: MyCard(
        padding: EdgeInsets.zero,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColor.kSecondColor),
          ),
          child: Column(
            children: [
              _buildTotalRow(
                  'orderTotal'.tr, currencyFormat.format(orderTotal)),
              _buildTotalRow(
                'deliveryCost'.tr,
                selectedDeliveryCompany != null
                    ? currencyFormat.format(deliveryCost)
                    : '—',
              ),
              const Divider(height: 20),
              _buildTotalRow(
                'grandTotal'.tr,
                currencyFormat.format(grandTotal),
                isBold: true,
                color: AppColor.kPrimaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTotalRow(String label, String value,
      {bool isBold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CairoText(
            label,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: 13,
          ),
          CairoText(
            value,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: color,
            fontSize: 13,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActionBar(bool isOnDelivery) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDropDownWidget(),
          MyAnimation(
            child: MyButton(
              text: "changeOrderStatus".tr,
              onPressed: () async {
                if (selectedStatus != null) {
                  widget.delivery.order?.orderState = selectedStatus!;
                  widget.delivery.status = 4;
                  deliveryCubit.updateDelivery(
                      widget.delivery.id ?? "", widget.delivery);
                  MySnackbar.showSuccess(context, "orderStatusUpdated".tr);
                  deliveryCubit.getDeliveries();
                  Get.back();
                } else {
                  MySnackbar.showError(context, "pleaseSelectOrderStatus".tr);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropDownWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      margin: EdgeInsets.symmetric(horizontal: 22),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface == Colors.white
            ? AppColor.kSecondColorDarkMode
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<OrderStateEnum?>(
          value: selectedStatus,
          isExpanded: true,
          hint: CairoText(
            'selectOrderStatus'.tr, // المفتاح للترجمة
            fontSize: 13,
          ),
          icon: Icon(Icons.arrow_drop_down,
              color: Theme.of(context).colorScheme.onSurface),
          dropdownColor: Theme.of(context).colorScheme.onSurface == Colors.white
              ? AppColor.kSecondColorDarkMode
              : Colors.grey.shade100,
          onChanged: (OrderStateEnum? newValue) {
            setState(() {
              selectedStatus = newValue;
            });
          },
          items: [
            DropdownMenuItem<OrderStateEnum?>(
              value: null,
              child: CairoText(
                'selectOrderStatus'.tr,
                fontSize: 13,
              ),
            ),
            ...OrderStateEnum.values.map((OrderStateEnum status) {
              return DropdownMenuItem<OrderStateEnum>(
                value: status,
                child: CairoText(
                  getStatusText(status),
                  fontSize: 13,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  String getStatusText(OrderStateEnum status) {
    switch (status) {
      case OrderStateEnum.pending:
        return 'pending'.tr;
      case OrderStateEnum.scheduled:
        return 'scheduled'.tr;
      case OrderStateEnum.inTransit:
        return 'inTransit'.tr;
      case OrderStateEnum.delivered:
        return 'delivered'.tr;
      case OrderStateEnum.failed:
        return 'failed'.tr;
      case OrderStateEnum.cancelled:
        return 'cancelled'.tr;
    }
  }
}
