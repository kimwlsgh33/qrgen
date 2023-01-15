import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:todos/cubits/counter.dart';
import 'package:todos/page/qr_screen.dart';

void main(List<String> args) {
  final counter = CounterCubit();
  print(counter.state);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: QrScreen()
    );
  }
}
