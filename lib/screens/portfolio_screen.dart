import 'package:flutter/material.dart';

import '../models/design_project.dart';
import '../services/firestore_service.dart';
import '../widgets/project_card.dart';
import '../utils/app_theme.dart';
import 'project_detail_screen.dart';

class PortfolioScreen extends StatefulWidget {
  final String? selectedRoom;
  final String? selectedMood;
  final String? selectedBudget;

  const PortfolioScreen({
    super.key,
    this.selectedRoom,
    this.selectedMood,
    this.selectedBudget,
  });

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  late Future<List<DesignProject>> _projectsFuture;

  String selectedFilter = 'All';

  final List<String> filters = [
    'All',
    'Bedroom',
    'Living Room',
    'Office',
    'Kitchen',
    'Café',
    'Apartment',
  ];

  @override
  void initState() {
    super.initState();
    _projectsFuture = _firestoreService.getDesignProjects();
  }

  List<DesignProject> getRecommendedProjects(List<DesignProject> projects) {
    if (widget.selectedRoom == null || widget.selectedMood == null) {
      return [];
    }

    final exactMatches = projects.where((project) {
      return project.roomType == widget.selectedRoom &&
          project.mood == widget.selectedMood;
    }).toList();

    if (exactMatches.isNotEmpty) {
      return exactMatches;
    }

    return projects.where((project) {
      return project.roomType == widget.selectedRoom ||
          project.mood == widget.selectedMood;
    }).toList();
  }

  List<DesignProject> applyFilter(List<DesignProject> projects) {
    if (selectedFilter == 'All') {
      return projects;
    }

    return projects.where((project) {
      return project.roomType == selectedFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final hasRecommendation =
        widget.selectedRoom != null && widget.selectedMood != null;

    return FutureBuilder<List<DesignProject>>(
      future: _projectsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error loading projects: ${snapshot.error}'),
          );
        }

        final projects = snapshot.data ?? [];
        final recommendedProjects = getRecommendedProjects(projects);
        final filteredProjects = applyFilter(projects);

        if (projects.isEmpty) {
          return const Center(
            child: Text('No projects found in Firebase.'),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (hasRecommendation)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppTheme.darkBrown,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    'Recommended for ${widget.selectedRoom} spaces with a ${widget.selectedMood} mood.',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),

              if (hasRecommendation) const SizedBox(height: 24),

              if (recommendedProjects.isNotEmpty) ...[
                const Text(
                  'Recommended for You',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkBrown,
                  ),
                ),
                const SizedBox(height: 14),
                ...recommendedProjects.map((project) {
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
                const SizedBox(height: 12),
              ],

              const Text(
                'Explore Portfolio',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkBrown,
                ),
              ),
              const SizedBox(height: 12),

              SizedBox(
                height: 44,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final filter = filters[index];
                    final isSelected = selectedFilter == filter;

                    return ChoiceChip(
                      label: Text(filter),
                      selected: isSelected,
                      onSelected: (_) {
                        setState(() {
                          selectedFilter = filter;
                        });
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 18),

              ...filteredProjects.map((project) {
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
          ),
        );
      },
    );
  }
}