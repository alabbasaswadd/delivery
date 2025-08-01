import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:delivery/core/api/errors/error_model.dart';
import 'package:delivery/core/constants/functions.dart';
import 'package:delivery/data/model/delivery/delivery_company_data_model.dart';
import 'package:delivery/data/model/login/login_request_data_model.dart';
import 'package:delivery/data/model/login/login_response_data_model.dart';
import 'package:delivery/data/model/login/login_response_model.dart';
import 'package:delivery/data/model/register/register_request_data_model.dart';
import 'package:delivery/data/model/register/register_response_model.dart';
import 'package:delivery/data/model/user/user_data_model.dart';
import 'package:delivery/data/repository/repository.dart';
import 'package:delivery/data/web_services/web_services.dart';
import 'package:delivery/presentation/business_logic/cubit/auth/auth_state.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCubit extends Cubit<AuthState> {
  final Repository repository = Repository(WebServices());

  AuthCubit() : super(AuthInit());

  Future<void> signup(RegisterRequestDataModel data, File? logo) async {
    emit(AuthLoading());

    try {
      final response = await repository.signUpRepository(data, logo);
      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['succeeded'] == true) {
        emit(AuthSignUpSuccess());
      } else {
        emit(AuthError("فشل الاتصال بالسيرفر"));
      }
    } catch (e) {
      if (e is DioException) {
        final errorData = e.response?.data;
        final message = errorData?['message']?.toString() ??
            _extractFirstError(errorData?['errors']) ??
            "حدث خطأ أثناء الاتصال بالسيرفر";
        emit(AuthError(message));
      } else {
        emit(AuthError("حدث خطأ غير متوقع: ${e.toString()}"));
      }
    }
  }

  String? _extractFirstError(dynamic errors) {
    if (errors is Map<String, dynamic>) {
      for (var value in errors.values) {
        if (value is List && value.isNotEmpty) {
          return value.first.toString();
        }
      }
    }
    return null;
  }

  Future<void> login(LoginRequestDataModel data) async {
    emit(AuthLoading());

    try {
      final response = await repository.loginRepository(data);
      print(response.statusCode);
      print(response.statusMessage);
      print(response.data);
      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['succeeded'] == true) {
        final loginResponse = LoginResponseModel.fromJson(response.data);

        final loginData =
            LoginResponseDataModel.fromJson(response.data['data']);
        if (loginResponse.succeeded == true && loginResponse.data != null) {
          final token = loginData.token;
          final companyId = loginData.id;
          await CompanyPreferencesService.saveId(companyId ?? "");
          CompanySession.id = await CompanyPreferencesService.getId() ?? "";
          await CompanyPreferencesService.saveToken(token ?? "");
          final responseCompanyModel =
              await repository.getDeliveryCompanyByIdRepository();
          final companyModel = DeliveryCompanyDataModel.fromJson(
              responseCompanyModel.data['data']);
          await CompanySession.updateCompany(companyModel);
          emit(AuthAuthenticated());
        }
      } else {
        emit(AuthError("فشل الاتصال بالسيرفر."));
      }
    } catch (e) {
      if (e is DioException) {
        try {
          final errorData = e.response?.data;
          if (errorData != null && errorData is Map<String, dynamic>) {
            final errorModel = ErrorModel.fromJson(errorData);

            String errorMessage =
                errorModel.message ?? "خطأ في الاتصال بالسيرفر";

            if (errorModel.errors != null && errorModel.errors!.isNotEmpty) {
              final firstKey = errorModel.errors!.keys.first;
              final errorList = errorModel.errors![firstKey];
              if (errorList != null && errorList.isNotEmpty) {
                errorMessage = errorList.first;
              }
            }
            emit(AuthError(errorMessage));
          } else {
            emit(AuthError("فشل في قراءة رسالة الخطأ من السيرفر"));
          }
        } catch (_) {
          emit(AuthError("خطأ غير متوقع أثناء تحليل رسالة الخطأ"));
        }
      } else {
        print(e);
        emit(AuthError("حدث خطأ غير متوقع: ${e.toString()}"));
      }
    }
  }

  Future<void> getUserData() async {
    try {
      final response = await repository.getDeliveryCompanyByIdRepository();

      if (response.data != null) {
        final json = response.data;
        final deliveryCompany = DeliveryCompanyDataModel.fromJson(json);
        await CompanyPreferencesService.saveCompany(deliveryCompany.toJson());
      } else {
        emit(AuthError("فشل في استرجاع بيانات الشركة"));
      }
    } catch (e) {
      emit(AuthError("حدث خطأ أثناء استرجاع بيانات الشركة"));
    }

    Future<void> logout() async {
      await CompanyPreferencesService.clearUser();
      emit(AuthInit());
    }
  }
}
