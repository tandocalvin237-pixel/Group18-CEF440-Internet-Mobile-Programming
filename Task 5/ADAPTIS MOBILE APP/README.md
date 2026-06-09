# ADAPTIS Demo Frontend

ADAPTIS is a frontend-only demo for an adaptive e-learning platform designed for Cameroon and other low-internet environments.

This workspace contains:

- `student_mobile/` - Flutter + Dart student mobile app.
- `adaptis_web/` - React + Vite teacher and admin dashboards.
- `shared_assets/` - logo assets extracted from the provided ADAPTIS package.

## Requirements

- Flutter SDK
- Node.js LTS
- npm

## Run Student Mobile App

If Flutter has already generated native project files inside `student_mobile`, run:

```powershell
cd student_mobile
flutter pub get
flutter run
```

If this is a fresh machine/folder and `student_mobile` only contains source files, generate a runnable Android project with:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\setup_student_flutter.ps1
cd student_mobile_runner
flutter run
```

## Run Teacher/Admin Web Dashboard

```powershell
cd adaptis_web
npm install
npm run dev
```

Then open the Vite URL shown in the terminal, usually `http://localhost:5173`.

## Demo Accounts

These are simulated. Any password works.

- Student: `student@adaptis.cm`
- Teacher: `teacher@adaptis.cm`
- Admin: `admin@adaptis.cm`

## Demo Story

1. Student logs in and sees enrolled courses.
2. Student opens a course and starts a lesson.
3. Connection quality changes between Good, Fair, and Poor.
4. Content mode changes between HD Video, SD Video, and Audio + Text.
5. Student enables Data Saver mode.
6. Student downloads a lesson for offline access.
7. Progress is saved locally.
8. Student attempts a quiz and sees results.
9. Teacher views courses, students, messages, and creates learning content.
10. Admin views users, courses, QoE/network analytics, notifications, and reports.
