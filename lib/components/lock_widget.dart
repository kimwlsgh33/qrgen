import 'package:flutter/material.dart';

class LockWidget extends StatelessWidget {
  const LockWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.withOpacity(0.4),
      ),
      height: 100,
      child: const Icon(
        Icons.lock,
        size: 24,
        color: Colors.grey,
        semanticLabel: 'Lock',
      ),
    );
  }
}
