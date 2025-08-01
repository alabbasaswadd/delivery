import 'package:delivery/core/constants/colors.dart';
import 'package:delivery/core/constants/functions.dart';
import 'package:delivery/core/widgets/my_alert_dialog.dart';
import 'package:delivery/core/widgets/my_animation.dart';
import 'package:delivery/core/widgets/my_app_bar.dart';
import 'package:delivery/core/widgets/my_button.dart';
import 'package:delivery/core/widgets/my_text.dart';
import 'package:delivery/core/widgets/my_text_form_field.dart';
import 'package:delivery/data/model/delivery/delivery_company_data_model.dart';
import 'package:delivery/presentation/business_logic/cubit/delivery/delivery_cubit.dart';
import 'package:delivery/presentation/business_logic/cubit/delivery/delivery_state.dart';
import 'package:delivery/presentation/screens/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class Account extends StatefulWidget {
  const Account({super.key});
  static String id = "edit_profile_page";

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  late DeliveryCubit cubit;
  // Controllers بدون تمرير قيم أولية
  late TextEditingController _nameController;
  late TextEditingController _contactPersonController;
  late TextEditingController _phoneController;
  late TextEditingController
      _emailController; // إذا email معقد (كائن منفصل)، ممكن تحتاج تعديله
  late TextEditingController _websiteController;
  late TextEditingController _addressController;
  late TextEditingController _basePriceController;
  late TextEditingController _pricePerKmController;
  late bool _isActive = false; // حالة boolean وليست نص
  bool _personalInfoExpanded = true;
  bool _addressInfoExpanded = true;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    cubit = DeliveryCubit();
    cubit.getDeliveryCompanyById();
    loadData();
  }

  DeliveryCompanyDataModel? deliveryCompany = CompanySession.deliveryCompany;
  void loadData() async {
    await CompanySession.init();
    _nameController = TextEditingController();
    _contactPersonController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController(); // لو email كائن، عدل حسبه
    _websiteController = TextEditingController();
    _addressController = TextEditingController();
    _basePriceController = TextEditingController();
    _pricePerKmController = TextEditingController();
    _isActive = false;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactPersonController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _websiteController.dispose();
    _addressController.dispose();
    _basePriceController.dispose();
    _pricePerKmController.dispose();
    super.dispose();
  }

  // دالة لتحديث الكنترولرز حسب بيانات المستخدم
  void _updateControllers(DeliveryCompanyDataModel deliveryCompany) {
    _nameController.text = deliveryCompany.name ?? "";
    _contactPersonController.text = deliveryCompany.contactPerson ?? "";
    _phoneController.text = deliveryCompany.phoneNumber ?? "";
    _emailController.text =
        deliveryCompany.email?.userName ?? ""; // لو email كائن، عدل حسبه
    _websiteController.text = deliveryCompany.website ?? "";
    _addressController.text = deliveryCompany.address ?? "";
    _basePriceController.text = deliveryCompany.basePrice.toString();
    _pricePerKmController.text = deliveryCompany.pricePerKm.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: "edit_profile".tr, context: context),
      body: BlocBuilder<DeliveryCubit, DeliveryState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is DeliveryCompanyLoading) {
            return Scaffold(
              body: Center(
                child: SpinKitChasingDots(color: AppColor.kPrimaryColor),
              ),
            );
          } else if (state is DeliveryCompanyLoaded) {
            _updateControllers(state.deliveryCompany);
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfileHeader(),
                    const SizedBox(height: 24),
                    _buildAnimatedSection(
                      title: "company_info".tr,
                      expanded: _personalInfoExpanded,
                      onTap: () => setState(
                          () => _personalInfoExpanded = !_personalInfoExpanded),
                      child: _buildPersonalInfoSection(),
                    ),
                    const SizedBox(height: 16),
                    _buildAnimatedSection(
                      title: "address".tr,
                      expanded: _addressInfoExpanded,
                      onTap: () => setState(
                          () => _addressInfoExpanded = !_addressInfoExpanded),
                      child: _buildAddressSection(),
                    ),
                    const SizedBox(height: 24),
                    _buildActionButtons(),
                  ],
                ),
              ),
            );
          } else if (state is DeliveryCompanyError) {
            return Center(
                child: CairoText(
              "حدث خطأ: ${state.error}",
              maxLines: 5,
            ));
          }
          // الحالة الافتراضية قبل تحميل البيانات
          return Center(child: CairoText("please_wait".tr));
        },
      ),
    );
  }

  Widget _buildAnimatedSection({
    required String title,
    required bool expanded,
    required VoidCallback onTap,
    required Widget child,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: [
            // Header with arrow icon
            ListTile(
              title: CairoText(title, color: AppColor.kPrimaryColor),
              trailing: Icon(
                expanded ? Icons.expand_less : Icons.expand_more,
                color: Colors.grey[600],
              ),
              onTap: onTap,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),

            // Animated content
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 300),
              crossFadeState: expanded
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: child,
              ),
              secondChild: Container(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Center(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppColor.kPrimaryColor.withOpacity(0.2),
                      AppColor.kSecondColor.withOpacity(0.2)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  image: DecorationImage(
                    image: NetworkImage(CompanySession.logoUrl ??
                        'https://randomuser.me/api/portraits/men/1.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: AppColor.kPrimaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: IconButton(
                  icon: const Icon(Icons.camera_alt,
                      size: 20, color: Colors.white),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          AnimatedDefaultTextStyle(
            duration: Duration(milliseconds: 300),
            style: TextStyle(),
            child: CairoText(
                color: AppColor.kPrimaryColor,
                fontSize: 18,
                _nameController.text),
          ),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: TextStyle(),
            child: CairoText(
              _emailController.text,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoSection() {
    return Column(
      children: [
        MyTextFormField(
          controller: _nameController,
          label: "company_name".tr,
          icon: Icons.business,
          validator: (value) => value!.isEmpty ? "هذا الحقل مطلوب" : null,
        ),
        const SizedBox(height: 12),
        MyTextFormField(
          controller: _contactPersonController,
          label: "contact_person".tr,
          icon: Icons.person,
          validator: (value) => value!.isEmpty ? "هذا الحقل مطلوب" : null,
        ),
        const SizedBox(height: 12),
        MyTextFormField(
          controller: _emailController,
          label: "email".tr,
          icon: Icons.email_outlined,
          readOnly: true, // إذا أردت من المستخدم تعديل البريد غير ممكن
        ),
        const SizedBox(height: 12),
        MyTextFormField(
          controller: _phoneController,
          label: "phone_number".tr,
          icon: Icons.phone_android_outlined,
          validator: (value) => value!.isEmpty ? "هذا الحقل مطلوب" : null,
        ),
        const SizedBox(height: 12),
        MyTextFormField(
          controller: _websiteController,
          label: "website".tr,
          icon: Icons.web,
        ),
      ],
    );
  }

  Widget _buildAddressSection() {
    return Column(
      children: [
        MyTextFormField(
          controller: _addressController,
          label: "address".tr,
          icon: Icons.location_on,
          validator: (value) => value!.isEmpty ? "هذا الحقل مطلوب" : null,
        ),
        const SizedBox(height: 12),
        MyTextFormField(
          controller: _basePriceController,
          label: "base_price".tr,
          icon: Icons.price_change,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 12),
        MyTextFormField(
          controller: _pricePerKmController,
          label: "price_per_km".tr,
          icon: Icons.directions_car,
          keyboardType: TextInputType.number,
        ),
        Row(
          children: [
            CairoText(
              "is_active".tr,
              color: AppColor.kPrimaryColor,
            ),
            Switch(
              value: _isActive,
              onChanged: (val) {
                setState(() {
                  _isActive = val;
                });
              },
              activeColor: AppColor.kPrimaryColor,
              inactiveThumbColor: AppColor.kSecondColor,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        MyAnimation(
            child: MyButton(
                text: "save_changes".tr,
                onPressed: () {
                  // cubit.updateUser(
                  //     DeliveryCompanySession.id ?? "",
                  //     UserDataModel(
                  //         firstName: "Alabbas",
                  //         lastName: "Aswad",
                  //         dateOfBirth: DeliveryCompanySession.birthDate,
                  //         emailId: DeliveryCompanySession.emailId,
                  //         phone: DeliveryCompanySession.phone,
                  //         addressId: DeliveryCompanySession.addressId));
                })),
        const SizedBox(height: 12),
        MyAnimation(
          scale: 0.85,
          child: TextButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => MyAlertDialog(
                        onOk: () async {
                          cubit.deleteCompany();
                          Get.offAllNamed(Login.id); // 🔁 العودة لصفحة الدخول
                        },
                        onNo: () {
                          Get.back();
                        },
                        title: "delete_account".tr,
                        content: "confirm_delete_account".tr,
                      ));
            },
            child: CairoText("delete_account".tr, color: Colors.red),
          ),
        ),
      ],
    );
  }
}
