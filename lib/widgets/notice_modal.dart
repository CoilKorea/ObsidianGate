// lib/widgets/notice_modal.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../stores/notice_store.dart';

class NoticeModal extends StatelessWidget {
  const NoticeModal({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<NoticeStore>(context);

    if (!store.modalOpen) return const SizedBox.shrink();

    return Center(
      child: Material(
        color: Colors.black54,
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: const Color(0xFF111111),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF333333)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "📢 전체 공지 보기",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ...store.notices.map((n) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text("• $n", style: const TextStyle(color: Colors.white70)),
                  )),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => store.setModalOpen(false),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text("닫기"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
