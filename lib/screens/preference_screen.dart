import 'package:flutter/material.dart';
import 'portfolio_screen.dart';

class PreferenceScreen extends StatefulWidget {
  const PreferenceScreen({super.key});

  @override
  State<PreferenceScreen> createState() => _PreferenceScreenState();
}

class _PreferenceScreenState extends State<PreferenceScreen> {
  String selectedRoom = 'Bedroom';
  String selectedMood = 'Relaxing';
  String selectedBudget = 'Medium';

  final List<String> rooms = [
    'Bedroom',
    'Living Room',
    'Office',
    'Kitchen',
    'Café',
  ];

  final List<String> moods = [
    'Cozy',
    'Relaxing',
    'Productive',
    'Luxury',
    'Natural',
  ];

  final List<String> budgets = [
    'Low',
    'Medium',
    'High',
  ];

  Widget buildChoiceGroup({
    required String title,
    required List<String> options,
    required String selectedValue,
    required Function(String) onSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: options.map((option) {
            return ChoiceChip(
              label: Text(option),
              selected: selectedValue == option,
              onSelected: (_) {
                onSelected(option);
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personalize Your Space'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tell us what kind of space you want to explore.',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            buildChoiceGroup(
              title: 'Room Type',
              options: rooms,
              selectedValue: selectedRoom,
              onSelected: (value) {
                setState(() {
                  selectedRoom = value;
                });
              },
            ),

            buildChoiceGroup(
              title: 'Mood',
              options: moods,
              selectedValue: selectedMood,
              onSelected: (value) {
                setState(() {
                  selectedMood = value;
                });
              },
            ),

            buildChoiceGroup(
              title: 'Budget Level',
              options: budgets,
              selectedValue: selectedBudget,
              onSelected: (value) {
                setState(() {
                  selectedBudget = value;
                });
              },
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PortfolioScreen(
                        selectedRoom: selectedRoom,
                        selectedMood: selectedMood,
                        selectedBudget: selectedBudget,
                      ),
                    ),
                  );
                },
                child: const Text('Show Recommended Projects'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}