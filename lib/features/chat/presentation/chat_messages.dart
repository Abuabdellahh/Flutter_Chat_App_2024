import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:chat_app/features/chat/data/chat_providers.dart';
import 'message_bubble.dart';

class ChatMessages extends ConsumerWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messagesAsync = ref.watch(messagesProvider);
    final me = FirebaseAuth.instance.currentUser!;

    return messagesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (snapshot) {
        if (snapshot.docs.isEmpty) {
          return const Center(child: Text('No messages yet.'));
        }
        final docs = snapshot.docs;
        return ListView.builder(
          reverse: true,
          padding:
              const EdgeInsets.only(bottom: 40, left: 13, right: 13),
          itemCount: docs.length,
          itemBuilder: (_, i) {
            final msg = docs[i].data();
            final nextMsg =
                i + 1 < docs.length ? docs[i + 1].data() : null;
            final sameUser = nextMsg?['userId'] == msg['userId'];

            if (sameUser) {
              return MessageBubble.next(
                message: msg['text'] as String,
                isMe: me.uid == msg['userId'],
              );
            }
            return MessageBubble.first(
              userImage: msg['userImage'] as String,
              username: msg['username'] as String,
              message: msg['text'] as String,
              isMe: me.uid == msg['userId'],
            );
          },
        );
      },
    );
  }
}
