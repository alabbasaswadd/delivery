// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryDetailModel _$DeliveryDetailModelFromJson(Map<String, dynamic> json) =>
    DeliveryDetailModel(
      id: json['id'] as String?,
      trackingNumber: json['trackingNumber'] as String?,
      status: (json['status'] as num?)?.toInt(),
      scheduledDate: json['scheduledDate'] as String?,
      shippedDate: json['shippedDate'] as String?,
      deliveredDate: json['deliveredDate'] as String?,
      notes: json['notes'] as String?,
      deliveryCost: (json['deliveryCost'] as num?)?.toDouble(),
      isPaid: json['isPaid'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      order: json['order'] == null
          ? null
          : OrderDataModel.fromJson(json['order'] as Map<String, dynamic>),
      shop: json['shop'] == null
          ? null
          : ShopDataModel.fromJson(json['shop'] as Map<String, dynamic>),
      customer: json['customer'] == null
          ? null
          : UserDataModel.fromJson(json['customer'] as Map<String, dynamic>),
      address: json['address'] == null
          ? null
          : UserAddressModel.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DeliveryDetailModelToJson(
        DeliveryDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'trackingNumber': instance.trackingNumber,
      'status': instance.status,
      'scheduledDate': instance.scheduledDate,
      'shippedDate': instance.shippedDate,
      'deliveredDate': instance.deliveredDate,
      'notes': instance.notes,
      'deliveryCost': instance.deliveryCost,
      'isPaid': instance.isPaid,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'order': instance.order,
      'shop': instance.shop,
      'customer': instance.customer,
      'address': instance.address,
    };
