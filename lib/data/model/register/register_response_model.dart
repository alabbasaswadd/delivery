import 'package:delivery/core/api/errors/error_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RegisterResponseModel {
  final bool succeeded;
  final Map<String, dynamic>? data;
  final ErrorModel errors;

  RegisterResponseModel({
    required this.succeeded,
    this.data,
    required this.errors,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterResponseModelToJson(this);
}
