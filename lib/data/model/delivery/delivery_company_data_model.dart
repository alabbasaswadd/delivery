  import 'package:delivery/data/model/delivery/delivery_detail_model.dart';
  import 'package:delivery/data/model/delivery/delivery_email_model.dart';
  import 'package:json_annotation/json_annotation.dart';

  part 'delivery_company_data_model.g.dart';

  @JsonSerializable()
  class DeliveryCompanyDataModel {
    final String? id;
    final String? name;
    final String? contactPerson;
    final String? phoneNumber;
    final DeliveryEmailModel? email;
    final String? website;
    final String? address;
    final dynamic coverageAreas;
    final double? basePrice;
    final double? pricePerKm;
    final bool? isActive;
    final String? logoUrl;
    final List<DeliveryDetailModel>? deliveries;
    DeliveryCompanyDataModel({
      this.id,
      this.name,
      this.contactPerson,
      this.phoneNumber,
      this.email,
      this.logoUrl,
      this.website,
      this.address,
      this.coverageAreas,
      this.basePrice,
      this.pricePerKm,
      this.isActive,
      this.deliveries,
    });

    factory DeliveryCompanyDataModel.fromJson(Map<String, dynamic> json) =>
        _$DeliveryCompanyDataModelFromJson(json);
    Map<String, dynamic> toJson() => _$DeliveryCompanyDataModelToJson(this);
  }
