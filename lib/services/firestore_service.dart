import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService{
  // 싱글톤 객체 생성
  static final FireStoreService _instance = FireStoreService._initialize();
  factory FireStoreService() => _instance;
  FireStoreService._initialize() {
    print('FireStoreService Initialized');
  }

  // Firestore 객체
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> registerUser()async{
    return false;
  }

  Future<bool> loginUser()async{
    return false;
  }

}