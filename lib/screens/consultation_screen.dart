import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class ConsultationScreen extends StatefulWidget {
  const ConsultationScreen({super.key});

  @override
  State<ConsultationScreen> createState() => _ConsultationScreenState();
}

class _ConsultationScreenState extends State<ConsultationScreen> {
  String room = 'Bedroom';
  String mood = 'Relaxing';
  String budget = 'Medium';

  final rooms = ['Bedroom', 'Living Room', 'Office', 'Kitchen', 'Café'];
  final moods = ['Cozy', 'Relaxing', 'Productive', 'Luxury', 'Natural'];
  final budgets = ['Low', 'Medium', 'High'];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
      children: [
        const Text(
          'Request a Personalized Design Direction',
          style: TextStyle(
            fontSize: 26,
            height: 1.2,
            fontWeight: FontWeight.bold,
            color: AppTheme.textDark,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Choose your context and the app prepares a consultation summary.',
          style: TextStyle(
            color: AppTheme.textMuted,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 24),
        _choiceSection('Room Type', rooms, room, (value) {
          setState(() => room = value);
        }),
        _choiceSection('Desired Mood', moods, mood, (value) {
          setState(() => mood = value);
        }),
        _choiceSection('Budget Level', budgets, budget, (value) {
          setState(() => budget = value);
        }),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(26),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Consultation Summary',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 12),
              Text('Room: $room'),
              Text('Mood: $mood'),
              Text('Budget: $budget'),
              const SizedBox(height: 18),
              TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Describe your space',
                  filled: true,
                  fillColor: AppTheme.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Consultation request prepared.'),
              ),
            );
          },
          icon: const Icon(Icons.send_rounded),
          label: const Text('Prepare Request'),
        ),
      ],
    );
  }

  Widget _choiceSection(
      String title,
      List<String> options,
      String selected,
      Function(String) onSelected,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textDark,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: options.map((option) {
              final isSelected = option == selected;

              return ChoiceChip(
                label: Text(option),
                selected: isSelected,
                selectedColor: AppTheme.primary,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : AppTheme.textDark,
                ),
                onSelected: (_) => onSelected(option),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}