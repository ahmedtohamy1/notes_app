import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class fab extends StatelessWidget {
  const fab({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.heroTag,
    required this.blurred,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String heroTag;
  final bool blurred;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.0,
      width: 65.0,
      child: FittedBox(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: blurred
              ? BackdropFilter(
                  filter: ui.ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                  child: FloatingActionButton(
                    elevation: 0,
                    heroTag: heroTag,
                    onPressed: onPressed,
                    child: Icon(icon),
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white.withOpacity(0.1),
                  ),
                )
              : FloatingActionButton(
                  elevation: 0,
                  backgroundColor: Colors.black,
                  foregroundColor: const ui.Color.fromARGB(255, 255, 255, 255),
                  heroTag: heroTag,
                  onPressed: onPressed,
                  child: Icon(icon),
                ),
        ),
      ),
    );
  }
}
