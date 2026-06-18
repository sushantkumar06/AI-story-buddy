import 'package:flutter/material.dart';

class StoryCard extends StatelessWidget {
  final String storyText;

  const StoryCard({super.key, required this.storyText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            blurRadius: 12,
            offset: Offset(0, 4),
            color: Colors.black12,
          ),
        ],
      ),
      child: Text(storyText, style: const TextStyle(fontSize: 16, height: 1.6)),
    );
  }
}
