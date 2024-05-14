import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  static const name = 'Detailscreen';
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Detail'),
      ),
      body: const Text('Hello'),
    );
  }
}