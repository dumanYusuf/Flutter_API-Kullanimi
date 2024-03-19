import 'package:flutter/material.dart';
import 'package:rick_andmorty/views/anaSayfa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      home: AnaSayfa(),
    );
  }
}
