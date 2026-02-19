import 'package:flutter/material.dart';

class StarButton extends StatelessWidget {
  final bool isStarred;
  final VoidCallback onPressed;

  const StarButton({
    super.key,
    required this.isStarred,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isStarred ? Icons.star : Icons.star_border,
        color: isStarred ? Colors.amber : null,
      ),
      onPressed: onPressed,
    );
  }
}
