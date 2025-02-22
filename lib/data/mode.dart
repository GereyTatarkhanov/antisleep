// ignore_for_file: constant_identifier_names

enum Mode {
  SLEEP_MODE_OFF(value: 1),
  SLEEP_MODE_ON(value: 0);

  const Mode({required this.value});

  final int value;
}
