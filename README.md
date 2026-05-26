# Canvas Interior Studio – Multi-Platform Interior Designer Portfolio App

## Project Overview

**Canvas Interior Studio** is a Flutter/Dart portfolio application designed for an interior designer. The app showcases interior design projects, design services, and client-focused design solutions through a mobile-first interface.

The project applies the idea of **ambient computing** as a multi-platform design approach. In this project, ambient computing means that the portfolio experience can exist across different platforms and devices, such as Android, web, and potentially iOS, while maintaining a consistent design style, data source, and user experience.

Instead of building a portfolio that only works as a static mobile gallery, this app uses Flutter to support cross-platform deployment and Firebase to provide a shared cloud database for portfolio content. This allows the same portfolio data and design experience to be reused across different devices.

The main goal of the app is to demonstrate how an interior designer can present professional value to potential clients through space planning, lighting design, material selection, color coordination, and mood-based design solutions.

---

## Assignment Theme

The theme of this project is:

> **Interior Designer Portfolio with Ambient Computing**

In this project, ambient computing is interpreted as creating a portfolio experience that can work across multiple platforms while keeping the same design identity and Firebase-powered data source.

The app is built as a professional portfolio for an interior design studio. It does not only display project images; it also explains the design challenge, design solution, skills used, materials selected, and value added for each project.

---

## Main Features

### 1. Mobile-First Portfolio UI

The app is designed primarily for mobile devices, while still being suitable for other Flutter-supported platforms.

The UI includes:

- App bar
- Bottom navigation bar
- Drawer menu
- Scrollable mobile layouts
- Large visual project cards
- Rounded cards and soft shadows
- Warm interior-design-inspired color palette

The visual style uses warm neutral colors, soft beige backgrounds, brown accents, and image-focused cards to match the interior design theme.

---

### 2. Multi-Platform Flutter Structure

Flutter allows the app to support multiple platforms from one codebase.

The project can support:

```text
Android
Web
iOS, if configured
Other Flutter-supported platforms, if enabled
```

This connects to the ambient computing requirement because the portfolio is not limited to one device or one fixed environment. The same portfolio experience can be accessed across different platforms while using the same Dart codebase and Firebase database.

---

### 3. Firebase Firestore Portfolio Database

The app uses **Firebase Cloud Firestore** to store and load portfolio data.

The main Firestore collection is:

```text
designProjects
```

Each document stores one interior design project, including fields such as:

```text
title
roomType
mood
style
budgetLevel
timeContext
lightingCondition
spaceProblem
imageUrl
challenge
solution
valueAdded
beforeDescription
afterDescription
skills
materials
colorPalette
relatedServices
featured
```

This allows the app to dynamically load portfolio content from Firebase instead of hardcoding every project directly into the UI.

Because Firebase is cloud-based, the same portfolio data can be used by the app across different platforms.

---

### 4. Local Fallback Dataset

To make the app easier to demonstrate without Firebase access, the app can also include a local fallback dataset.

If Firestore data cannot be loaded because of network, permission, or Firebase access issues, the app can still display local sample project data from Dart files.

This makes the project more reliable for demonstration and grading.

---

### 5. Designer-Style Homepage

The homepage works as a professional interior design dashboard rather than a simple navigation menu.

It includes:

- Stylish hero section
- Problem-solving cards
- Featured case study
- Daily design tip
- Skill spotlight
- Mood direction cards

The homepage is designed to immediately show the value of the interior designer instead of only showing buttons or links.

---

### 6. Design Match Quiz

The app includes an interactive design quiz where users select:

- Room type
- Desired mood
- Budget level
- Lighting condition
- Space problem

Example choices include:

```text
Room Type: Bedroom, Living Room, Office, Kitchen, Café
Mood: Cozy, Relaxing, Productive, Luxury, Natural
Budget: Low, Medium, High
Lighting: Bright, Medium, Dark
Problem: Too small, Too dark, Disorganized, Not stylish, Distracting
```

After the quiz, the app recommends suitable portfolio projects from the Firestore dataset.

---

### 7. Recommendation Result Page

After the quiz, the app displays a personalized recommendation result.

The result page shows:

- User’s selected design direction
- Suggested design advice
- Recommended projects
- Consultation request option

This feature shows how a portfolio can provide value to potential clients instead of only displaying previous work.

---

### 8. Explore by Room and Mood

The Explore page allows users to browse portfolio projects by:

- Room type
- Mood

Example room filters:

```text
Bedroom
Living Room
Office
Kitchen
Café
Apartment
Study
Bathroom
Dining Room
Retail
```

Example mood filters:

```text
Cozy
Relaxing
Productive
Luxury
Natural
Minimal
Fresh
Functional
```

This gives users a more meaningful way to explore the portfolio.

---

### 9. Project Detail Page

Each project has a detail page that explains the design work in depth.

Each detail page includes:

- Project image
- Room type
- Mood
- Style
- Budget level
- Design challenge
- Design solution
- Value added
- Before description
- After description
- Skills demonstrated
- Materials used
- Color palette
- Related services

This helps showcase the designer’s skills, not just project images.

---

### 10. Saved / Favorites Page

Users can save favorite projects by tapping the heart icon on project cards.

The Saved page displays the user’s saved inspirations. This gives the app a more personalized portfolio browsing experience.

---

### 11. Project Comparison

The Explore page allows users to compare two projects.

The comparison page compares:

- Room type
- Mood
- Style
- Budget
- Problem solved
- Skills
- Materials
- Value added

This helps potential clients understand different design directions more clearly.

---

### 12. Services with Related Projects

The Services page shows interior design services such as:

- Space Planning
- Lighting Design
- Color Consultation
- Storage Optimization
- Luxury Styling

Each service is connected to related portfolio projects. This makes the services more convincing because users can see portfolio evidence for each skill.

---

### 13. Design Process Page

The Design Process page explains how the interior designer works.

The process includes:

1. Understand the client
2. Analyze the space
3. Build mood direction
4. Plan layout and lighting
5. Select materials
6. Present final concept

This page helps explain the designer’s professional value.

---

### 14. Search Feature

The app includes a search page where users can search projects by keywords such as:

```text
bedroom
lighting
wood
luxury
small space
office
cozy
storage
```

The search function looks through project title, room type, mood, style, budget, problem, skills, materials, and related services.

---

### 15. Mood-Based Theme Switching

The app can update its visual accent based on selected mood.

Example:

```text
Cozy       → warm brown accent
Natural    → sage green accent
Luxury     → gold accent
Productive → blue accent
Relaxing   → soft calming accent
```

This supports the portfolio’s design-focused experience by making the UI visually respond to design mood selections.

---

## App Navigation

### Bottom Navigation Bar

The bottom navigation is used for the main mobile actions:

```text
Home
Explore
Match
Saved
Contact
```

### Drawer Menu

The drawer is used for secondary pages:

```text
Services
Design Process
Search Projects
```

The drawer does not repeat the bottom navigation items. This keeps the navigation structure cleaner.

---

## Firebase Database Structure

### Main Collection

```text
designProjects
```

### Example Document

```json
{
  "title": "Warm Minimal Bedroom",
  "roomType": "Bedroom",
  "mood": "Relaxing",
  "style": "Minimal",
  "budgetLevel": "Medium",
  "timeContext": "Night",
  "lightingCondition": "Dark",
  "spaceProblem": "Too crowded",
  "imageUrl": "assets/images/warm_minimal_bedroom.jpg",
  "challenge": "The original room felt dark, crowded, and visually stressful.",
  "solution": "Warm indirect lighting, light textiles, and hidden storage were used to create a calmer sleeping space.",
  "valueAdded": "Improved comfort, visual openness, and emotional relaxation.",
  "beforeDescription": "Dark corners, visible clutter, and heavy furniture made the bedroom feel stressful.",
  "afterDescription": "The redesigned bedroom feels warmer, brighter, and more peaceful for nighttime rest.",
  "skills": ["Lighting Design", "Space Planning", "Storage Optimization"],
  "materials": ["Wood", "Linen", "Warm LED"],
  "colorPalette": ["Cream", "Warm Brown", "Soft Beige"],
  "relatedServices": ["Lighting Design", "Space Planning", "Storage Optimization"],
  "featured": true
}
```

---

## Project Folder Structure

```text
lib/
 ├── main.dart
 ├── firebase_options.dart
 ├── models/
 │    └── design_project.dart
 ├── services/
 │    ├── firestore_service.dart
 │    └── seed_data_service.dart
 ├── state/
 │    ├── app_state.dart
 │    └── favorites_state.dart
 ├── screens/
 │    ├── main_navigation_screen.dart
 │    ├── home_screen.dart
 │    ├── explore_screen.dart
 │    ├── match_quiz_screen.dart
 │    ├── recommendation_result_screen.dart
 │    ├── saved_screen.dart
 │    ├── contact_screen.dart
 │    ├── project_detail_screen.dart
 │    ├── compare_screen.dart
 │    ├── search_screen.dart
 │    ├── services_screen.dart
 │    └── design_process_screen.dart
 ├── widgets/
 │    ├── app_drawer.dart
 │    └── project_card.dart
 ├── utils/
 │    ├── app_theme.dart
 │    └── ambient_helper.dart
 └── data/
      └── local_project_data.dart
```

---

## Assets

Interior design images are stored in:

```text
assets/images/
```

Example image files:

```text
warm_minimal_bedroom.jpg
natural_living_room.jpg
productive_home_office.jpg
luxury_apartment_lounge.jpg
scandinavian_kitchen.jpg
cozy_cafe_corner.jpg
compact_studio_apartment.jpg
calm_reading_nook.jpg
spa_inspired_bathroom.jpg
quiet_student_study.jpg
```

The images are registered in `pubspec.yaml`:

```yaml
flutter:
  uses-material-design: true

  assets:
    - assets/images/
```

---

## Technologies Used

- Flutter
- Dart
- Firebase Core
- Cloud Firestore
- Provider
- Material Design 3
- Android Emulator / Mobile Device Testing
- Flutter Web, if enabled

---

## How to Run the Project

### 1. Install dependencies

Run:

```bash
flutter pub get
```

### 2. Check Flutter setup

Run:

```bash
flutter doctor
```

### 3. Run the app

For Android:

```bash
flutter run
```

For web, if web support is enabled:

```bash
flutter run -d chrome
```

Or open the project in IntelliJ IDEA and run it on an Android emulator.

---

## Firebase Setup Notes

This project uses Firebase Firestore as the main portfolio database.

To connect Firebase, the project uses:

```text
lib/firebase_options.dart
```

Firebase is initialized in `main.dart`:

```dart
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```

The Firestore service reads project documents from:

```text
designProjects
```

---

## Firestore Security Rule for Demo

For a public portfolio demo, the Firestore rule can allow read access while blocking write access:

```js
rules_version = '2';

service cloud.firestore {
  match /databases/{database}/documents {
    match /designProjects/{projectId} {
      allow read: if true;
      allow write: if false;
    }
  }
}
```

During development, write access may be temporarily enabled to upload seed data, but it should be disabled again afterward.

---

## How the Dataset Was Created

The project dataset was prepared as a list of interior design portfolio documents. A temporary seed service was used to upload sample project documents to Firestore.

Each document represents one interior design case study and includes:

- Basic project information
- Design challenge
- Design solution
- Value added
- Skills
- Materials
- Color palette
- Related services

This dataset allows the app to support filtering, searching, recommendation, services matching, and project comparison.

---

## Ambient Computing / Multi-Platform Application

In this project, ambient computing is interpreted as a **multi-platform computing experience**. The app is not designed for only one fixed device environment. Instead, it uses Flutter and Firebase to support a consistent portfolio experience across multiple platforms.

The project demonstrates this through:

```text
One Flutter/Dart codebase
Android support
Web support, if enabled
Shared Firebase Firestore database
Consistent UI design across platforms
Cloud-based portfolio data
Reusable project dataset
```

The portfolio data is not tied to one device. It can be loaded from Firebase and displayed on supported platforms using the same app structure.

---

## Design Value

The app focuses on showing the value an interior designer provides.

Instead of only showing images, each project explains:

```text
What problem existed before
What design solution was applied
What skills were used
What materials were selected
What value was added to the space
```

This directly supports the goal of a professional portfolio: attracting potential clients by showing the designer’s speciality, skills, and impact.

---

## Submission Notes

Before submitting the project, generated files and cache folders should be removed.

Do not include:

```text
build/
.dart_tool/
.idea/
android/.gradle/
android/build/
android/app/build/
*.iml
```

Recommended submitted files:

```text
lib/
assets/
android/
web/ optional
pubspec.yaml
pubspec.lock
README.md
```

Run this before zipping:

```bash
flutter clean
```

Then zip the cleaned project folder.

If submitting through Gmail, remove or avoid blocked executable/script files such as:

```text
gradlew.bat
build/
.apk files
```

Alternatively, upload the cleaned project to GitHub or Google Drive and submit the link.

---

## Conclusion

Canvas Interior Studio is a Flutter mobile portfolio app that combines interior design presentation, Firebase-based data storage, and multi-platform ambient computing concepts. The app provides an interactive and professional portfolio experience by allowing users to explore design projects, compare works, search by design needs, and view designer services across a shared Firebase-powered app structure.
