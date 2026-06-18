import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class ReadStoryButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ReadStoryButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.volume_up),
        label: const Text(
          'Read Me a Story',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
      ),
    );
  }
}
