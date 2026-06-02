import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatRepository {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> messagesStream() => _db
      .collection('chat')
      .orderBy('createdAt', descending: true)
      .snapshots();

  Future<void> sendMessage(String text) async {
    final user = _auth.currentUser!;
    final userData =
        await _db.collection('users').doc(user.uid).get();
    await _db.collection('chat').add({
      'text': text,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData['username'],
      'userImage': userData['image_url'],
    });
  }
}
