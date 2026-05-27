import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.cream,
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppTheme.warmBrown,
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.chair_outlined,
                      color: AppTheme.warmBrown,
                      size: 30,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Canvas Interior Studio',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Interior design portfolio',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
          _drawerItem(
            context,
            icon: Icons.design_services_outlined,
            title: 'Services',
            route: '/services',
          ),
          _drawerItem(
            context,
            icon: Icons.architecture_outlined,
            title: 'Design Process',
            route: '/process',
          ),
          _drawerItem(
            context,
            icon: Icons.search,
            title: 'Search Projects',
            route: '/search',
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Portfolio data is stored in Firebase Cloud Firestore.',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String route,
      }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, route);
      },
    );
  }
}