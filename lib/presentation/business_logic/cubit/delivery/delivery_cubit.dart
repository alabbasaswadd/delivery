import 'package:bloc/bloc.dart';
import 'package:delivery/core/constants/functions.dart';
import 'package:delivery/data/model/delivery/delivery_company_data_model.dart';
import 'package:delivery/data/model/delivery/delivery_detail_model.dart';
import 'package:delivery/data/model/order/order_data_model.dart';
import 'package:delivery/data/repository/repository.dart';
import 'package:delivery/data/web_services/web_services.dart';
import 'package:delivery/presentation/business_logic/cubit/delivery/delivery_state.dart';
import 'package:delivery/presentation/business_logic/cubit/order/order_state.dart';
import 'package:dio/dio.dart';

class DeliveryCubit extends Cubit<DeliveryState> {
  DeliveryCubit() : super(DeliveryLoading());
  Repository repository = Repository(WebServices());

  // Future<void> addOrder(OrderDataModel dataOrder) async {
  //   try {
  //     emit(OrderLoading());

  //     final response = await repository.addOrderRepository(dataOrder);

  //     print("📦 StatusCode: ${response.statusCode}");
  //     print("📦 Data: ${response.data}");
  //     print("📦 StatusMessage: ${response.statusMessage}");
  //     print("📦 Extra: ${response.extra}");

  //     if (response.statusCode == 200 &&
  //         response.data != null &&
  //         response.data['succeeded'] == true) {
  //       print("object");
  //       emit(OrderAdded());
  //     } else {
  //       emit(OrderError("فشل إرسال الطلب. الكود: ${response.statusCode}"));
  //     }
  //   } catch (e) {
  //     print("❌ استثناء أثناء إرسال الطلب: $e");

  //     // إذا كنت تستخدم Dio، فمن الأفضل فحص الخطأ بشكل دقيق
  //     if (e is DioException) {
  //       print("❌ DioException:");
  //       print("📥 Message: ${e.message}");
  //       print("📥 Response: ${e.response?.data}");
  //       emit(OrderError(
  //           "خطأ في الاتصال بالسيرفر: ${e.response?.data ?? e.message}"));
  //     } else {
  //       emit(OrderError("حدث خطأ غير متوقع أثناء إرسال الطلب"));
  //     }
  //   }
  // }

  Future<void> getDeliveries() async {
    try {
      emit(DeliveryLoading());
      final response = await repository.getDeliveriesRepository();
      print(response.statusCode);
      print(response.statusMessage);
      print(response.data);
      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['succeeded'] == true) {
        final deliveriesJson = response.data['data'] as List<dynamic>;
        final deliveries = deliveriesJson
            .map((deliveryJson) => DeliveryDetailModel.fromJson(deliveryJson))
            .toList();

        if (deliveries.isEmpty) {
          emit(DeliveryEmpty());
        } else {
          emit(DeliveryLoaded(deliveries));
        }
      } else {
        emit(DeliveryEmpty());
      }
    } catch (e) {
      emit(DeliveryError("فشل تحميل الطلبات: $e"));
    }
  }

  Future<void> updateDelivery(String orderId, DeliveryDetailModel data) async {
    try {
      emit(DeliveryLoading());
      final response = await repository.updateDeliveryRepository(orderId, data);
      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['succeeded'] == true) {
        emit(DeliveryUpdated(data));
      } else {
        emit(DeliveryError("فشل "));
      }
    } catch (e) {
      emit(DeliveryError("فشل تحميل الطلبات: $e"));
    }
  }

  void getDeliveryCompanies() async {
    try {
      emit(DeliveryCompanyLoading());
      final response = await repository.getDeliveryCompaniesRepository();
      print(response.statusCode);
      print(response.statusMessage);
      print(response.data);
      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['succeeded'] == true) {
        final deliverCompaniesJson = response.data['data'] as List<dynamic>;
        final deleveryCompanies = deliverCompaniesJson
            .map((deliveryCompanyJson) =>
                DeliveryCompanyDataModel.fromJson(deliveryCompanyJson))
            .toList();

        emit(DeliveryCompaniesLoaded(deleveryCompanies));
      } else {
        emit(DeliveryCompanyError("Error"));
      }
    } catch (e) {
      emit(DeliveryCompanyError("فشل تحميل الطلبات: $e"));
    }
  }

  void getDeliveryCompanyById() async {
    try {
      emit(DeliveryCompanyLoading());
      final response = await repository.getDeliveryCompanyByIdRepository();
      print(response.statusCode);
      print(response.statusMessage);
      print(response.data);
      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['succeeded'] == true) {
        final deliverCompaniesJson = response.data['data'];
        final deliveryCompany =
            DeliveryCompanyDataModel.fromJson(deliverCompaniesJson);
        CompanyPreferencesService.saveCompany(deliveryCompany.toJson());
        CompanySession.updateCompany(deliveryCompany);
        emit(DeliveryCompanyLoaded(deliveryCompany));
      } else {
        emit(DeliveryCompanyError("Error"));
      }
    } catch (e) {
      print(e);
      emit(DeliveryCompanyError("فشل تحميل الطلبات: $e"));
    }
  }

  void deleteCompany() async {
    try {
      emit(DeliveryCompanyLoading());
      final response = await repository.deleteCompanyRepository();
      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['succeeded'] == true) {
        await CompanySession.clear();
        emit(DeliveryDeleted());
      } else {
        emit(DeliveryCompanyError("Error"));
      }
    } catch (e) {
      print(e);
      emit(DeliveryCompanyError("فشل حذف الحساب: $e"));
    }
  }

  // void updateOrder(String odrderId, OrderDataModel data) async {
  //   try {
  //     emit(OrderLoading());
  //     final response = await repository.updateOrderRepository(odrderId, data);
  //     if (response.statusCode == 200 &&
  //         response.data != null &&
  //         response.data['succeeded'] == true) {
  //       emit(OrderLoaded(response.data));
  //     } else {
  //       emit(OrderEmpty());
  //     }
  //   } catch (e) {
  //     emit(OrderError(" $eالعذر من الباك"));
  //   }
  // }

  // void deleteOrder(String orderId) async {
  //   try {
  //     emit(OrderLoading());

  //     final response = await repository.deleteOrderRepository(orderId);

  //     print("📥 StatusCode: ${response.statusCode}");
  //     print("📥 StatusMessage: ${response.statusMessage}");
  //     print("📥 نوع الاستجابة: ${response.data.runtimeType}");
  //     print("📥 الاستجابة: ${response.data}");

  //     if (response.statusCode == 200 &&
  //         response.data != null &&
  //         response.data['succeeded'] == true) {
  //       emit(OrderDeleted());
  //       getOrders(); // أو أي دالة عندك تجيب الطلبات من جديد
  //     } else {
  //       emit(OrderError('فشل حذف الطلب. الكود: ${response.statusCode}'));
  //     }
  //   } catch (e) {
  //     print("❌ خطأ أثناء الحذف: $e");
  //     emit(OrderError('حدث خطأ أثناء حذف الطلب'));
  //   }
  // }
}
