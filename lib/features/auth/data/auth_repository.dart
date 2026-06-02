import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthRepository {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> signIn(String email, String password) =>
      _auth.signInWithEmailAndPassword(email: email, password: password);

  Future<void> signUp({
    required String email,
    required String password,
    required String username,
    required File image,
  }) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final ref = _storage
        .ref()
        .child('user_images')
        .child('${cred.user!.uid}.jpg');
    await ref.putFile(image);
    final imageUrl = await ref.getDownloadURL();
    await _firestore.collection('users').doc(cred.user!.uid).set({
      'username': username,
      'email': email,
      'image_url': imageUrl,
    });
  }

  Future<void> signOut() => _auth.signOut();
}
