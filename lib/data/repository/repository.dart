import 'dart:io';
import 'package:delivery/data/model/delivery/delivery_detail_model.dart';
import 'package:delivery/data/model/login/login_request_data_model.dart';
import 'package:delivery/data/model/order/order_data_model.dart';
import 'package:delivery/data/model/register/register_request_data_model.dart';
import 'package:delivery/data/model/user/user_data_model.dart';
import 'package:delivery/data/web_services/web_services.dart';
import 'package:dio/dio.dart';

class Repository {
  final WebServices webServices;
  Repository(this.webServices);

  Future<Response> signUpRepository(
      RegisterRequestDataModel data, File? logo) async {
    final response = await webServices.signUpWebService(data, logo);
    return response;
  }

  Future<Response> loginRepository(LoginRequestDataModel data) async {
    final response = await webServices.loginWebServices(data);
    return response;
  }

  Future<Response> getUserDataRepository(String userId) async {
    final response = await webServices.getUserWebServices(userId);
    return response;
  }

  Future<Response> getUserRepository(String userId) {
    return webServices.getUserWebServices(userId);
  }

  Future<Response> updateUserRepository(String userId, UserDataModel user) {
    return webServices.updateUserWebServices(userId, user);
  }

  Future<Response> deleteCompanyRepository() {
    return webServices.deleteCompanyWebServices();
  }

  Future<Response> addOrderRepository(OrderDataModel dataOrder) {
    return webServices.addOrderWebServices(dataOrder);
  }

  Future<Response> getDeliveriesRepository() {
    return webServices.getDeliveriesWebServices();
  }

  Future<Response> updateOrderRepository(String orderId, OrderDataModel data) {
    return webServices.updateOrderWebServices(orderId, data);
  }

  Future<Response> updateDeliveryRepository(
      String orderId, DeliveryDetailModel data) {
    return webServices.updateDeliveryWebServices(orderId, data);
  }

  Future<Response> deleteOrderRepository(String orderId) {
    return webServices.deleteOrderWebServices(orderId);
  }

  Future<Response> getDeliveryCompaniesRepository() {
    return webServices.getDeliveryCompaniesWebServices();
  }

  Future<Response> getDeliveryCompanyByIdRepository() {
    return webServices.getDeliveryCompanyByIdWebServices();
  }
}
