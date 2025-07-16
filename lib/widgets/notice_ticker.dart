// lib/widgets/notice_ticker.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../stores/notice_store.dart';

class NoticeTicker extends StatelessWidget {
  const NoticeTicker({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<NoticeStore>(context);

    return MouseRegion(
      onEnter: (_) => store.setHovered(true),
      onExit: (_) => store.setHovered(false),
      child: GestureDetector(
        onTap: () => store.setModalOpen(true),
        child: Container(
          height: 24,
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: Text(
              store.notices[store.index],
              key: ValueKey(store.index),
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ),
        ),
      ),
    );
  }
}
