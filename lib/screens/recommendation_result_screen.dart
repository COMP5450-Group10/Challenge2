import 'package:flutter/material.dart';

import '../models/design_project.dart';
import '../services/firestore_service.dart';
import '../widgets/project_card.dart';
import '../utils/app_theme.dart';
import 'project_detail_screen.dart';
import 'contact_screen.dart';

class RecommendationResultScreen extends StatefulWidget {
  final String roomType;
  final String mood;
  final String budgetLevel;
  final String lightingCondition;
  final String spaceProblem;

  const RecommendationResultScreen({
    super.key,
    required this.roomType,
    required this.mood,
    required this.budgetLevel,
    required this.lightingCondition,
    required this.spaceProblem,
  });

  @override
  State<RecommendationResultScreen> createState() =>
      _RecommendationResultScreenState();
}

class _RecommendationResultScreenState
    extends State<RecommendationResultScreen> {
  final FirestoreService service = FirestoreService();

  late Future<List<DesignProject>> projectsFuture;

  @override
  void initState() {
    super.initState();
    projectsFuture = service.getRecommendedProjects(
      roomType: widget.roomType,
      mood: widget.mood,
      budgetLevel: widget.budgetLevel,
      lightingCondition: widget.lightingCondition,
      spaceProblem: widget.spaceProblem,
    );
  }

  String get summary {
    return 'Room: ${widget.roomType}\n'
        'Mood: ${widget.mood}\n'
        'Budget: ${widget.budgetLevel}\n'
        'Lighting: ${widget.lightingCondition}\n'
        'Problem: ${widget.spaceProblem}';
  }

  String get designAdvice {
    if (widget.spaceProblem == 'Too dark') {
      return 'Use layered lighting, lighter surfaces, and reflective materials to brighten the room.';
    } else if (widget.spaceProblem == 'Too small') {
      return 'Use multifunctional furniture, vertical storage, and light colors to visually expand the space.';
    } else if (widget.spaceProblem == 'Disorganized') {
      return 'Use hidden storage, clear zoning, and simplified furniture placement.';
    } else if (widget.spaceProblem == 'Distracting') {
      return 'Use a cleaner layout, task lighting, and reduced visual clutter to support focus.';
    } else {
      return 'Balance lighting, layout, material selection, and mood to improve both function and atmosphere.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Design Match'),
      ),
      body: FutureBuilder<List<DesignProject>>(
        future: projectsFuture,
        builder: (context, snapshot) {
          final projects = snapshot.data ?? [];

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.darkBrown,
                  borderRadius: BorderRadius.circular(26),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your Design Direction',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      summary,
                      style: const TextStyle(
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      designAdvice,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              ElevatedButton.icon(
                icon: const Icon(Icons.mail_outline),
                label: const Text('Request Consultation With This Summary'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ContactScreen(
                        selectedInterest: summary,
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              const Text(
                'Recommended Projects',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 14),

              if (snapshot.connectionState == ConnectionState.waiting)
                const Center(child: CircularProgressIndicator()),

              if (snapshot.hasError)
                Text('Error: ${snapshot.error}'),

              if (snapshot.connectionState != ConnectionState.waiting &&
                  projects.isEmpty)
                const Text(
                  'No exact recommendation found. Try changing one of your preferences.',
                ),

              ...projects.map((project) {
                return ProjectCard(
                  project: project,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProjectDetailScreen(project: project),
                      ),
                    );
                  },
                );
              }),
            ],
          );
        },
      ),
    );
  }
}