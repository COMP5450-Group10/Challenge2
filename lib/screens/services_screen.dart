import 'package:flutter/material.dart';

import '../services/firestore_service.dart';
import '../models/design_project.dart';
import '../widgets/project_card.dart';
import '../utils/app_theme.dart';
import 'project_detail_screen.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final FirestoreService service = FirestoreService();

  final List<Map<String, dynamic>> services = const [
    {
      'name': 'Space Planning',
      'icon': Icons.grid_view_outlined,
      'description': 'Optimizing layout, movement, zoning, and furniture placement.',
    },
    {
      'name': 'Lighting Design',
      'icon': Icons.lightbulb_outline,
      'description': 'Creating ambient, task, and accent lighting for different moods.',
    },
    {
      'name': 'Color Consultation',
      'icon': Icons.palette_outlined,
      'description': 'Selecting color palettes that support emotion and visual harmony.',
    },
    {
      'name': 'Storage Optimization',
      'icon': Icons.inventory_2_outlined,
      'description': 'Improving organization with hidden and functional storage systems.',
    },
    {
      'name': 'Luxury Styling',
      'icon': Icons.diamond_outlined,
      'description': 'Using premium materials and details to create high-end interiors.',
    },
  ];

  String selectedService = 'Space Planning';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Design Services'),
      ),
      body: FutureBuilder<List<DesignProject>>(
        future: service.getProjectsByService(selectedService),
        builder: (context, snapshot) {
          final projects = snapshot.data ?? [];

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Text(
                'Services Connected to Portfolio Evidence',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkBrown,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Each service is supported by real portfolio projects from Firebase.',
              ),
              const SizedBox(height: 20),

              ...services.map((item) {
                final isSelected = selectedService == item['name'];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    tileColor: isSelected ? AppTheme.softBeige : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    leading: Icon(item['icon']),
                    title: Text(item['name']),
                    subtitle: Text(item['description']),
                    onTap: () {
                      setState(() {
                        selectedService = item['name'];
                      });
                    },
                  ),
                );
              }),

              const SizedBox(height: 24),
              Text(
                'Related Projects: $selectedService',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 14),

              if (snapshot.connectionState == ConnectionState.waiting)
                const Center(child: CircularProgressIndicator()),

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