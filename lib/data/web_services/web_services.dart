import 'dart:io';

import 'package:delivery/core/api/cache/cache_helper.dart';
import 'package:delivery/core/constants/functions.dart';
import 'package:delivery/core/constants/route.dart';
import 'package:delivery/data/model/delivery/delivery_detail_model.dart';
import 'package:delivery/data/model/login/login_request_data_model.dart';
import 'package:delivery/data/model/order/order_data_model.dart';
import 'package:delivery/data/model/register/register_request_data_model.dart';
import 'package:delivery/data/model/user/user_data_model.dart';
import 'package:dio/dio.dart';

class WebServices {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      validateStatus: (status) {
        return status != null && status < 500;
      },
    ),
  );

  Future<Response> signUpWebService(
    RegisterRequestDataModel data,
    File? logoFile,
  ) async {
    final formData = FormData.fromMap({
      'name': data.name,
      'contact_person': data.contactPerson,
      'phone_number': data.phoneNumber,
      'website': data.website,
      'email': data.email,
      'password': data.password,
      'address': data.address,
      'coverage_areas': data.coverageAreas,
      'base_price': data.basePrice,
      'price_per_km': data.pricePerKm,
      if (logoFile != null)
        'logo': await MultipartFile.fromFile(
          logoFile.path,
          filename: logoFile.path.split('/').last,
        ),
    });

    final response = await dio.post(
      "$baseUrl$signUp",
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      ),
    );
    return response;
  }

  Future<Response> loginWebServices(LoginRequestDataModel data) async {
    final response = await dio.post(
      "$baseUrl$login",
      data: data.toJson(),
    );
    return response;
  }

  Future<Response> getUserWebServices(String userId) async {
    final token = await CompanyPreferencesService.getToken();
    final response = await dio.get(
      '$baseUrl${getUserRoute(userId)}',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return response;
  }

  Future<Response> updateUserWebServices(
      String userId, UserDataModel user) async {
    final token = await CompanyPreferencesService.getToken();
    var response = await dio.put(
      '$baseUrl${updateUserRoute(userId)}',
      data: user.toJson(),
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return response;
  }

  Future<Response> deleteCompanyWebServices() async {
    final token = await CompanyPreferencesService.getToken();
    final companyId = await CompanyPreferencesService.getId();
    final response = await dio.delete(
      '$baseUrl${deleteCompany(companyId ?? "")}',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return response;
  }

  Future<Response> addOrderWebServices(OrderDataModel dataOrder) async {
    final token = await CompanyPreferencesService.getToken();
    final response = await dio.post(
      data: dataOrder.toJson(),
      '$baseUrl$addOrder',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return response;
  }

  Future<Response> getDeliveriesWebServices() async {
    final token = await CompanyPreferencesService.getToken();
    final deliveryCompanyId = CompanySession.id ?? '';
    final response = await dio.get(
      '$baseUrl$getDeliveries',
      queryParameters: {"companyId": "13e2e2d3-00a5-4214-34fe-08ddcd039c82"},
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return response;
  }

  Future<Response> getOffersWebServices() async {
    final token = await CompanyPreferencesService.getToken();
    final response = await dio.get(
      '$baseUrl$offer',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return response;
  }

  Future<Response> updateOrderWebServices(
      String orderId, OrderDataModel data) async {
    final token = await CompanyPreferencesService.getToken();
    final response = await dio.put(
      '$baseUrl${updateOrder(orderId)}',
      data: data.toJson(),
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return response;
  }

  Future<Response> updateDeliveryWebServices(
      String deliveryId, DeliveryDetailModel data) async {
    final token = await CompanyPreferencesService.getToken();
    final response = await dio.put(
      '$baseUrl${updateDelivery(deliveryId)}',
      data: data.toJson(),
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return response;
  }

  Future<Response> deleteOrderWebServices(String orderId) async {
    final token = await CompanyPreferencesService.getToken();
    final response = await dio.delete(
      '$baseUrl${deleteOrder(orderId)}',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return response;
  }

  Future<Response> getDeliveryCompaniesWebServices() async {
    final token = await CompanyPreferencesService.getToken();
    final response = await dio.get(
      '$baseUrl$getDeliveryCompanies',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return response;
  }

  Future<Response> getDeliveryCompanyByIdWebServices() async {
    final token = await CompanyPreferencesService.getToken();
    final companyId = await CompanyPreferencesService.getId();
    final response = await dio.get(
      '$baseUrl${getDeliveryCompanyById(companyId ?? "")}',
      options:
          Options(headers: {"Authorization": "Bearer $token", "id": companyId}),
    );
    return response;
  }
}
