import 'package:flutter/material.dart';

import 'abstract_factory copy/abstract_factory_example.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AbstractFactoryExample(),
    );
  }
}
