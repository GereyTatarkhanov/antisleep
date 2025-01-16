import 'dart:io';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  void _toggleSleepmode(String mode) async {
    try {
      await Process.start('sudo', ['pmset', 'disablesleep', mode]);
    } catch (e) {
      // АШЫПКА
    }
  }

  void _sleep() => _toggleSleepmode('0');

  void _antisleep() => _toggleSleepmode('1');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 76),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Button(
              onPressed: _sleep,
              title: 'Включить сон',
              color: Colors.green.shade600,
            ),
            const SizedBox(height: 20),
            Button(
              onPressed: _antisleep,
              title: 'Выключить сон',
              color: Colors.red.shade800,
            ),
          ],
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.title,
    required this.onPressed,
    required this.color,
  });
  final String title;
  final void Function() onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(color),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
