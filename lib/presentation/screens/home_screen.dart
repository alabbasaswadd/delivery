import 'package:delivery/core/constants/colors.dart';
import 'package:delivery/core/widgets/my_animation.dart';
import 'package:delivery/core/widgets/my_button.dart';
import 'package:delivery/core/widgets/my_card.dart';
import 'package:delivery/core/widgets/my_text.dart';
import 'package:delivery/presentation/screens/order.dart';
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
  String userName = "العباس";
  int notificationCount = 3;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: size.height * 0.25,
            flexibleSpace: FlexibleSpaceBar(
              title: CairoText(
                "home".tr,
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
                    child: Icon(Icons.home,
                        size: 80, color: Colors.white.withOpacity(0.8)),
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
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Welcome Section
                  Center(
                    child: Column(
                      children: [
                        CairoText(
                          "مرحباً بك يا $userName 👋",
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColor.kPrimaryColor,
                        ),
                        const SizedBox(height: 8),
                        CairoText(
                          "welcome_home_message".tr,
                          color: Colors.grey[600],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Stats Cards
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.shopping_bag,
                          value: "12",
                          label: "orders".tr,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.star,
                          value: "4.8",
                          label: "rating".tr,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.timer,
                          value: "30m",
                          label: "avg_time".tr,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.monetization_on,
                          value: "1200",
                          label: "earnings".tr,
                          color: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Quick Actions
                  CairoText(
                    "quick_actions".tr,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 15),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    children: [
                      _buildActionButton(
                        icon: Icons.shopping_bag,
                        label: "orders".tr,
                        onTap: () => Get.toNamed(OrdersScreen.id),
                      ),
                      _buildActionButton(
                        icon: Icons.history,
                        label: "history".tr,
                        onTap: () {},
                      ),
                      _buildActionButton(
                        icon: Icons.map,
                        label: "track".tr,
                        onTap: () {},
                      ),
                      _buildActionButton(
                        icon: Icons.settings,
                        label: "settings".tr,
                        onTap: () => Get.toNamed(SettingsScreen.id),
                      ),
                      _buildActionButton(
                        icon: Icons.help,
                        label: "help".tr,
                        onTap: () {},
                      ),
                      _buildActionButton(
                        icon: Icons.logout,
                        label: "logout".tr,
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Recent Activity
                  CairoText(
                    "recent_activity".tr,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 15),
                  _buildActivityItem(
                    icon: Icons.check_circle,
                    color: Colors.green,
                    title: "order_delivered".tr,
                    subtitle: "order_123_delivered".tr,
                    time: "2 hours ago",
                  ),
                  _buildActivityItem(
                    icon: Icons.local_shipping,
                    color: Colors.blue,
                    title: "order_on_way".tr,
                    subtitle: "order_124_on_way".tr,
                    time: "4 hours ago",
                  ),
                  _buildActivityItem(
                    icon: Icons.payment,
                    color: Colors.purple,
                    title: "payment_received".tr,
                    subtitle: "amount_received".tr,
                    time: "1 day ago",
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 10),
          CairoText(
            value,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 5),
          CairoText(
            label,
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return MyAnimation(
      scale: 0.9,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: MyCard(
          elevation: 2,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: AppColor.kPrimaryColor, size: 30),
                const SizedBox(height: 8),
                CairoText(
                  label,
                  fontSize: 12,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required String time,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CairoText(
                  title,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                CairoText(
                  subtitle,
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ],
            ),
          ),
          CairoText(
            time,
            fontSize: 10,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
