import 'package:delivery/core/constants/colors.dart';
import 'package:delivery/core/constants/functions.dart';
import 'package:delivery/core/widgets/my_alert_dialog.dart';
import 'package:delivery/core/widgets/my_animation.dart';
import 'package:delivery/core/widgets/my_button.dart';
import 'package:delivery/core/widgets/my_text.dart';
import 'package:delivery/presentation/screens/auth/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  static String id = "settingsScreen";

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _profileExpanded = true;
  bool _appSettingsExpanded = true;
  bool _securityExpanded = true;
  bool _supportExpanded = true;
  int notificationCount = 3;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: size.height * 0.2,
            flexibleSpace: FlexibleSpaceBar(
              title: CairoText(
                "settings".tr,
                color: Colors.white,
              ),
              centerTitle: true,
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: const [
                      Color(0xff5673cc),
                      Color(0xff76c6f2),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Center(
                    child: Icon(Icons.settings,
                        size: 70, color: Colors.white.withOpacity(0.8)),
                  ),
                ),
              ),
            ),
            actions: [
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications, color: Colors.white),
                    onPressed: () {
                      // الذهاب إلى الإشعارات
                    },
                  ),
                  if (notificationCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '$notificationCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  // Profile Section
                  _buildAnimatedSettingsSection(
                    title: "profile".tr,
                    expanded: _profileExpanded,
                    onTap: () =>
                        setState(() => _profileExpanded = !_profileExpanded),
                    children: [
                      _buildSettingsItem(
                        icon: Icons.person,
                        title: "personal_info".tr,
                        onTap: () {
                          // Navigate to personal info screen
                        },
                      ),
                      _buildSettingsItem(
                        icon: Icons.phone,
                        title: "contact_info".tr,
                        onTap: () {
                          // Navigate to contact info screen
                        },
                      ),
                      _buildSettingsItem(
                        icon: Icons.location_on,
                        title: "addresses".tr,
                        onTap: () {
                          // Navigate to addresses screen
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // App Settings Section
                  _buildAnimatedSettingsSection(
                    title: "app_settings".tr,
                    expanded: _appSettingsExpanded,
                    onTap: () => setState(
                        () => _appSettingsExpanded = !_appSettingsExpanded),
                    children: [
                      _buildSettingsItem(
                        icon: Icons.language,
                        title: "language".tr,
                        trailing: Row(
                          children: [
                            CairoText(
                              "العربية",
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                            const Icon(Icons.chevron_right, color: Colors.grey),
                          ],
                        ),
                        onTap: () {
                          // Navigate to language settings
                        },
                      ),
                      _buildSettingsItem(
                        icon: Icons.notifications,
                        title: "notifications".tr,
                        trailing: Switch(
                          value: true,
                          activeColor: AppColor.kPrimaryColor,
                          onChanged: (value) {
                            // Handle notification toggle
                          },
                        ),
                      ),
                      _buildSettingsItem(
                        icon: Icons.dark_mode,
                        title: "dark_mode".tr,
                        trailing: Switch(
                          value: false,
                          activeColor: AppColor.kPrimaryColor,
                          onChanged: (value) {
                            // Handle dark mode toggle
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Security Section
                  _buildAnimatedSettingsSection(
                    title: "security".tr,
                    expanded: _securityExpanded,
                    onTap: () =>
                        setState(() => _securityExpanded = !_securityExpanded),
                    children: [
                      _buildSettingsItem(
                        icon: Icons.lock,
                        title: "change_password".tr,
                        onTap: () {
                          // Navigate to change password screen
                        },
                      ),
                      _buildSettingsItem(
                        icon: Icons.fingerprint,
                        title: "biometric_auth".tr,
                        trailing: Switch(
                          value: true,
                          activeColor: AppColor.kPrimaryColor,
                          onChanged: (value) {
                            // Handle biometric auth toggle
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Support Section
                  _buildAnimatedSettingsSection(
                    title: "support".tr,
                    expanded: _supportExpanded,
                    onTap: () =>
                        setState(() => _supportExpanded = !_supportExpanded),
                    children: [
                      _buildSettingsItem(
                        icon: Icons.help_center,
                        title: "help_center".tr,
                        onTap: () {
                          // Navigate to help center
                        },
                      ),
                      _buildSettingsItem(
                        icon: Icons.contact_support,
                        title: "contact_us".tr,
                        onTap: () {
                          // Navigate to contact us
                        },
                      ),
                      _buildSettingsItem(
                        icon: Icons.privacy_tip,
                        title: "privacy_policy".tr,
                        onTap: () {
                          // Navigate to privacy policy
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Logout Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: MyAnimation(
                        scale: 0.85,
                        child: MyButton(
                          text: "log_out".tr,
                          color: Colors.red,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => MyAlertDialog(
                                onOk: () {
                                  UserPreferencesService.clearUser();
                                  Get.toNamed(SignUp.id);
                                },
                                onNo: () {
                                  Get.back();
                                },
                                title: "logout".tr,
                                content: "هل تريد تسجيل الخروج",
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedSettingsSection({
    required String title,
    required bool expanded,
    required VoidCallback onTap,
    required List<Widget> children,
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: [
            // Header with arrow icon
            ListTile(
              title: CairoText(
                title,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColor.kPrimaryColor,
              ),
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
                child: Column(children: children),
              ),
              secondChild: Container(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColor.kPrimaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColor.kPrimaryColor, size: 20),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: CairoText(
                title,
                fontSize: 15,
              ),
            ),
            trailing ?? const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
