import 'dart:async';

import 'package:antisleep/data/keys.dart';
import 'package:antisleep/data/mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  Storage._();

  Future<void> init() async {
    final isFirstRun = await _maybeGetIsFirstRunVar();
    if (isFirstRun ?? true) {
      _setIsFirstRunVar();
      setMode(mode: Mode.SLEEP_MODE_ON.value);
    }
  }

  static final instance = Storage._();

  final _sharedPreferences = SharedPreferences.getInstance();

  Future<void> setMode({required int mode}) async {
    final prefs = await _sharedPreferences;
    prefs.setInt(Keys.mode, mode);
  }

  Future<int?> maybeGetMode() async {
    try {
      final prefs = await _sharedPreferences;
      final mode = prefs.getInt(Keys.mode);
      return mode;
    } catch (error) {
      return null;
    }
  }

  Future<void> _setIsFirstRunVar() async {
    final prefs = await _sharedPreferences;
    prefs.setBool(Keys.isFirstRun, false);
  }

  Future<bool?> _maybeGetIsFirstRunVar() async {
    try {
      final prefs = await _sharedPreferences;
      final isFirstRun = prefs.getBool(Keys.isFirstRun);
      return isFirstRun;
    } catch (error) {
      return null;
    }
  }
}
