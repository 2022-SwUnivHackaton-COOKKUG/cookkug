import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'myPageChange.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyPageCheck extends StatefulWidget {
  const MyPageCheck({Key? key}) : super(key: key);

  @override
  State<MyPageCheck> createState() => _MyPageCheckState();
}

class _MyPageCheckState extends State<MyPageCheck> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyPageChange()),
          );
        });
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }

  String userE = "";

  Future<String> getUser() async {
    final user = FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid);

    var docSnapshot = await user.get();
    userE = docSnapshot['email'];
    return userE;
  }

  final pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
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
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 30,
                          child: Image(
                            image: AssetImage('assets/logo/text_logo.png'),
                          ),
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
                  body: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                            child: const Text(
                              '회원정보확인',
                              style: TextStyle(
                                color: Color.fromARGB(255, 116, 111, 111),
                                letterSpacing: 2.0,
                                fontSize: 15.0, // 넘는거 어켕할거임
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                            child: TextFormField(
                                enabled: false,
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.mail),
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        20, 15, 20, 15),
                                    hintText: userE,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)))),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                            //비밀번호 체크하는 사항 추가
                            child: TextFormField(
                              autofocus:
                                  false, //자동으로 텍스트 필드가 선택되는 것을 막는다. 기본값이 false이다.
                              controller: pwController,
                              obscureText: true, //비밀번호가 ....으로 표시되도록 한다
                              validator: (value) {
                                RegExp regex = RegExp(r'^.{6,}$');
                                if (!regex.hasMatch(value!)) {
                                  return ("최소 6자리 이상의 비밀번호가 필요합니다.");
                                }
                              },
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.vpn_key),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                  hintText: "비밀번호",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary:
                                      const Color.fromARGB(255, 255, 138, 0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  minimumSize: const Size(500, 50)),
                              onPressed: () {
                                signIn(userE, pwController.text);
                              },
                              child: const Text('확인하기',
                                  style: TextStyle(
                                      color: Colors.white,
                                      letterSpacing: 2.0,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
            }));
  }
}
