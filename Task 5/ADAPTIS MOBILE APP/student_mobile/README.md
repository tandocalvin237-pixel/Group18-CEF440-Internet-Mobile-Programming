# ADAPTIS Student Mobile App

Flutter source files for the student-facing ADAPTIS mobile demo.

## Run If Native Files Already Exist

```powershell
flutter pub get
flutter run
```

## Generate Android Runner From Workspace Root

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\setup_student_flutter.ps1
cd student_mobile_runner
flutter run
```

The demo uses local mock data and `SharedPreferences` for simulated local progress saving.
