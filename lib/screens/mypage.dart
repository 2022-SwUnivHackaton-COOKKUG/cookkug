import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'mypagecheck.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  List? _output;
  File? _image;

  String userE = "";
  String userN = "";

  Future<String> getUser() async {
    final user = FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    // .collection('userinfo')
    // .doc('userinfo');

    var docSnapshot = await user.get();
    userE = docSnapshot['email'];
    print(userE);
    userN = docSnapshot['name'];
    print(userN);

    return userE;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUser(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Row(
              children: const [
                Text(
                  '나의',
                  style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 1.0,
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  ' 쿡꾹',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 138, 0),
                      letterSpacing: 1.0,
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            backgroundColor: Colors.white, // 앱바의 배경 색
            elevation: 0.0, // 앱바 입체감
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    InkWell(
                      borderRadius: BorderRadius.circular(8.0),
                      child: const ClipOval(
                        child: Image(
                          image: AssetImage('assets/images/루피.jpg'),
                          width: 120.0,
                          height: 120.0,
                          fit: BoxFit.fill,
                        ),
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            barrierDismissible: true, // 창 밖 선택시 창 닫기
                            builder: (BuildContext context) {
                              return Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: AlertDialog(
                                  title: const Text('프로필 이미지 설정',
                                      textAlign: TextAlign.center),
                                  actions: <Widget>[
                                    const Divider(
                                      height: 0.0,
                                      color: Colors.orangeAccent,
                                      thickness: 1.5,
                                      endIndent: 0.0,
                                    ),
                                    ListTile(
                                      title: const Text('카메라',
                                          textAlign: TextAlign.center),
                                      onTap: () {
                                        getImage(ImageSource.camera);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    const Divider(
                                      height: 0.0,
                                      color: Colors.orangeAccent,
                                      thickness: 0.0,
                                      endIndent: 0.0,
                                    ),
                                    ListTile(
                                      title: const Text('갤러리',
                                          textAlign: TextAlign.center),
                                      onTap: () {
                                        getImage(ImageSource.gallery);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    const Divider(
                                      height: 0.0,
                                      color: Colors.orangeAccent,
                                      thickness: 0.0,
                                      endIndent: 0.0,
                                    ),
                                    ListTile(
                                      title: const Text('취소',
                                          textAlign: TextAlign.center),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                    ),
                    OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyPageCheck()));
                        },
                        child: const Text(
                          '프로필 편집',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 138, 0),
                            letterSpacing: 2.0,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(userN,
                          style: const TextStyle(
                            color: Colors.black,
                            letterSpacing: 2.0,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          )),
                      const Text(
                        "자기소개를 작성하시오.",
                        style: TextStyle(
                          color: Color.fromARGB(255, 116, 111, 111),
                          letterSpacing: 2.0,
                          fontSize: 15.0, // 넘는거 어켕할거임
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 60.0,
                  color: Colors.orangeAccent,
                  thickness: 1.5,
                  endIndent: 5.0,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.replay,
                    color: Colors.black,
                  ),
                  title: const Text(
                    '기록',
                    style: TextStyle(
                      letterSpacing: 2.0,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => MyRecord()));
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  title: const Text(
                    '친구',
                    style: TextStyle(
                      letterSpacing: 2.0,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => MyFriends()));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future getImage(ImageSource imageSource) async {
    XFile? ximage = await ImagePicker().pickImage(source: imageSource);
    if (ximage == null) return;
    File image = File(ximage.path);
    setState(() {
      _image = image;
    });
  } // 프로필 이미지 설정 (카메라, 갤러리)
}
