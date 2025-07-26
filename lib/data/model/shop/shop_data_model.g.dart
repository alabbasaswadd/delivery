// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopDataModel _$ShopDataModelFromJson(Map<String, dynamic> json) =>
    ShopDataModel(
      id: json['id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      phone: json['phone'] as String?,
      addressId: json['addressId'] as String?,
      email: json['email'] as String?,
      image: json['image'] as String?,
      address: json['address'],
    );

Map<String, dynamic> _$ShopDataModelToJson(ShopDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phone': instance.phone,
      'addressId': instance.addressId,
      'email': instance.email,
      'image': instance.image,
      'address': instance.address,
    };
