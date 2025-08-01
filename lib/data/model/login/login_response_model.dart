import 'package:delivery/core/api/errors/error_model.dart';
import 'package:delivery/data/model/login/login_response_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel {
  final bool? succeeded;
  final LoginResponseDataModel? data;
  final ErrorModel? errors;
  LoginResponseModel({
    this.succeeded,
    this.data,
    this.errors,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}
