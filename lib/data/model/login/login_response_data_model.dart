import 'package:json_annotation/json_annotation.dart';

part 'login_response_data_model.g.dart';

@JsonSerializable()
class LoginResponseDataModel {
  final String? token;
  final String? userName;
  final String? id;
  LoginResponseDataModel({
    this.token,
    this.userName,
    this.id,
  });

  factory LoginResponseDataModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseDataModelToJson(this);
}
