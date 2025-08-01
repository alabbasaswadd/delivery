import 'package:json_annotation/json_annotation.dart';

part 'login_request_data_model.g.dart';

@JsonSerializable()
class LoginRequestDataModel {
  final String email;
  final String password;

  LoginRequestDataModel({
    required this.email,
    required this.password,
  });

  factory LoginRequestDataModel.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestDataModelToJson(this);
}
