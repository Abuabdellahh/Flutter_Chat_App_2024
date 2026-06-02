# Flutter Chat App 2024

Real-time chat app built with Flutter + Firebase, following Clean Architecture.

## Stack
- Flutter 3 / Dart 3
- Firebase Auth, Firestore, Storage, Messaging
- Riverpod 2 (state management)
- Cloud Functions (Node 18) — push notifications
- Docker + Nginx (web deployment)

## Folder Structure
```
lib/
├── core/
│   ├── theme/          # App-wide ThemeData
│   └── utils/          # Validators, helpers
├── features/
│   ├── auth/
│   │   ├── data/       # AuthRepository + Riverpod providers
│   │   └── presentation/ # AuthScreen, UserImagePicker
│   └── chat/
│       ├── data/       # ChatRepository + Riverpod providers
│       └── presentation/ # ChatScreen, ChatMessages, NewMessage, MessageBubble
├── screens/
│   └── splash.dart
├── firebase_options.dart
└── main.dart
```

## Run locally
```bash
flutter pub get
flutter run
```

## Deploy web (Docker)
```bash
docker compose up --build
```
App served at http://localhost:8080

## Deploy Firebase Functions
```bash
cd functions && npm install
firebase deploy --only functions
```
