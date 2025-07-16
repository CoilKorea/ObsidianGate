import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContactModal extends StatelessWidget {
  final String platform;
  final String content;

  const ContactModal({
    super.key,
    required this.platform,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF121212),
      title: Text(
        "$platform 연락처",
        style: const TextStyle(color: Colors.white),
      ),
      content: SelectableText(
        content,
        style: const TextStyle(color: Colors.white70),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: content));
            Navigator.of(context).pop();
          },
          child: const Text("복사", style: TextStyle(color: Colors.redAccent)),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("닫기", style: TextStyle(color: Colors.grey)),
        ),
      ],
    );
  }
}
