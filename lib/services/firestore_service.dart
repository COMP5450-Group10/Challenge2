import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/design_project.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<DesignProject>> getDesignProjects() async {
    final snapshot = await _db.collection('designProjects').get();

    return snapshot.docs.map((doc) {
      return DesignProject.fromMap(doc.id, doc.data());
    }).toList();
  }

  Future<List<DesignProject>> getFeaturedProjects() async {
    final projects = await getDesignProjects();

    return projects.where((project) => project.featured).toList();
  }

  Future<List<DesignProject>> getProjectsByRoom(String roomType) async {
    final projects = await getDesignProjects();

    return projects.where((project) {
      return project.roomType.toLowerCase() == roomType.toLowerCase();
    }).toList();
  }

  Future<List<DesignProject>> getProjectsByMood(String mood) async {
    final projects = await getDesignProjects();

    return projects.where((project) {
      return project.mood.toLowerCase() == mood.toLowerCase();
    }).toList();
  }

  Future<List<DesignProject>> searchProjects(String keyword) async {
    final projects = await getDesignProjects();
    final lowerKeyword = keyword.toLowerCase();

    return projects.where((project) {
      return project.title.toLowerCase().contains(lowerKeyword) ||
          project.roomType.toLowerCase().contains(lowerKeyword) ||
          project.mood.toLowerCase().contains(lowerKeyword) ||
          project.style.toLowerCase().contains(lowerKeyword) ||
          project.budgetLevel.toLowerCase().contains(lowerKeyword) ||
          project.spaceProblem.toLowerCase().contains(lowerKeyword) ||
          project.skills.any((skill) => skill.toLowerCase().contains(lowerKeyword)) ||
          project.materials.any((material) => material.toLowerCase().contains(lowerKeyword)) ||
          project.relatedServices.any((service) => service.toLowerCase().contains(lowerKeyword));
    }).toList();
  }

  Future<List<DesignProject>> getRecommendedProjects({
    required String roomType,
    required String mood,
    required String budgetLevel,
    required String lightingCondition,
    required String spaceProblem,
  }) async {
    final projects = await getDesignProjects();

    final scoredProjects = projects.map((project) {
      int score = 0;

      if (project.roomType == roomType) score += 4;
      if (project.mood == mood) score += 4;
      if (project.budgetLevel == budgetLevel) score += 2;
      if (project.lightingCondition == lightingCondition) score += 2;
      if (project.spaceProblem == spaceProblem) score += 3;

      return {
        'project': project,
        'score': score,
      };
    }).toList();

    scoredProjects.sort((a, b) {
      return (b['score'] as int).compareTo(a['score'] as int);
    });

    return scoredProjects
        .where((item) => item['score'] as int > 0)
        .map((item) => item['project'] as DesignProject)
        .toList();
  }

  Future<List<DesignProject>> getProjectsByService(String serviceName) async {
    final projects = await getDesignProjects();

    return projects.where((project) {
      return project.relatedServices.contains(serviceName);
    }).toList();
  }
}