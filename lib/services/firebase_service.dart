import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookkug/controllers/user_controller.dart';
import 'package:cookkug/models/user/user.dart' as mUser;
import 'package:firebase_auth/firebase_auth.dart';
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
        'image': '',
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

  Future<bool> signInWithGoogle() async {
    try {
      final googleSign = GoogleSignIn();
      final googleUser = await googleSign.signIn();
      if (googleUser == null) return false;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return await settingUpUser(userCredential);
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: e.toString());
    }
    return false;
  }

  Future<bool> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);

    return await settingUpUser(userCredential);
  }

  Future<bool> settingUpUser(UserCredential userCredential) async {
    try {
      if (userCredential.user == null) return false;

      QuerySnapshot result = await _firestore
          .collection('user')
          .where('uid', isEqualTo: userCredential.user!.uid)
          .get();

      if (result.docs.isEmpty) {
        mUser.User user = mUser.User(
          image: '',
          email: userCredential.user!.email!,
          name: '홍길동',
          uid: userCredential.user!.uid,
          friends: [],
        );
        _firestore
            .collection('user')
            .doc(userCredential.user!.uid)
            .set(user.toJson());

        CookkugUserController.to.signIn(user);
        return true;
      }
      mUser.User user = mUser.User.fromJson(result.docs[0].data());
      CookkugUserController.to.signIn(user);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List> getUserList() async {
    QuerySnapshot userList = await _firestore.collection('user').get();
    return userList.docs.map((e) {
      return e.data();
    }).toList();
  }
}
