import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
  const Home({super.key});

  void _setMode(String mode) async {
    try {
      await Process.start('sudo', ['pmset', 'disablesleep', mode]);
    } catch (e) {
      // АШЫПКА
    }
  }

  void _turnOn() => _setMode('0');

  void _turnOff() => _setMode('1');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: Align(
              alignment: Alignment.topLeft,
              child: SvgPicture.asset(
                'assets/logo.svg',
                height: 100,
                width: 100,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 76),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Button(
                    onPressed: _turnOn,
                    title: 'Turn on Sleep-Mode',
                    color: Colors.greenAccent.shade400,
                  ),
                  const SizedBox(height: 20),
                  Button(
                    onPressed: _turnOff,
                    title: 'Turn off Sleep-Mode',
                    color: Colors.redAccent.shade400,
                  ),
                ],
              ),
            ),
          )
        ],
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
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
