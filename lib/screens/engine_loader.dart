import 'dart:async';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class EngineLoader extends StatefulWidget {
  const EngineLoader({super.key});

  @override
  State<EngineLoader> createState() => _EngineLoaderState();
}

class _EngineLoaderState extends State<EngineLoader> {
  final List<String> loadingMessages = [
    "데이터베이스 연결 중...",
    "세션 정보 불러오는 중...",
    "사용자 상태 구성 중...",
    "UI 레이아웃 준비 중...",
    "마켓 게이트웨이 열리는 중...",
  ];

  int step = 0;
  late Timer stepTimer;

  @override
  void initState() {
    super.initState();

    stepTimer = Timer.periodic(
      const Duration(milliseconds: 900),
      (timer) {
        if (step < loadingMessages.length - 1) {
          setState(() => step++);
        } else {
          timer.cancel();
        }
      },
    );

    // ✅ 화면 로딩만 담당 (데이터 로딩 없음)
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    stepTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 100,
              height: 100,
              color: Colors.white.withOpacity(0.95),
            ),
            const SizedBox(height: 30),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Text(
                loadingMessages[step],
                key: ValueKey(step),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                  shadows: [
                    Shadow(color: Colors.redAccent, blurRadius: 12),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
