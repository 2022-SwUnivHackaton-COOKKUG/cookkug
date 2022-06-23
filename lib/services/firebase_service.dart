import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookkug/controllers/user_controller.dart';
import 'package:cookkug/models/recipe/recipe.dart';
import 'package:cookkug/models/user/user.dart' as mUser;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../models/chatRoom/chatRoom.dart';

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
  static final FirebaseStorage _firestorage = FirebaseStorage.instance;

  Future<List<ChatRoom>> getChatRoomList() async {
    try {
      QuerySnapshot<Map<String, dynamic>> chatRoomList = await _firestore
          .collection('chatroom')
          .where('userIdList', arrayContains: UserController.to.user!.uid)
          .get();
      return chatRoomList.docs.map((e) {
        return ChatRoom.fromJson(e.data());
      }).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<ChatRoom?> getChatRoomWithId(String chatRoomId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> chatRoomData =
          await _firestore.collection('chatroom').doc(chatRoomId).get();
      return ChatRoom.fromJson(chatRoomData.data());
    } catch (e) {
      print(e);
      return null;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatStreamWithChatRoomId(
      String chatRoomId) {
    return _firestore
        .collection('chatroom')
        .doc(chatRoomId)
        .collection('chat')
        .orderBy('timeStamp')
        .snapshots();
  }

  Future<String> getUserImage(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> userData =
        await _firestore.collection('user').doc(uid).get();
    Map<String, dynamic> user = userData.data() as Map<String, dynamic>;
    return user['image'];
  }

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
        'chatRoomList': [],
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
          chatRoomList: [],
        );
        _firestore
            .collection('user')
            .doc(userCredential.user!.uid)
            .set(user.toJson());

        UserController.to.signIn(user);
        return true;
      }
      mUser.User user = mUser.User.fromJson(result.docs[0].data());
      UserController.to.signIn(user);
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

  Future<String?> chatWithUser({
    required String receiverId,
    required String receiverName,
  }) async {
    //1. chat을 만든다
    //2. update를 하는데 receiver,user 둘다 업데이트해준다
    try {
      for (var chatroom in UserController.to.user!.chatRoomList ?? []) {
        if (chatroom['userIdList'].contains(receiverId)) {
          return chatroom['id'];
        }
      }
      String timeStamp = DateTime.now().toString();
      String chatRoomDocumentId = const Uuid().v4();
      await _firestore.collection('chatroom').doc(chatRoomDocumentId).set({
        'id': chatRoomDocumentId,
        'userIdList': [UserController.to.user!.uid, receiverId],
        'userList': [
          {
            'id': UserController.to.user!.uid,
            'name': UserController.to.user!.name,
          },
          {
            'id': receiverId,
            'name': receiverName,
          },
        ],
        'timeStamp': timeStamp,
        'lastMessage': '',
        'lastMessageTimeStamp': timeStamp,
      });
      await _firestore
          .collection('user')
          .doc(UserController.to.user!.uid)
          .update({
        'chatRoomList': [
          ...UserController.to.user!.chatRoomList ?? [],
          {
            'id': chatRoomDocumentId,
            'userIdList': [UserController.to.user!.uid, receiverId],
          }
        ]
      });
      DocumentSnapshot<Map<String, dynamic>> receiverData =
          await _firestore.collection('user').doc(receiverId).get();

      await _firestore.collection('user').doc(receiverId).update({
        'chatRoomList': [
          ...receiverData.data()!['chatRoomList'],
          {
            'id': chatRoomDocumentId,
            'userList': [UserController.to.user!.uid, receiverId],
          }
        ]
      });
      return chatRoomDocumentId;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> sendMessageInChatRoom({
    required String chatRoomId,
    required String message,
  }) async {
    String timeStamp = DateTime.now().toString();
    await _firestore.collection('chatroom').doc(chatRoomId).update({
      'lastMessage': message,
      'lastMessageTimeStamp': timeStamp,
    });
    String chatId = const Uuid().v4();
    await _firestore
        .collection('chatroom')
        .doc(chatRoomId)
        .collection('chat')
        .doc(chatId)
        .set({
      'id': chatId,
      'senderId': UserController.to.user!.uid,
      'message': message,
      'timeStamp': timeStamp,
    });
  }

  Future<List<String>> uploadImages(List<XFile>? images) async {
    if (images == null) return [];
    List<String> imageUrl = [];
    for (XFile element in images) {
      String imagePath = const Uuid().v4();
      String destination = 'images/$imagePath';
      final ref = _firestorage.ref(destination);
      TaskSnapshot uploadedFile = await ref.putFile(File(element.path));
      imageUrl.add(await uploadedFile.ref.getDownloadURL());
    }
    return imageUrl;
  }

  Future<bool> uploadRecipe({
    required List<XFile> images,
    required String recipeName,
    required String cookingTime,
    required String recipeCategory,
    required List<String> ingredientList,
    required List<String> cookingOrder,
  }) async {
    try{
      List<String> imageUrl = await uploadImages(images);
      String recipeId = const Uuid().v4();
      await _firestore.collection('recipe').doc(recipeId).set(Recipe(
        id: recipeId,
        image: imageUrl,
        recipeName: recipeName,
        cookingTime: cookingTime,
        recipeCategory: recipeCategory,
        ingredientList: ingredientList,
        cookingOrder: cookingOrder,
      ).toJson());
      return true;
    }catch(e){
      print(e);
      return false;
    }

  }
}
