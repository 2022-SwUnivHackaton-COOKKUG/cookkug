import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  // 싱글톤 객체 생성
  static final FirebaseService _instance = FirebaseService._initialize();
  factory FirebaseService() => _instance;
  FirebaseService._initialize() {
    print('FireStoreService Initialized');
  }

  // Firestore 객체
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> registerWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user == null) return false;
      _firestore.collection('user').doc(userCredential.user!.uid).set({
        'email': email,
        'name': password,
        'uid': userCredential.user!.uid,
        'friends': [],
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> registerWithGoogleSignIn() async {
    final googleSign = GoogleSignIn();
    final googleUser = await googleSign.signIn();
    if (googleUser == null) return false;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user == null) return false;
      _firestore.collection('user').doc(userCredential.user!.uid).set({
        'email': userCredential.user!.email,
        'name': '',
        'uid': userCredential.user!.uid,
        'friends': [],
      });
      return true;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return false;
  }

  Future<bool> loginUser() async {
    return false;
  }
}
