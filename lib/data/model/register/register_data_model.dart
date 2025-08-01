import 'package:json_annotation/json_annotation.dart';

part 'register_data_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RegisterDataModel {
  final String? id;
  final String? token;
  final String? userName;

  RegisterDataModel({
    this.id,
    this.token,
    this.userName,
  });

  factory RegisterDataModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterDataModelToJson(this);
}
