// ✅ lib/widgets/footer.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Widget buildIcon(String platform, String assetPath, {String? url}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: url != null ? () => _launchURL(url) : null,
        child: Image.asset(
          assetPath,
          height: 32,
          width: 32,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFF222222))),
        color: Color(0xFF0a0a0a),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Contact",
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/icons/logo.png", height: 32, width: 32),
              const SizedBox(width: 16),
              buildIcon('KakaoTalk', "assets/icons/kakao.png", url: 'https://open.kakao.com/o/sELckyxh'),
              const SizedBox(width: 16),
              buildIcon('Discord', "assets/icons/discord.png"),
              const SizedBox(width: 16),
              buildIcon('Telegram', "assets/icons/telegram.png", url: 'https://t.me/obsidiangate'),
              const SizedBox(width: 16),
              buildIcon('WeChat', "assets/icons/wechat.png"),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            "© 2025 Obsidian Gate. All rights reserved.",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 4),
          const Text(
            "이용약관 | 개인정보처리방침",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
