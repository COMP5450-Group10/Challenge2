import 'package:flutter/material.dart';
import '../services/seed_data_service.dart';

class SeedDataScreen extends StatelessWidget {
  const SeedDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SeedDataService seedDataService = SeedDataService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seed Firebase Data'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              await seedDataService.uploadDesignProjects();

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Design projects uploaded successfully.'),
                ),
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Upload failed: $e'),
                ),
              );
            }
          },
          child: const Text('Upload Design Projects'),
        ),
      ),
    );
  }
}