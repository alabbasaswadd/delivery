import 'package:delivery/data/model/delivery/delivery_company_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delivery_response_model.g.dart';

@JsonSerializable()
class DeliveryResponseModel {
  final bool succeeded;
  final List<DeliveryCompanyDataModel> data;
  final Map<String, dynamic> errors;

  DeliveryResponseModel({
    required this.succeeded,
    required this.data,
    required this.errors,
  });

  factory DeliveryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DeliveryResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryResponseModelToJson(this);
}
