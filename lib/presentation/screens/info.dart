import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:delivery/core/constants/colors.dart';
import 'package:delivery/core/widgets/my_animation.dart';
import 'package:delivery/core/widgets/my_app_bar.dart';
import 'package:delivery/core/widgets/my_card.dart';
import 'package:delivery/core/widgets/my_text.dart';

class Info extends StatelessWidget {
  Info({super.key});
  static String id = "info";

  final List<SocialMedia> socialMediaList = [
    SocialMedia(
      name: "facebook".tr,
      icon: Icons.facebook,
      url: "https://www.facebook.com/ibrahim.katlone",
      color: Color(0xFF1877F2),
    ),
    SocialMedia(
      name: "whatsapp".tr,
      icon: Icons.message,
      url: "https://wa.me/qr/WR2LEBT2YKYJP1",
      color: Color(0xFF25D366),
    ),
    SocialMedia(
      name: "telegram".tr,
      icon: Icons.telegram,
      url: "https://t.me/Abomajid",
      color: Color(0xFF0088CC),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: "تواصل معنا".tr, context: context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),
            ...socialMediaList.map((social) => _buildSocialMediaCard(social)),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialMediaCard(SocialMedia social) {
    return MyAnimation(
      child: InkWell(
        onTap: () => _launchUrl(social.url),
        child: MyCard(
          elevation: 2,
          child: ListTile(
            leading: Icon(social.icon, color: social.color),
            title: CairoText(social.name),
            trailing: Icon(Icons.arrow_forward_ios,
                size: 16, color: Colors.grey[400]),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('❌ لم يتم فتح الرابط: $url');
      // ملاحظة: Get.context! يعمل فقط إذا كنت تستخدم GetMaterialApp
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text('تعذر فتح الرابط'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

class SocialMedia {
  final String name;
  final IconData icon;
  final String url;
  final Color color;

  const SocialMedia({
    required this.name,
    required this.icon,
    required this.url,
    required this.color,
  });
}
