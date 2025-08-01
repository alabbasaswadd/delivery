import 'package:json_annotation/json_annotation.dart';

part 'register_request_data_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RegisterRequestDataModel {
  final String name;
  final String contactPerson;
  final String phoneNumber;
  final String email;
  final String? website;
  final String password;
  final String address;
  final String? coverageAreas;
  final double basePrice;
  final double? pricePerKm;

  RegisterRequestDataModel({
    required this.name,
    required this.contactPerson,
    required this.phoneNumber,
    required this.email,
    this.website,
    required this.password,
    required this.address,
    this.coverageAreas,
    required this.basePrice,
    this.pricePerKm,
  });

  factory RegisterRequestDataModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterRequestDataModelToJson(this);
}
