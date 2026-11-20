import 'dart:math';

final _random = Random();

/// Gera um id único (suficiente para dados locais).
String newId() {
  final time = DateTime.now().microsecondsSinceEpoch.toRadixString(36);
  final noise = _random.nextInt(1 << 32).toRadixString(36);
  return '$time$noise';
}
