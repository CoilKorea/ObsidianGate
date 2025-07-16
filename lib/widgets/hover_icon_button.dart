import 'package:flutter/material.dart';

class HoverIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double size;
  final Color color;
  final Color hoverColor;

  const HoverIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = 24,
    this.color = Colors.white,
    this.hoverColor = Colors.red,
  });

  @override
  State<HoverIconButton> createState() => _HoverIconButtonState();
}

class _HoverIconButtonState extends State<HoverIconButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: IconButton(
        icon: Icon(
          widget.icon,
          size: _hovering ? widget.size + 4 : widget.size,
          color: _hovering ? widget.hoverColor : widget.color,
        ),
        onPressed: widget.onPressed,
      ),
    );
  }
}
