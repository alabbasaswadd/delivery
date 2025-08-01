import 'package:delivery/core/constants/colors.dart';
import 'package:delivery/core/constants/functions.dart';
import 'package:delivery/core/widgets/data_and_time_widget.dart';
import 'package:delivery/core/widgets/my_animation.dart';
import 'package:delivery/core/widgets/my_app_bar.dart';
import 'package:delivery/core/widgets/my_card.dart';
import 'package:delivery/core/widgets/my_text.dart';
import 'package:delivery/presentation/screens/account.dart';
import 'package:delivery/presentation/screens/delivery.dart';
import 'package:delivery/presentation/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String id = "homeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: myAppBar(
        context: context,
        title: " أهلاً بك يا ${CompanySession.name}",
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: AppColor.kPrimaryColor),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Header with welcome message
              _buildWelcomeHeader(),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: _buildActionCard(
                  icon: Icons.local_shipping,
                  title: "orders".tr,
                  subtitle: "manage_deliveries".tr,
                  color: AppColor.kPrimaryColor,
                  onTap: () => Get.toNamed(Deliveries.id),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: _buildActionCard(
                      icon: Icons.settings,
                      title: "settings".tr,
                      subtitle: "customize_app".tr,
                      color: AppColor.kSecondColor,
                      onTap: () => Get.toNamed(Settings.id),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: _buildActionCard(
                      icon: Icons.person,
                      title: "account".tr,
                      subtitle: "account_info".tr,
                      color: Colors.green,
                      onTap: () {
                        Get.toNamed(Account.id);
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Statistics Section
              _buildStatisticsSection(),

              const SizedBox(height: 20),
            ])),
      ),
    );
  }

  Widget _buildWelcomeHeader() {
    return Center(child: DateTimeWidget());
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return MyAnimation(
      scale: 0.95,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: MyCard(
          padding: EdgeInsets.zero,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: color, size: 24),
                  ),
                  const SizedBox(height: 15),
                  CairoText(
                    title,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 5),
                  CairoText(
                    subtitle,
                    fontSize: 12,
                    color: AppColor.kSecondColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatisticsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CairoText(
          "today_stats".tr,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: double.infinity,
          child: _buildStatCard(
            value: "5",
            label: "ongoing_orders".tr,
            color: Colors.orange,
          ),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                value: "24",
                label: "new_orders".tr,
                color: AppColor.kPrimaryColor,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildStatCard(
                value: "18",
                label: "completed".tr,
                color: Colors.green,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildStatCard(
                value: "3",
                label: "cancelled".tr,
                color: AppColor.kRedColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String value,
    required String label,
    required Color color,
    Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap ?? () {},
      child: MyCard(
        padding: EdgeInsets.zero,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CairoText(
                value,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: color,
              ),
              const SizedBox(height: 5),
              CairoText(
                label,
                fontSize: 12,
                color: AppColor.kSecondColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
