import 'package:flutter/material.dart';

import 'confetti_overlay.dart';

class SuccessCard extends StatelessWidget {
  const SuccessCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        const ConfettiOverlay(),

        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.green),
          ),
          child: const Column(
            children: [
              Icon(Icons.emoji_events, color: Colors.orange, size: 60),

              SizedBox(height: 12),

              Text(
                'Story Completed!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 8),

              Text(
                'Great job! You listened carefully and answered correctly.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
