// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequestDataModel _$RegisterRequestDataModelFromJson(
        Map<String, dynamic> json) =>
    RegisterRequestDataModel(
      name: json['name'] as String,
      contactPerson: json['contactPerson'] as String,
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
      website: json['website'] as String?,
      password: json['password'] as String,
      address: json['address'] as String,
      coverageAreas: json['coverageAreas'] as String?,
      basePrice: (json['basePrice'] as num).toDouble(),
      pricePerKm: (json['pricePerKm'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$RegisterRequestDataModelToJson(
        RegisterRequestDataModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'contactPerson': instance.contactPerson,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'website': instance.website,
      'password': instance.password,
      'address': instance.address,
      'coverageAreas': instance.coverageAreas,
      'basePrice': instance.basePrice,
      'pricePerKm': instance.pricePerKm,
    };
