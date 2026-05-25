class AmbientHelper {
  static String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return 'Good morning';
    } else if (hour >= 12 && hour < 18) {
      return 'Good afternoon';
    } else if (hour >= 18 && hour < 22) {
      return 'Good evening';
    } else {
      return 'Design a calmer night space';
    }
  }

  static String getAmbientMessage() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return 'Explore bright and productive interiors for a fresh start.';
    } else if (hour >= 12 && hour < 18) {
      return 'Discover balanced spaces for working, living, and relaxing.';
    } else if (hour >= 18 && hour < 22) {
      return 'Find warm and cozy designs for your evening mood.';
    } else {
      return 'Soft lighting and calm layouts can make your space feel peaceful.';
    }
  }
}