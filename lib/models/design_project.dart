class DesignProject {
  final String id;
  final String title;
  final String roomType;
  final String mood;
  final String style;
  final String budgetLevel;
  final String timeContext;
  final String lightingCondition;
  final String spaceProblem;
  final String imageUrl;
  final String challenge;
  final String solution;
  final String valueAdded;
  final String beforeDescription;
  final String afterDescription;
  final List<String> skills;
  final List<String> materials;
  final List<String> colorPalette;
  final List<String> relatedServices;
  final bool featured;

  DesignProject({
    required this.id,
    required this.title,
    required this.roomType,
    required this.mood,
    required this.style,
    required this.budgetLevel,
    required this.timeContext,
    required this.lightingCondition,
    required this.spaceProblem,
    required this.imageUrl,
    required this.challenge,
    required this.solution,
    required this.valueAdded,
    required this.beforeDescription,
    required this.afterDescription,
    required this.skills,
    required this.materials,
    required this.colorPalette,
    required this.relatedServices,
    required this.featured,
  });

  factory DesignProject.fromMap(String id, Map<String, dynamic> data) {
    return DesignProject(
      id: id,
      title: data['title'] ?? '',
      roomType: data['roomType'] ?? '',
      mood: data['mood'] ?? '',
      style: data['style'] ?? '',
      budgetLevel: data['budgetLevel'] ?? '',
      timeContext: data['timeContext'] ?? '',
      lightingCondition: data['lightingCondition'] ?? '',
      spaceProblem: data['spaceProblem'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      challenge: data['challenge'] ?? '',
      solution: data['solution'] ?? '',
      valueAdded: data['valueAdded'] ?? '',
      beforeDescription: data['beforeDescription'] ?? '',
      afterDescription: data['afterDescription'] ?? '',
      skills: List<String>.from(data['skills'] ?? []),
      materials: List<String>.from(data['materials'] ?? []),
      colorPalette: List<String>.from(data['colorPalette'] ?? []),
      relatedServices: List<String>.from(data['relatedServices'] ?? []),
      featured: data['featured'] ?? false,
    );
  }
}