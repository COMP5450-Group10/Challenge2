import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import 'recommendation_result_screen.dart';

class MatchQuizScreen extends StatefulWidget {
  const MatchQuizScreen({super.key});

  @override
  State<MatchQuizScreen> createState() => _MatchQuizScreenState();
}

class _MatchQuizScreenState extends State<MatchQuizScreen> {
  String roomType = 'Bedroom';
  String mood = 'Relaxing';
  String budgetLevel = 'Medium';
  String lightingCondition = 'Dark';
  String spaceProblem = 'Too crowded';

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
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
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
        const SizedBox(height: 26),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 28),
      children: [
        const Text(
          'Find your design direction',
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Answer a few questions and receive portfolio projects that match your space.',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 28),

        buildChoiceGroup(
          title: 'What room are you designing?',
          options: const [
            'Bedroom',
            'Living Room',
            'Office',
            'Kitchen',
            'Café',
            'Apartment',
            'Study',
            'Bathroom',
          ],
          selectedValue: roomType,
          onSelected: (value) {
            setState(() {
              roomType = value;
            });
          },
        ),

        buildChoiceGroup(
          title: 'What mood do you want?',
          options: const [
            'Cozy',
            'Relaxing',
            'Productive',
            'Luxury',
            'Natural',
            'Minimal',
            'Fresh',
            'Functional',
          ],
          selectedValue: mood,
          onSelected: (value) {
            setState(() {
              mood = value;
            });
            Provider.of<AppState>(context, listen: false).updateMood(value);
          },
        ),

        buildChoiceGroup(
          title: 'What is your budget level?',
          options: const ['Low', 'Medium', 'High'],
          selectedValue: budgetLevel,
          onSelected: (value) {
            setState(() {
              budgetLevel = value;
            });
          },
        ),

        buildChoiceGroup(
          title: 'How is the lighting condition?',
          options: const ['Bright', 'Medium', 'Dark'],
          selectedValue: lightingCondition,
          onSelected: (value) {
            setState(() {
              lightingCondition = value;
            });
          },
        ),

        buildChoiceGroup(
          title: 'What problem do you want to solve?',
          options: const [
            'Too small',
            'Too dark',
            'Too crowded',
            'Disorganized',
            'Not stylish',
            'Not functional',
            'Distracting',
          ],
          selectedValue: spaceProblem,
          onSelected: (value) {
            setState(() {
              spaceProblem = value;
            });
          },
        ),

        ElevatedButton.icon(
          icon: const Icon(Icons.auto_awesome),
          label: const Text('Generate Design Match'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RecommendationResultScreen(
                  roomType: roomType,
                  mood: mood,
                  budgetLevel: budgetLevel,
                  lightingCondition: lightingCondition,
                  spaceProblem: spaceProblem,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}