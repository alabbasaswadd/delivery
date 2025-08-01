import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:delivery/core/constants/colors.dart';
import 'package:delivery/core/constants/functions.dart';
import 'package:delivery/core/widgets/my_alert_dialog.dart';
import 'package:delivery/core/widgets/my_animation.dart';
import 'package:delivery/core/widgets/my_app_bar.dart';
import 'package:delivery/core/widgets/my_button.dart';
import 'package:delivery/core/widgets/my_text.dart';
import 'package:delivery/presentation/screens/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});
  static String id = "settings";

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _isDarkMode = false;
  String _selectedLanguage = Get.locale?.languageCode ?? "en";

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('theme') ?? false;
      _selectedLanguage = prefs.getString('language') ?? "en";
    });
  }

  Future<void> _saveSetting<T>(String key, T value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: "settings".tr, context: context),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Account Settings Section
            _buildSectionHeader("account_settings".tr),
            _buildSettingTile(
                icon: Icons.person_outline,
                title: "username".tr,
                value: CompanySession.name ?? "",
                onTap: () {}),
            _buildSettingTile(
                icon: Icons.phone_android_outlined,
                title: "phone".tr,
                value: CompanySession.phoneNumber ?? "",
                onTap: () {}),
            const SizedBox(height: 24),

            // App Settings Section
            _buildSectionHeader("app_settings".tr),
            _buildSettingTile(
              icon: Icons.language_outlined,
              title: "language".tr,
              value: _selectedLanguage == "ar" ? "arabic".tr : "english".tr,
              onTap: () => _showLanguageBottomSheet(),
            ),
            _buildSettingTile(
              onTap: () {},
              icon: Icons.dark_mode_outlined,
              title: "dark_mode".tr,
              trailing: Switch(
                value: _isDarkMode,
                onChanged: (value) async {
                  await _saveSetting('theme', value);
                  setState(() => _isDarkMode = value);
                  if (value) {
                    AdaptiveTheme.of(context).setDark();
                  } else {
                    AdaptiveTheme.of(context).setLight();
                  }
                },
                activeColor: AppColor.kPrimaryColor,
              ),
            ),
            Spacer(),
            _buildLogOutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return CairoText(
      title,
      color: Colors.grey[600],
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    String? value,
    Widget? trailing,
    Color? color,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
      ),
      child: ListTile(
        leading: Icon(icon, color: color ?? AppColor.kPrimaryColor),
        title: CairoText(
          title,
          fontSize: 11,
        ),
        subtitle: value != null ? CairoText(value, fontSize: 11) : null,
        trailing: trailing ?? Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  void _showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CairoText(
              "select_language".tr,
            ),
            const SizedBox(height: 16),
            RadioListTile(
              title: CairoText("arabic".tr),
              value: "ar",
              groupValue: _selectedLanguage,
              onChanged: (value) async {
                await _saveSetting('language', "ar");
                Get.updateLocale(const Locale("ar"));
                setState(() => _selectedLanguage = "ar");
                Get.back();
              },
              activeColor: AppColor.kPrimaryColor,
            ),
            RadioListTile(
              title: CairoText("english".tr),
              value: "en",
              groupValue: _selectedLanguage,
              onChanged: (value) async {
                await _saveSetting('language', "en");
                Get.updateLocale(const Locale("en"));
                setState(() => _selectedLanguage = "en");
                Get.back();
              },
              activeColor: AppColor.kPrimaryColor,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildLogOutButton() {
    return MyAnimation(
      scale: 0.90,
      child: MyButton(
          text: "log_out".tr,
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => MyAlertDialog(
                    onOk: () {
                      Get.offAllNamed(Login.id);
                      CompanySession.clear();
                    },
                    onNo: () {
                      Get.back();
                    },
                    title: "log_out".tr,
                    content: "do_you_want_to_log_out".tr));
          },
          color: Colors.redAccent),
    );
  }
}
