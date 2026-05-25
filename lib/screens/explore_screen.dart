import 'package:flutter/material.dart';

import '../models/design_project.dart';
import '../services/firestore_service.dart';
import '../widgets/project_card.dart';
import '../utils/app_theme.dart';
import 'project_detail_screen.dart';
import 'compare_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final FirestoreService service = FirestoreService();

  late Future<List<DesignProject>> projectsFuture;

  String selectedRoom = 'All';
  String selectedMood = 'All';

  final List<String> rooms = [
    'All',
    'Bedroom',
    'Living Room',
    'Office',
    'Kitchen',
    'Café',
    'Apartment',
    'Study',
    'Bathroom',
    'Dining Room',
    'Retail',
  ];

  final List<String> moods = [
    'All',
    'Cozy',
    'Relaxing',
    'Productive',
    'Luxury',
    'Natural',
    'Minimal',
    'Fresh',
    'Functional',
  ];

  DesignProject? compareProject;

  @override
  void initState() {
    super.initState();
    projectsFuture = service.getDesignProjects();
  }

  List<DesignProject> applyFilters(List<DesignProject> projects) {
    return projects.where((project) {
      final matchRoom = selectedRoom == 'All' || project.roomType == selectedRoom;
      final matchMood = selectedMood == 'All' || project.mood == selectedMood;
      return matchRoom && matchMood;
    }).toList();
  }

  Widget horizontalFilter({
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
            color: AppTheme.darkBrown,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 44,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: options.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final option = options[index];

              return ChoiceChip(
                label: Text(option),
                selected: selectedValue == option,
                onSelected: (_) {
                  onSelected(option);
                },
              );
            },
          ),
        ),
        const SizedBox(height: 18),
      ],
    );
  }

  void handleCompare(DesignProject project) {
    if (compareProject == null) {
      setState(() {
        compareProject = project;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${project.title} selected for comparison. Choose another project.'),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CompareScreen(
            first: compareProject!,
            second: project,
          ),
        ),
      );

      setState(() {
        compareProject = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DesignProject>>(
      future: projectsFuture,
      builder: (context, snapshot) {
        final projects = snapshot.data ?? [];
        final filteredProjects = applyFilters(projects);

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          children: [
            const Text(
              'Explore by Room and Mood',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkBrown,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Browse the portfolio through interior design contexts instead of a static gallery.',
            ),
            const SizedBox(height: 24),

            horizontalFilter(
              title: 'Room Type',
              options: rooms,
              selectedValue: selectedRoom,
              onSelected: (value) {
                setState(() {
                  selectedRoom = value;
                });
              },
            ),

            horizontalFilter(
              title: 'Mood',
              options: moods,
              selectedValue: selectedMood,
              onSelected: (value) {
                setState(() {
                  selectedMood = value;
                });
              },
            ),

            Text(
              '${filteredProjects.length} projects found',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            ...filteredProjects.map((project) {
              return ProjectCard(
                project: project,
                onCompare: () => handleCompare(project),
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
    );
  }
}