import 'package:delivery/data/model/delivery/delivery_company_data_model.dart';
import 'package:delivery/data/model/delivery/delivery_detail_model.dart';

abstract class DeliveryState {}

class DeliveryLoading extends DeliveryState {}

class DeliveryCompanyLoading extends DeliveryState {}

class DeliveryEmpty extends DeliveryState {}

class DeliveryDeleted extends DeliveryState {}

class DeliveryUpdated extends DeliveryState {
  final DeliveryDetailModel deliveryUpdated;
  DeliveryUpdated(this.deliveryUpdated);
}

class DeliveryAdded extends DeliveryState {}

class DeliveryLoaded extends DeliveryState {
  final List<DeliveryDetailModel> deliveries;
  DeliveryLoaded(this.deliveries);
}

class DeliveryCompaniesLoaded extends DeliveryState {
  final List<DeliveryCompanyDataModel> deliveryCompanies;
  DeliveryCompaniesLoaded(this.deliveryCompanies);
}

class DeliveryCompanyLoaded extends DeliveryState {
  final DeliveryCompanyDataModel deliveryCompany;
  DeliveryCompanyLoaded(this.deliveryCompany);
}

class DeliveryError extends DeliveryState {
  final String error;
  DeliveryError(this.error);
}

class DeliveryCompanyError extends DeliveryState {
  final String error;
  DeliveryCompanyError(this.error);
}
