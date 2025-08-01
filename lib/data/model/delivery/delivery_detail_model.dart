import 'package:delivery/data/model/delivery/delivery_company_data_model.dart';
import 'package:delivery/data/model/order/order_data_model.dart';
import 'package:delivery/data/model/shop/shop_data_model.dart';
import 'package:delivery/data/model/user/user_address_model.dart';
import 'package:delivery/data/model/user/user_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delivery_detail_model.g.dart';

@JsonSerializable()
class DeliveryDetailModel {
  final String? id;
  final String? trackingNumber;
  int? status;
  final String? scheduledDate;
  final String? shippedDate;
  final String? deliveredDate;
  final String? notes;
  final double? deliveryCost;
  final bool? isPaid;
  final String? createdAt;
  final String? updatedAt;
  final OrderDataModel? order;
  final DeliveryCompanyDataModel? deliveryCompany;
  final ShopDataModel? shop;
  final UserDataModel? customer;
  final UserAddressModel? address;

  DeliveryDetailModel({
    this.id,
    this.trackingNumber,
    this.status,
    this.scheduledDate,
    this.shippedDate,
    this.deliveredDate,
    this.notes,
    this.deliveryCost,
    this.isPaid,
    this.createdAt,
    this.updatedAt,
    this.deliveryCompany,
    this.order,
    this.shop,
    this.customer,
    this.address,
  });

  factory DeliveryDetailModel.fromJson(Map<String, dynamic> json) =>
      _$DeliveryDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$DeliveryDetailModelToJson(this);
}
