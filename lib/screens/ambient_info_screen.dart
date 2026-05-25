import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class AmbientInfoScreen extends StatelessWidget {
  const AmbientInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,
      appBar: AppBar(
        title: const Text('Ambient Computing'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          'This app applies ambient computing by using context such as time of day, mood preference, room type, lighting condition, budget, and space problem to personalize the portfolio experience. Instead of showing a static list of projects, the app recommends interior design works that match the user’s current situation and design needs.',
          style: TextStyle(fontSize: 17, height: 1.5),
        ),
      ),
    );
  }
}