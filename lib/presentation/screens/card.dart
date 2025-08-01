// import 'package:delivery/core/constants/colors.dart';
// import 'package:delivery/core/constants/const.dart';
// import 'package:delivery/core/widgets/my_animation.dart';
// import 'package:delivery/core/widgets/my_card.dart';
// import 'package:delivery/core/widgets/my_text.dart';
// import 'package:delivery/data/model/delivery/delivery_detail_model.dart';
// import 'package:delivery/presentation/screens/details.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// class OrderCard extends StatelessWidget {
//   final DeliveryDetailModel delivery;

//   const OrderCard({super.key, required this.delivery});

//   @override
//   Widget build(BuildContext context) {
//     return MyAnimation(
//       child: InkWell(
//         onTap: () {
//           Get.to(deliveryDetails(delivery: delivery));
//         },
//         child: MyCard(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Header with order number and status
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     CairoText(
//                       "${"order".tr}${delivery.id}",
//                       color: Colors.black87,
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16),

//                 // Order details in a beautiful layout
//                 Row(
//                   children: [
//                     Container(
//                       padding: EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: Colors.blue[50],
//                         shape: BoxShape.circle,
//                       ),
//                       child:
//                           Icon(Icons.store, color: Colors.blue[700], size: 20),
//                     ),
//                     SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           CairoText(
//                             "shop".tr,
//                             color: Colors.grey[600],
//                           ),
//                           CairoText(
//                               '${delivery.shop?.firstName ?? "unknown".tr} ${delivery.shop?.lastName ?? ""}'),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 12),
//                 Row(
//                   children: [
//                     Container(
//                       padding: EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: Colors.orange[50],
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(Icons.access_time,
//                           color: Colors.orange[700], size: 20),
//                     ),
//                     SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           CairoText(
//                             "order_date".tr,
//                             color: Colors.grey[600],
//                           ),
//                           CairoText(formatDateString(
//                               delivery.deliveredDate.toString())),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16),
//                 Divider(
//                   height: 1,
//                   thickness: 1,
//                   color: Colors.grey[200],
//                 ),
//                 SizedBox(height: 12),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     CairoText("total".tr, color: Colors.grey[600]),
//                     CairoText(
//                       "total",
//                       color: AppColor.kPrimaryColor,
//                     ),
//                     Container(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                       decoration: BoxDecoration(
//                         color: getStatusColor(delivery.order?.orderState),
//                         borderRadius: BorderRadius.circular(20),
//                         gradient: getStatusGradient(delivery.order?.orderState),
//                       ),
//                       child: CairoText(
//                         delivery.status.toString(),
//                         color: Colors.white,
//                         fontSize: 11,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   String formatDateString(String? rawDate) {
//     if (rawDate == null || rawDate.isEmpty) return '';

//     try {
//       final utcDate = DateTime.parse(rawDate).toLocal();
//       final formatter = DateFormat(
//           'd MMMM yyyy - hh:mm:ss a', 'ar'); // 12 ساعة و صباحًا/مساءً
//       return formatter.format(utcDate);
//     } catch (e) {
//       return '';
//     }
//   }

//   Color getStatusColor(OrderStateEnum? status) {
//     switch (status) {
//       case OrderStateEnum.pending:
//         return Colors.blue;
//       case OrderStateEnum.scheduled:
//         return Colors.teal;
//       case OrderStateEnum.inTransit:
//         return Colors.orange;
//       case OrderStateEnum.delivered:
//         return Colors.green;
//       case OrderStateEnum.cancelled:
//         return Colors.red;
//       case OrderStateEnum.failed:
//         return Colors.grey;
//       default:
//         return Colors.grey;
//     }
//   }

//   LinearGradient getStatusGradient(OrderStateEnum? status) {
//     switch (status) {
//       case OrderStateEnum.pending:
//         return LinearGradient(colors: [Colors.blue[300]!, Colors.blue[600]!]);
//       case OrderStateEnum.scheduled:
//         return LinearGradient(colors: [Colors.teal[300]!, Colors.teal[600]!]);
//       case OrderStateEnum.inTransit:
//         return LinearGradient(
//             colors: [Colors.orange[300]!, Colors.orange[600]!]);
//       case OrderStateEnum.delivered:
//         return LinearGradient(colors: [Colors.green[400]!, Colors.green[600]!]);
//       case OrderStateEnum.cancelled:
//         return LinearGradient(colors: [Colors.red[300]!, Colors.red[600]!]);
//       case OrderStateEnum.failed:
//         return LinearGradient(colors: [Colors.grey[400]!, Colors.grey[700]!]);
//       default:
//         return LinearGradient(colors: [Colors.grey[400]!, Colors.grey[600]!]);
//     }
//   }
// }
