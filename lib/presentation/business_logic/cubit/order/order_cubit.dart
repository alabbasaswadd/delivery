import 'package:bloc/bloc.dart';
import 'package:delivery/data/model/order/order_data_model.dart';
import 'package:delivery/data/repository/repository.dart';
import 'package:delivery/data/web_services/web_services.dart';
import 'package:delivery/presentation/business_logic/cubit/order/order_state.dart';
import 'package:dio/dio.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderLoading());
  Repository repository = Repository(WebServices());

  Future<void> addOrder(OrderDataModel dataOrder) async {
    try {
      emit(OrderLoading());

      final response = await repository.addOrderRepository(dataOrder);

      print("📦 StatusCode: ${response.statusCode}");
      print("📦 Data: ${response.data}");
      print("📦 StatusMessage: ${response.statusMessage}");
      print("📦 Extra: ${response.extra}");

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['succeeded'] == true) {
        print("object");
        emit(OrderAdded());
      } else {
        emit(OrderError("فشل إرسال الطلب. الكود: ${response.statusCode}"));
      }
    } catch (e) {
      print("❌ استثناء أثناء إرسال الطلب: $e");

      // إذا كنت تستخدم Dio، فمن الأفضل فحص الخطأ بشكل دقيق
      if (e is DioException) {
        print("❌ DioException:");
        print("📥 Message: ${e.message}");
        print("📥 Response: ${e.response?.data}");
        emit(OrderError(
            "خطأ في الاتصال بالسيرفر: ${e.response?.data ?? e.message}"));
      } else {
        emit(OrderError("حدث خطأ غير متوقع أثناء إرسال الطلب"));
      }
    }
  }

  void getOrders() async {
    try {
      emit(OrderLoading());
      final response = await repository.getDeliveriesRepository();
      print(response.statusCode);
      print(response.statusMessage);
      print(response.data);
      print(response.data);
      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['succeeded'] == true) {
        final ordersJson = response.data['data'] as List<dynamic>;
        final orders = ordersJson
            .map((orderJson) => OrderDataModel.fromJson(orderJson))
            .toList();

        if (orders.isEmpty) {
          emit(OrderEmpty());
        } else {
          emit(OrderLoaded(orders));
        }
      } else {
        emit(OrderEmpty());
      }
    } catch (e) {
      emit(OrderError("فشل تحميل الطلبات: $e"));
    }
  }

  void updateOrder(String odrderId, OrderDataModel data) async {
    try {
      emit(OrderLoading());
      final response = await repository.updateOrderRepository(odrderId, data);
      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['succeeded'] == true) {
        emit(OrderLoaded(response.data));
      } else {
        emit(OrderEmpty());
      }
    } catch (e) {
      emit(OrderError(" $eالعذر من الباك"));
    }
  }

  void deleteOrder(String orderId) async {
    try {
      emit(OrderLoading());

      final response = await repository.deleteOrderRepository(orderId);

      print("📥 StatusCode: ${response.statusCode}");
      print("📥 StatusMessage: ${response.statusMessage}");
      print("📥 نوع الاستجابة: ${response.data.runtimeType}");
      print("📥 الاستجابة: ${response.data}");

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['succeeded'] == true) {
        emit(OrderDeleted());
        getOrders(); // أو أي دالة عندك تجيب الطلبات من جديد
      } else {
        emit(OrderError('فشل حذف الطلب. الكود: ${response.statusCode}'));
      }
    } catch (e) {
      print("❌ خطأ أثناء الحذف: $e");
      emit(OrderError('حدث خطأ أثناء حذف الطلب'));
    }
  }
}
