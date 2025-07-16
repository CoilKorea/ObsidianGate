// lib/components/navigation/mobile_nav.dart
import 'package:flutter/material.dart';

class MobileNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const MobileNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF111111),
      selectedItemColor: const Color(0xFFd32f2f),
      unselectedItemColor: Colors.grey,
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.videogame_asset), label: '게임목록'),
        BottomNavigationBarItem(icon: Icon(Icons.message), label: '메세지'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: '프로필'),
      ],
    );
  }
}
