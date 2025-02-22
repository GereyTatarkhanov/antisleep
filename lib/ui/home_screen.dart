import 'dart:io';
import 'package:antisleep/data/assets.dart';
import 'package:antisleep/data/mode.dart';
import 'package:antisleep/data/storage.dart';
import 'package:antisleep/ui/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final _storage = Storage.instance;
  int? _initialMode;
  late final AnimationController _turnOnAnimationController;
  late final AnimationController _turnOffAnimationController;
  final _duration = const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _turnOnAnimationController = AnimationController(
      vsync: this,
      duration: _duration,
      upperBound: 0.5,
    );
    _turnOffAnimationController = AnimationController(
      vsync: this,
      duration: _duration,
      upperBound: 0.5,
    );
    _storage.maybeGetMode().then(_setInitialMode);
  }

  void _setInitialMode(int? value) {
    setState(() => _initialMode = value);
    _initialMode == Mode.SLEEP_MODE_ON.value
        ? _turnOnAnimationController.forward()
        : _turnOffAnimationController.forward();
  }

  @override
  void dispose() {
    _turnOffAnimationController.dispose();
    _turnOnAnimationController.dispose();
    super.dispose();
  }

  void _setMode(int mode) async {
    try {
      await Process.start(
        'sudo',
        [
          'pmset',
          'disablesleep',
          mode.toString(),
        ],
      );
      _storage.setMode(mode: mode);
    } catch (e) {
      // АШЫБКА
    }
  }

  void _turnOff() {
    _setMode(Mode.SLEEP_MODE_OFF.value);
    _turnOnAnimationController.reverse();
    _turnOffAnimationController.forward();
  }

  void _turnOn() {
    _setMode(Mode.SLEEP_MODE_ON.value);
    _turnOnAnimationController.forward();
    _turnOffAnimationController.reverse();
  }

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
                Assets.logo,
                height: 100,
                width: 100,
              ),
            ),
          ),
          if (_initialMode != null)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 76),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Button(
                      controller: _turnOnAnimationController,
                      onPressed: _turnOn,
                      title: 'Turn on Sleep-Mode',
                    ),
                    const SizedBox(height: 20),
                    Button(
                      controller: _turnOffAnimationController,
                      onPressed: _turnOff,
                      title: 'Turn off Sleep-Mode',
                    ),
                  ],
                ),
              ),
            )
          else
            const Center(
              child: CircularProgressIndicator(
                color: Colors.purpleAccent,
              ),
            )
        ],
      ),
    );
  }
}
