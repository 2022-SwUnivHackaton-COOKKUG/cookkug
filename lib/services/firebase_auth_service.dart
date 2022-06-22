import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService{
// 싱글톤 객체 생성
  static final FirebaseAuthService _instance = FirebaseAuthService._initialize();
  factory FirebaseAuthService() => _instance;
  FirebaseAuthService._initialize() {
    print('FireStoreService Initialized');
  }

  // Firestore 객체
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> registerUser()async{
    return false;
  }

  Future<bool> loginUser()async{
    return false;
  }

}