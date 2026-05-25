import 'package:flutter/material.dart';

import '../models/design_project.dart';
import '../services/firestore_service.dart';
import '../widgets/project_card.dart';
import 'project_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final FirestoreService service = FirestoreService();

  String keyword = '';
  Future<List<DesignProject>>? searchFuture;

  void search() {
    setState(() {
      searchFuture = service.searchProjects(keyword);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Projects'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search bedroom, lighting, luxury, wood...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onChanged: (value) {
              keyword = value;
            },
            onSubmitted: (_) => search(),
          ),
          const SizedBox(height: 14),
          ElevatedButton(
            onPressed: search,
            child: const Text('Search'),
          ),
          const SizedBox(height: 24),

          if (searchFuture != null)
            FutureBuilder<List<DesignProject>>(
              future: searchFuture,
              builder: (context, snapshot) {
                final results = snapshot.data ?? [];

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (results.isEmpty) {
                  return const Text('No matching projects found.');
                }

                return Column(
                  children: results.map((project) {
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
                  }).toList(),
                );
              },
            ),
        ],
      ),
    );
  }
}