import 'package:delivery/core/constants/functions.dart';
import 'package:delivery/core/constants/route.dart';
import 'package:delivery/data/model/order/order_data_model.dart';
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

  Future<Response> signUpWebService(Map<String, dynamic> data) async {
    final response = await dio.post(
      "$baseUrl$signUp",
      data: data,
    );
    return response;
  }

  Future<Response> loginWebServices(String email, String password) async {
    final response = await dio.post(
      "$baseUrl$login",
      data: {
        'email': email,
        'password': password,
      },
    );
    return response;
  }

  Future<Response> getUserWebServices(String userId) async {
    final token = await UserPreferencesService.getToken();
    final response = await dio.get(
      '$baseUrl${getUserRoute(userId)}',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return response;
  }

  Future<Response> updateUserWebServices(
      String userId, UserDataModel user) async {
    final token = await UserPreferencesService.getToken();
    var response = await dio.put(
      '$baseUrl${updateUserRoute(userId)}',
      data: user.toJson(),
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return response;
  }

  Future<Response> deleteUserWebServices(String userId) async {
    final token = await UserPreferencesService.getToken();

    final response = await dio.delete(
      '$baseUrl${deleteUserRoute(userId)}',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return response;
  }

  Future<Response> addOrderWebServices(OrderDataModel dataOrder) async {
    final token = await UserPreferencesService.getToken();
    final response = await dio.post(
      data: dataOrder.toJson(),
      '$baseUrl$addOrder',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return response;
  }

  Future<Response> getOrdersWebServices() async {
    final token = await UserPreferencesService.getToken();
    final customerId = UserSession.id ?? '';
    final response = await dio.get(
      '$baseUrl${getOrders(customerId)}',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return response;
  }

  Future<Response> getOffersWebServices() async {
    final token = await UserPreferencesService.getToken();
    final response = await dio.get(
      '$baseUrl$offer',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return response;
  }

  Future<Response> updateOrderWebServices(
      String orderId, OrderDataModel data) async {
    final token = await UserPreferencesService.getToken();
    final response = await dio.put(
      '$baseUrl${updateOrder(orderId)}',
      data: data.toJson(),
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return response;
  }

  Future<Response> deleteOrderWebServices(String orderId) async {
    final token = await UserPreferencesService.getToken();
    final response = await dio.delete(
      '$baseUrl${deleteOrder(orderId)}',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return response;
  }
}
