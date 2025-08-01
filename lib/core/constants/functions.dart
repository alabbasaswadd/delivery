import 'dart:convert';
import 'package:delivery/data/model/delivery/delivery_company_data_model.dart';
import 'package:delivery/data/model/delivery/delivery_detail_model.dart';
import 'package:delivery/data/model/delivery/delivery_email_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'colors.dart';

class CompanyPreferencesService {
  static const String deliveryKey = 'delivery_data';

  // حفظ بيانات المستخدم (JSON String)
  static Future<void> saveCompany(Map<String, dynamic> companyJson) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(deliveryKey, jsonEncode(companyJson));
  }

  // استرجاع بيانات المستخدم كخريطة
  static Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString(deliveryKey);
    if (userString != null) {
      return jsonDecode(userString);
    }
    return null;
  }

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
  }

  static Future<void> saveId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("id", id);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    if (token != null) {
      return token;
    }
    return null;
  }

  static Future<String?> getId() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString("id");
    if (id != null) {
      return id;
    }
    return null;
  }

  // استرجاع قيمة معينة من بيانات المستخدم
  static Future<String?> getUserValue(String key) async {
    final deliveryKey = await getUser();
    if (deliveryKey != null && deliveryKey.containsKey(key)) {
      return deliveryKey[key].toString();
    }
    return null;
  }

  // حذف بيانات المستخدم
  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(deliveryKey);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(deliveryKey);
  }

  // استرجاع بيانات المستخدم كنموذج UserModel
  static Future<DeliveryCompanyDataModel?> getDeliveryCompanyModel() async {
    final prefs = await SharedPreferences.getInstance();
    final deliveryCompany = prefs.getString(deliveryKey);
    if (deliveryCompany != null) {
      final json = jsonDecode(deliveryCompany);
      return DeliveryCompanyDataModel.fromJson(json);
    }
    return null;
  }
}

class CompanySession {
  static DeliveryCompanyDataModel? deliveryCompany;

  /// تحميل بيانات المستخدم من SharedPreferences وتخزينها في الذاكرة
  static Future<void> init() async {
    deliveryCompany = await CompanyPreferencesService.getDeliveryCompanyModel();
  }

  /// كل بيانات المستخدم
  static DeliveryCompanyDataModel? get company => deliveryCompany;

  /// خصائص مباشرة من delivery
  static String? id = "";
  static String? get name => deliveryCompany?.name;
  static String? get contactPerson => deliveryCompany?.contactPerson;
  static String? get phoneNumber => deliveryCompany?.phoneNumber;
  static DeliveryEmailModel? get email => deliveryCompany?.email;
  static String? get userName => deliveryCompany?.email?.userName;
  static String? get password => deliveryCompany?.email?.password;
  static String? get website => deliveryCompany?.website;
  static String? get address => deliveryCompany?.address;
  static dynamic get coverageAreas => deliveryCompany?.coverageAreas;
  static double? get basePrice => deliveryCompany?.basePrice;
  static double? get pricePerKm => deliveryCompany?.pricePerKm;
  static bool? get isActive => deliveryCompany?.isActive;
  static String? get logoUrl => deliveryCompany?.logoUrl;
  static List<DeliveryDetailModel>? get deliveries =>
      deliveryCompany?.deliveries;

  // افترض هنا أن email من نوع String، عدل حسب نوعه الحقيقي

  // إذا الجنس عدد صحيح 0 أو 1

  /// هل المستخدم مسجل دخول؟
  static bool get isLoggedIn => deliveryCompany != null;

  /// تحديث بيانات المستخدم
  static Future<void> updateCompany(
      DeliveryCompanyDataModel deliveryModel) async {
    deliveryCompany = deliveryModel;
    await CompanyPreferencesService.saveCompany(deliveryModel.toJson());
  }

  /// تسجيل الخروج
  static Future<void> clear() async {
    deliveryCompany = null;
    await CompanyPreferencesService.clearUser();
  }
}

Widget buildSectionHeader(String title) {
  return Text(
    title,
    style: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: AppColor.kPrimaryColor,
    ),
  );
}

Future<DateTime?> showDateDialog(BuildContext context) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now().subtract(Duration(days: 365 * 18)),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
    helpText: 'select_birth_date'.tr,
    cancelText: 'cancel'.tr,
    confirmText: 'confirm'.tr,
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: AppColor.kPrimaryColor, // لون اليوم المختار وخلفية الزر
            onPrimary:
                Colors.white, // لون النص فوق اللون الأساسي (اليوم المحدد)
            onSurface: Colors.black, // لون النص العادي
          ),
          dialogBackgroundColor: Colors.white,
        ),
        child: child!,
      );
    },
  );
  return pickedDate;
}
