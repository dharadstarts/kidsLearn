import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kids Learn',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(), // This shows AFTER splash screen
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kids Learn'),
      ),
      body: const Center(
        child: Text('Welcome to Kids Learn!'),
      ),
    );
  }
}