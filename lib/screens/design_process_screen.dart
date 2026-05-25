import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class DesignProcessScreen extends StatelessWidget {
  const DesignProcessScreen({super.key});

  final List<Map<String, String>> steps = const [
    {
      'title': '1. Understand the Client',
      'body': 'Identify the room purpose, lifestyle, habits, mood expectations, and design constraints.',
    },
    {
      'title': '2. Analyze the Space',
      'body': 'Study lighting, size, circulation, storage needs, and existing furniture problems.',
    },
    {
      'title': '3. Build Mood Direction',
      'body': 'Create a design mood using color, materials, style references, and atmosphere goals.',
    },
    {
      'title': '4. Plan Layout and Lighting',
      'body': 'Arrange furniture, zoning, natural light, task lighting, and ambient lighting.',
    },
    {
      'title': '5. Select Materials',
      'body': 'Choose textures, finishes, furniture, and decorative details that match the design direction.',
    },
    {
      'title': '6. Present Final Concept',
      'body': 'Deliver a coherent design solution that improves comfort, function, and visual identity.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,
      appBar: AppBar(
        title: const Text('Design Process'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'How Aura Interior Studio Works',
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
              color: AppTheme.darkBrown,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'This process explains how the portfolio connects design skills to client value.',
          ),
          const SizedBox(height: 24),

          ...steps.map((step) {
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step['title']!,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.darkBrown,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(step['body']!),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}