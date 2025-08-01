// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseDataModel _$LoginResponseDataModelFromJson(
        Map<String, dynamic> json) =>
    LoginResponseDataModel(
      token: json['token'] as String?,
      userName: json['userName'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$LoginResponseDataModelToJson(
        LoginResponseDataModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'userName': instance.userName,
      'id': instance.id,
    };
