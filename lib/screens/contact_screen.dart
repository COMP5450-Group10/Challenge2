import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class ContactScreen extends StatelessWidget {
  final String? selectedInterest;

  const ContactScreen({
    super.key,
    this.selectedInterest,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Request a Consultation',
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
            color: AppTheme.darkBrown,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Share your design direction and request a personalized interior consultation.',
        ),
        const SizedBox(height: 24),

        if (selectedInterest != null)
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppTheme.darkBrown,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Text(
              selectedInterest!,
              style: const TextStyle(
                color: Colors.white,
                height: 1.5,
              ),
            ),
          ),

        const SizedBox(height: 24),

        TextField(
          decoration: InputDecoration(
            labelText: 'Your name',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
        const SizedBox(height: 14),

        TextField(
          decoration: InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
        const SizedBox(height: 14),

        TextField(
          maxLines: 5,
          decoration: InputDecoration(
            labelText: 'Tell us about your space',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
        const SizedBox(height: 20),

        ElevatedButton.icon(
          icon: const Icon(Icons.send),
          label: const Text('Submit Request'),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Consultation request submitted.'),
              ),
            );
          },
        ),
      ],
    );
  }
}