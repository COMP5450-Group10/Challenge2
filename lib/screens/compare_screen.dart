import 'package:flutter/material.dart';
import '../models/design_project.dart';
import '../utils/app_theme.dart';

class CompareScreen extends StatelessWidget {
  final DesignProject first;
  final DesignProject second;

  const CompareScreen({
    super.key,
    required this.first,
    required this.second,
  });

  Widget comparisonRow(String label, String firstValue, String secondValue) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: Text(firstValue)),
              const SizedBox(width: 16),
              Expanded(child: Text(secondValue)),
            ],
          ),
        ],
      ),
    );
  }

  String listText(List<String> list) {
    return list.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,
      appBar: AppBar(
        title: const Text('Compare Projects'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  first.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkBrown,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  second.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkBrown,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          comparisonRow('Room Type', first.roomType, second.roomType),
          comparisonRow('Mood', first.mood, second.mood),
          comparisonRow('Style', first.style, second.style),
          comparisonRow('Budget', first.budgetLevel, second.budgetLevel),
          comparisonRow('Problem Solved', first.spaceProblem, second.spaceProblem),
          comparisonRow('Skills', listText(first.skills), listText(second.skills)),
          comparisonRow('Materials', listText(first.materials), listText(second.materials)),
          comparisonRow('Value Added', first.valueAdded, second.valueAdded),
        ],
      ),
    );
  }
}