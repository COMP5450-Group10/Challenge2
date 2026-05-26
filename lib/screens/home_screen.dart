import 'dart:math';

import 'package:flutter/material.dart';

import '../models/design_project.dart';
import '../services/firestore_service.dart';
import '../utils/ambient_helper.dart';
import '../utils/app_theme.dart';
import 'project_detail_screen.dart';
import 'recommendation_result_screen.dart';
import 'services_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirestoreService service = FirestoreService();

  late Future<List<DesignProject>> projectsFuture;

  @override
  void initState() {
    super.initState();
    projectsFuture = service.getDesignProjects();
  }

  String getAmbientMood() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return 'Productive';
    } else if (hour >= 12 && hour < 18) {
      return 'Natural';
    } else if (hour >= 18 && hour < 22) {
      return 'Cozy';
    } else {
      return 'Relaxing';
    }
  }

  String getAmbientRoom() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return 'Office';
    } else if (hour >= 12 && hour < 18) {
      return 'Living Room';
    } else if (hour >= 18 && hour < 22) {
      return 'Living Room';
    } else {
      return 'Bedroom';
    }
  }

  String getAmbientProblem() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return 'Distracting';
    } else if (hour >= 12 && hour < 18) {
      return 'Not stylish';
    } else if (hour >= 18 && hour < 22) {
      return 'Too dark';
    } else {
      return 'Too crowded';
    }
  }

  String getDesignTip() {
    final tips = [
      'For a dark room, use layered lighting instead of relying on one ceiling light.',
      'For a small space, use vertical storage and furniture with exposed legs.',
      'For a calmer room, limit the palette to two or three main colors.',
      'For a productive workspace, separate storage, lighting, and focus zones.',
      'For a cozy living room, combine warm lighting, soft textiles, and natural materials.',
    ];

    return tips[DateTime.now().day % tips.length];
  }

  void openRecommendation({
    required String roomType,
    required String mood,
    required String budgetLevel,
    required String lightingCondition,
    required String spaceProblem,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RecommendationResultScreen(
          roomType: roomType,
          mood: mood,
          budgetLevel: budgetLevel,
          lightingCondition: lightingCondition,
          spaceProblem: spaceProblem,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final greeting = AmbientHelper.getGreeting();
    final message = AmbientHelper.getAmbientMessage();

    final ambientMood = getAmbientMood();
    final ambientRoom = getAmbientRoom();
    final ambientProblem = getAmbientProblem();

    return FutureBuilder<List<DesignProject>>(
      future: projectsFuture,
      builder: (context, snapshot) {
        final projects = snapshot.data ?? [];
        final featuredProjects =
        projects.where((project) => project.featured).toList();

        final caseStudy = featuredProjects.isNotEmpty
            ? featuredProjects.first
            : projects.isNotEmpty
            ? projects.first
            : null;

        final lightingProjects = projects.where((project) {
          return project.relatedServices.contains('Lighting Design');
        }).toList();

        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
          children: [
            Text(
              greeting,
              style: const TextStyle(
                fontSize: 31,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkBrown,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                color: AppTheme.charcoal,
              ),
            ),
            const SizedBox(height: 22),

            _ambientHeroCard(
              mood: ambientMood,
              room: ambientRoom,
              problem: ambientProblem,
            ),

            const SizedBox(height: 28),

            _sectionTitle('What problem are you solving?'),
            const SizedBox(height: 12),
            _problemSolverSection(),


            const SizedBox(height: 30),

            if (snapshot.connectionState == ConnectionState.waiting)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: CircularProgressIndicator(),
                ),
              ),

            if (caseStudy != null) ...[
              _sectionTitle('Featured Case Study'),
              const SizedBox(height: 12),
              _caseStudyCard(caseStudy),
              const SizedBox(height: 30),
            ],

            _designTipCard(),

            const SizedBox(height: 30),

            _sectionTitle('Skill Spotlight'),
            const SizedBox(height: 12),
            _skillSpotlightCard(lightingProjects),

            const SizedBox(height: 30),

            _sectionTitle('Mood Directions'),
            const SizedBox(height: 12),

            SizedBox(
              height: 140,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _moodDirectionCard(
                    title: 'Cozy Evening',
                    mood: 'Cozy',
                    roomType: 'Living Room',
                    imagePath: 'assets/images/natural_living_room.jpg',
                    description: 'Warm light, soft seating, and calm textures.',
                  ),
                  _moodDirectionCard(
                    title: 'Focused Morning',
                    mood: 'Productive',
                    roomType: 'Office',
                    imagePath: 'assets/images/productive_home_office.jpg',
                    description: 'Clean layout, task lighting, and low clutter.',
                  ),
                  _moodDirectionCard(
                    title: 'Quiet Night',
                    mood: 'Relaxing',
                    roomType: 'Bedroom',
                    imagePath: 'assets/images/warm_minimal_bedroom.jpg',
                    description: 'Soft lighting and restful material choices.',
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _problemSolverSection() {
    final problems = [
      {
        'icon': Icons.open_in_full,
        'title': 'Cramped room',
        'subtitle': 'Make the room feel more spacious',
        'color': const Color(0xFFB98B60),
        'roomType': 'Apartment',
        'mood': 'Functional',
        'budgetLevel': 'Low',
        'lightingCondition': 'Medium',
        'spaceProblem': 'Too small',
      },
      {
        'icon': Icons.light_mode_outlined,
        'title': 'Dark room',
        'subtitle': 'Improve mood with lighting',
        'color': const Color(0xFFC4A35A),
        'roomType': 'Bedroom',
        'mood': 'Relaxing',
        'budgetLevel': 'Medium',
        'lightingCondition': 'Dark',
        'spaceProblem': 'Too dark',
      },
      {
        'icon': Icons.inventory_2_outlined,
        'title': 'Disorganized',
        'subtitle': 'Use storage and zoning',
        'color': const Color(0xFF8FA58E),
        'roomType': 'Apartment',
        'mood': 'Functional',
        'budgetLevel': 'Low',
        'lightingCondition': 'Medium',
        'spaceProblem': 'Disorganized',
      },
      {
        'icon': Icons.palette_outlined,
        'title': 'Not Stylish',
        'subtitle': 'Create a clear identity',
        'color': const Color(0xFF8B5E3C),
        'roomType': 'Living Room',
        'mood': 'Luxury',
        'budgetLevel': 'High',
        'lightingCondition': 'Medium',
        'spaceProblem': 'Not stylish',
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        int columns;
        double cardHeight;

        if (width >= 1000) {
          columns = 4;
          cardHeight = 190;
        } else if (width >= 700) {
          columns = 2;
          cardHeight = 180;
        } else {
          columns = 2;
          cardHeight = 155;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: problems.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            mainAxisExtent: cardHeight,
          ),
          itemBuilder: (context, index) {
            final problem = problems[index];

            return _responsiveProblemCard(
              icon: problem['icon'] as IconData,
              title: problem['title'] as String,
              subtitle: problem['subtitle'] as String,
              color: problem['color'] as Color,
              onTap: () {
                openRecommendation(
                  roomType: problem['roomType'] as String,
                  mood: problem['mood'] as String,
                  budgetLevel: problem['budgetLevel'] as String,
                  lightingCondition: problem['lightingCondition'] as String,
                  spaceProblem: problem['spaceProblem'] as String,
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _responsiveProblemCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWideCard = constraints.maxWidth > 220;

        final iconSize = isWideCard ? 34.0 : 26.0;
        final titleSize = isWideCard ? 20.0 : 16.0;
        final subtitleSize = isWideCard ? 14.0 : 12.0;
        final padding = isWideCard ? 22.0 : 16.0;
        final avatarRadius = isWideCard ? 28.0 : 22.0;

        return Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          elevation: 5,
          shadowColor: Colors.black12,
          child: InkWell(
            borderRadius: BorderRadius.circular(28),
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.all(padding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: color.withOpacity(0.18),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: avatarRadius,
                    backgroundColor: color.withOpacity(0.14),
                    child: Icon(
                      icon,
                      color: color,
                      size: iconSize,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppTheme.darkBrown,
                      fontSize: titleSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: subtitleSize,
                      height: 1.25,
                      color: AppTheme.charcoal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _ambientHeroCard({
    required String mood,
    required String room,
    required String problem,
  }) {
    return GestureDetector(
      onTap: () {
        openRecommendation(
          roomType: room,
          mood: mood,
          budgetLevel: 'Medium',
          lightingCondition: mood == 'Relaxing' ? 'Dark' : 'Medium',
          spaceProblem: problem,
        );
      },
      child: Container(
        height: 255,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(34),
          image: const DecorationImage(
            image: AssetImage('assets/images/natural_living_room.jpg'),
            fit: BoxFit.cover,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(34),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withOpacity(0.72),
                Colors.black.withOpacity(0.05),
              ],
            ),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Today’s Ambient Direction',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$mood $room',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 31,
                    fontWeight: FontWeight.bold,
                    height: 1.05,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Tap to see projects that match your current time and atmosphere.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.86),
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _problemCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(26),
      elevation: 4,
      shadowColor: Colors.black12,
      child: InkWell(
        borderRadius: BorderRadius.circular(26),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            border: Border.all(
              color: color.withOpacity(0.18),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.14),
                child: Icon(
                  icon,
                  color: color,
                ),
              ),
              const Spacer(),
              Text(
                title,
                style: const TextStyle(
                  color: AppTheme.darkBrown,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.charcoal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _caseStudyCard(DesignProject project) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProjectDetailScreen(project: project),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 18,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              child: Image.asset(
                project.imageUrl,
                height: 190,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.darkBrown,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${project.roomType} • ${project.mood} • ${project.style}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 14),
                  _miniLabel('Problem'),
                  Text(project.challenge),
                  const SizedBox(height: 12),
                  _miniLabel('Value Added'),
                  Text(project.valueAdded),
                  const SizedBox(height: 14),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Read case study',
                        style: TextStyle(
                          color: AppTheme.warmBrown,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward,
                        size: 18,
                        color: AppTheme.warmBrown,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _designTipCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppTheme.darkBrown,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.tips_and_updates_outlined,
              color: AppTheme.warmBrown,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Designer Tip',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  getDesignTip(),
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _skillSpotlightCard(List<DesignProject> projects) {
    final displayProjects = projects.take(3).toList();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: AppTheme.softBeige,
          width: 1.2,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              CircleAvatar(
                backgroundColor: AppTheme.softBeige,
                child: Icon(
                  Icons.lightbulb_outline,
                  color: AppTheme.warmBrown,
                ),
              ),
              SizedBox(width: 12),
              Text(
                'Lighting Design',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkBrown,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'Lighting controls comfort, focus, mood, and visual depth. This is one of the strongest ways an interior designer adds value.',
            style: TextStyle(height: 1.35),
          ),
          const SizedBox(height: 16),

          if (displayProjects.isEmpty)
            const Text('No lighting-related projects found.'),

          ...displayProjects.map((project) {
            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  project.imageUrl,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                project.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${project.roomType} • ${project.mood}'),
              trailing: const Icon(Icons.chevron_right),
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

          const SizedBox(height: 8),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              icon: const Icon(Icons.design_services_outlined),
              label: const Text('View services'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ServicesScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _moodDirectionCard({
    required String title,
    required String mood,
    required String roomType,
    required String imagePath,
    required String description,
  }) {
    return GestureDetector(
      onTap: () {
        openRecommendation(
          roomType: roomType,
          mood: mood,
          budgetLevel: 'Medium',
          lightingCondition: 'Medium',
          spaceProblem: 'Not stylish',
        );
      },
      child: Container(
        width: 235,
        margin: const EdgeInsets.only(right: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withOpacity(0.70),
                Colors.transparent,
              ],
            ),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: AppTheme.darkBrown,
        fontSize: 23,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _miniLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          color: AppTheme.warmBrown,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}