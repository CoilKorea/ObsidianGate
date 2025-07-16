// lib/components/navigation/sidebar.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:obsidiangate/components/auth/login_modal.dart';
import '../../stores/session_store.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<SessionStore>(context);
    final nickname = session.nickname;
    final isLoggedIn = session.isLoggedIn;

    return Container(
      width: 270,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      decoration: const BoxDecoration(
        color: Color(0xFF0f0f0f),
        border: Border(
          right: BorderSide(color: Color(0xFF1e1e1e), width: 1),
        ),
      ),
      child: Column(
        children: [
          // 상단: 로고 및 메뉴
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/sidelogo.png',
                    width: 28,
                    height: 28,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'OBSIDIAN GATE',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 1.2,
                      height: 1.1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              if (!isLoggedIn)
                _SidebarButton(
                  icon: Icons.login,
                  label: '로그인',
                  highlight: true,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginModal()),
                  ),
                ),
              _SidebarButton(
                icon: Icons.videogame_asset,
                label: '게임목록',
                onTap: () => Navigator.pushNamed(context, '/home'),
              ),
              if (isLoggedIn)
                _SidebarButton(
                  icon: Icons.chat_bubble_outline,
                  label: '메세지',
                  onTap: () => Navigator.pushNamed(context, '/messages'),
                ),
              if (isLoggedIn)
                _SidebarButton(
                  icon: Icons.person_outline,
                  label: nickname,
                  onTap: () => Navigator.pushNamed(context, '/profile'),
                ),
            ],
          ),
          const Spacer(),
          // 하단: 언어 스위치 (예정)
          Column(
            children: [
              const Text('Language', style: TextStyle(color: Colors.grey, fontSize: 12)),
              const SizedBox(height: 6),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade800,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                onPressed: () {},
                icon: const Icon(Icons.language, size: 16, color: Colors.white),
                label: const Text('한국어 | 언어변경', style: TextStyle(fontSize: 12, color: Colors.white)),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}

class _SidebarButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final bool highlight;
  final VoidCallback? onTap;

  const _SidebarButton({
    required this.icon,
    required this.label,
    this.active = false,
    this.highlight = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = highlight
        ? Colors.white
        : active
            ? Colors.white
            : Colors.grey.shade400;

    final gradient = highlight
        ? BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF5D0000), Color(0xFFc62828)],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.red.shade900.withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          )
        : BoxDecoration(
            color: active ? Colors.red.shade900.withOpacity(0.15) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          );

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: gradient,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: color),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: color,
                    fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
            const Icon(Icons.chevron_right, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
