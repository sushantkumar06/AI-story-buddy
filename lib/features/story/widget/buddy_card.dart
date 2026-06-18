import 'package:flutter/material.dart';

class BuddyCard extends StatelessWidget {
  final bool quizCompleted;

  const BuddyCard({super.key, this.quizCompleted = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            blurRadius: 12,
            offset: Offset(0, 4),
            color: Colors.black12,
          ),
        ],
      ),
      child: Center(
        child: Text(
          quizCompleted ? '🥳' : '🤖',
          style: const TextStyle(fontSize: 80),
        ),
      ),
    );
  }
}
