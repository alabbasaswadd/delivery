// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_company_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryCompanyDataModel _$DeliveryCompanyDataModelFromJson(
        Map<String, dynamic> json) =>
    DeliveryCompanyDataModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      contactPerson: json['contactPerson'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] == null
          ? null
          : DeliveryEmailModel.fromJson(json['email'] as Map<String, dynamic>),
      logoUrl: json['logoUrl'] as String?,
      website: json['website'] as String?,
      address: json['address'] as String?,
      coverageAreas: json['coverageAreas'],
      basePrice: (json['basePrice'] as num?)?.toDouble(),
      pricePerKm: (json['pricePerKm'] as num?)?.toDouble(),
      isActive: json['isActive'] as bool?,
      deliveries: (json['deliveries'] as List<dynamic>?)
          ?.map((e) => DeliveryDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DeliveryCompanyDataModelToJson(
        DeliveryCompanyDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'contactPerson': instance.contactPerson,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'website': instance.website,
      'address': instance.address,
      'coverageAreas': instance.coverageAreas,
      'basePrice': instance.basePrice,
      'pricePerKm': instance.pricePerKm,
      'isActive': instance.isActive,
      'logoUrl': instance.logoUrl,
      'deliveries': instance.deliveries,
    };
