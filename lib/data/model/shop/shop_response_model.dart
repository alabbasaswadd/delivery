import 'package:delivery/core/api/errors/error_model.dart';
import 'package:delivery/data/model/shop/shop_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shop_response_model.g.dart';

@JsonSerializable()
class ShopResponseModel {
  final bool succeeded;
  final List<ShopDataModel>? data;
  final ErrorModel? errors;

  ShopResponseModel({
    required this.succeeded,
    this.data,
    this.errors,
  });

  factory ShopResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ShopResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShopResponseModelToJson(this);
}
