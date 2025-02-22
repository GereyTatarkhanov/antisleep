import 'package:antisleep/data/assets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.title,
    required this.onPressed,
    required this.controller,
  });
  final String title;
  final void Function() onPressed;
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      width: double.infinity,
      child: OutlinedButton(
        style: const ButtonStyle(
          side: WidgetStatePropertyAll(
            BorderSide(color: Colors.purpleAccent, width: 2),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(width: 8),
            Lottie.asset(
              controller: controller,
              width: 30,
              Assets.select,
            ),
          ],
        ),
      ),
    );
  }
}
