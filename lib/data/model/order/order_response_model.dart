import 'package:delivery/core/api/errors/error_model.dart';
import 'package:delivery/data/model/order/order_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_response_model.g.dart';

@JsonSerializable()
class OrderResponseModel {
  final bool succeeded;
  final List<OrderDataModel>? data;
  final ErrorModel? errors;

  OrderResponseModel({
    required this.succeeded,
    this.data,
    this.errors,
  });

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) =>
      _$OrderResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderResponseModelToJson(this);
}
