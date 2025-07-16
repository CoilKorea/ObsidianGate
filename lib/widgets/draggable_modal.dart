import 'package:flutter/material.dart';

class DraggableModal extends StatelessWidget {
  final bool isOpen;
  final VoidCallback onClose;
  final String title;
  final Widget content;

  const DraggableModal({
    super.key,
    required this.isOpen,
    required this.onClose,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    if (!isOpen) return const SizedBox.shrink();

    return Stack(
      children: [
        GestureDetector(
          onTap: onClose,
          child: Container(
            color: Colors.black.withOpacity(0.4),
          ),
        ),
        Center(
          child: DraggableScrollableSheet(
            initialChildSize: 0.5,
            maxChildSize: 0.8,
            minChildSize: 0.3,
            builder: (_, controller) {
              return Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1a1a1a),
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: onClose,
                        ),
                      ],
                    ),
                    const Divider(color: Colors.grey),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: controller,
                        child: content,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
