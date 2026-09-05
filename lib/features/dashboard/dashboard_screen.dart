import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E14),
      appBar: AppBar(
        title: const Text('PropTrack Dashboard'),
        backgroundColor: const Color(0xFF121824),
      ),
      body: const Center(
        child: Text(
          'Welcome to PropTrack!',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
