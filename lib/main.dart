import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:chat_app/core/theme/app_theme.dart';
import 'package:chat_app/features/auth/data/auth_providers.dart';
import 'package:chat_app/features/auth/presentation/auth_screen.dart';
import 'package:chat_app/features/chat/presentation/chat_screen.dart';
import 'package:chat_app/screens/splash.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    return MaterialApp(
      title: 'FlutterChat',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: authState.when(
        loading: () => const SplashScreen(),
        error: (_, __) => const SplashScreen(),
        data: (user) => user != null ? const ChatScreen() : const AuthScreen(),
      ),
    );
  }
}
