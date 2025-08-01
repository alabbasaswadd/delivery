// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequestDataModel _$LoginRequestDataModelFromJson(
        Map<String, dynamic> json) =>
    LoginRequestDataModel(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$LoginRequestDataModelToJson(
        LoginRequestDataModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
