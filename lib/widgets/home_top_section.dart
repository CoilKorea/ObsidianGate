import 'dart:async';
import 'package:flutter/material.dart';

class HomeTopSection extends StatefulWidget {
  const HomeTopSection({super.key});

  @override
  State<HomeTopSection> createState() => _HomeTopSectionState();
}

class _HomeTopSectionState extends State<HomeTopSection> {
  bool _hoveringNotice = false;
  bool _isFocused = false;
  int _currentNoticeIndex = 0;
  late Timer _timer;

  final List<String> _eventNotices = [
    '첫 구매 할인 이벤트',
    '영업 시간 안내: 오전 11:00~익일 04:00',
    '신규 게임 추가 예정 안내',
    '카카오톡 오픈채팅방 운영 중!'
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      setState(() {
        _currentNoticeIndex = (_currentNoticeIndex + 1) % _eventNotices.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _showMobileDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1a1a1a),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text("📢 진행 중인 공지 및 이벤트", style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("- 첫 구매 할인 이벤트", style: TextStyle(color: Colors.white70)),
            Text("- 영업 시간 안내: 오전 11:00~익일 04:00", style: TextStyle(color: Colors.white70)),
            Text("- 신규 게임 추가 예정 안내", style: TextStyle(color: Colors.white70)),
            Text("- 카카오톡 오픈채팅방 운영 중!", style: TextStyle(color: Colors.white70)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("닫기", style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.bottomRight,
              radius: 2,
              colors: [Color(0xFF121212), Color(0xFF0a0a0a)],
            ),
            border: Border(
              bottom: BorderSide(color: Color(0xFF222222)),
            ),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Welcome to ',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: 'Obsidian Gate',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFFF4C4C),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "믿고 거래할 수 있는 ARPG Gaming 마켓",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  Focus(
                    onFocusChange: (hasFocus) => setState(() => _isFocused = hasFocus),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1a1a1a),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _isFocused ? Colors.red.shade900 : const Color(0xFF333333),
                          width: 1.5,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: "게임명이나 재화를 검색하세요...",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          icon: Icon(Icons.search, color: Colors.grey),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 🔥 이벤트 공지 + 자세히 보기
                  isMobile
                      ? Column(
                          children: [
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder: (child, animation) =>
                                  FadeTransition(opacity: animation, child: child),
                              child: Text(
                                '🔥 ${_eventNotices[_currentNoticeIndex]}',
                                key: ValueKey<String>(_eventNotices[_currentNoticeIndex]),
                                style: const TextStyle(color: Colors.white70),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 4),
                            GestureDetector(
                              onTap: _showMobileDialog,
                              child: const Text(
                                '자세히 보기',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Color(0xFFFF4C4C),
                                ),
                              ),
                            ),
                          ],
                        )
                      : MouseRegion(
                          onEnter: (_) => setState(() => _hoveringNotice = true),
                          onExit: (_) => setState(() => _hoveringNotice = false),
                          child: Stack(
                            alignment: Alignment.topCenter,
                            clipBehavior: Clip.none,
                            children: [
                              Column(
                                children: [
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 300),
                                    transitionBuilder: (child, animation) =>
                                        FadeTransition(opacity: animation, child: child),
                                    child: Text(
                                      '🔥 ${_eventNotices[_currentNoticeIndex]}',
                                      key: ValueKey<String>(_eventNotices[_currentNoticeIndex]),
                                      style: const TextStyle(color: Colors.white70),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    '자세히 보기',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xFFFF4C4C),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                ],
                              ),
                              if (_hoveringNotice)
                                Positioned(
                                  bottom: 40,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Container(
                                      width: 400,
                                      height: 180,
                                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF1a1a1a),
                                        border: Border.all(color: const Color(0xFF333333)),
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.4),
                                            blurRadius: 8,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: const [
                                            Text("📢 진행 중인 공지 및 이벤트", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                                            SizedBox(height: 8),
                                            Text("- 첫 구매 할인 이벤트", style: TextStyle(color: Colors.white70)),
                                            Text("- 영업 시간 안내: 오전 11:00~익일 04:00", style: TextStyle(color: Colors.white70)),
                                            Text("- 신규 게임 추가 예정 안내", style: TextStyle(color: Colors.white70)),
                                            Text("- 카카오톡 오픈채팅방 운영 중!", style: TextStyle(color: Colors.white70)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),

                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
