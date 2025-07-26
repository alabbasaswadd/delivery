import 'package:delivery/data/model/order/order_data_model.dart';
import 'package:delivery/data/model/user/user_data_model.dart';
import 'package:delivery/data/web_services/web_services.dart';
import 'package:dio/dio.dart';

class Repository {
  final WebServices webServices;
  Repository(this.webServices);

  signUpRepository(Map<String, dynamic> data) async {
    try {
      final response = await webServices.signUpWebService(data);
      return response;
    } catch (e) {
      print('خطأ في المستودع (Repository): $e');
      return null;
    }
  }

  Future<Response> loginRepository(String email, String password) async {
    final response = await webServices.loginWebServices(email, password);
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

  Future<Response> deleteUserRepository(String userId) {
    return webServices.deleteUserWebServices(userId);
  }

  Future<Response> addOrderRepository(OrderDataModel dataOrder) {
    return webServices.addOrderWebServices(dataOrder);
  }

  Future<Response> getOrdersRepository() {
    return webServices.getOrdersWebServices();
  }

  Future<Response> updateOrderRepository(String orderId, OrderDataModel data) {
    return webServices.updateOrderWebServices(orderId, data);
  }

  Future<Response> deleteOrderRepository(String orderId) {
    return webServices.deleteOrderWebServices(orderId);
  }
}
