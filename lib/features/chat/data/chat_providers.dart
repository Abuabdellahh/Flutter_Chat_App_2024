import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'chat_repository.dart';

final chatRepositoryProvider =
    Provider<ChatRepository>((_) => ChatRepository());

final messagesProvider = StreamProvider(
  (ref) => ref.watch(chatRepositoryProvider).messagesStream(),
);
