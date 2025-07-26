import 'package:delivery/core/api/errors/error_model.dart';
import 'package:delivery/data/model/user/user_data_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_response_model.g.dart';

@JsonSerializable()
class UserResponseModel {
  final bool succeeded;
  final List<UserDataModel>? data;
  final ErrorModel? errors;
  UserResponseModel({required this.succeeded, this.data, this.errors});
  factory UserResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserResponseModelToJson(this);
}
