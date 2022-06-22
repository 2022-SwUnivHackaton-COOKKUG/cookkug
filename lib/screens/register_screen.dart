import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:searchfield/searchfield.dart';

final _formKey = GlobalKey<FormState>();

final _searchController = TextEditingController();

final List<String> _init = [];

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  final eController = TextEditingController();

  final p1Controller = TextEditingController();

  final p2Controller = TextEditingController();

  final nController = TextEditingController();

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        registerDetails();
        Fluttertoast.showToast(msg: '쿡꾹 계정이 생성되었습니다.');
        Navigator.pop(context);
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }

  void registerDetails() {
    final CollectionReference _user =
        FirebaseFirestore.instance.collection('user');

    _user.doc('${FirebaseAuth.instance.currentUser!.uid}').set({
      'email': eController.text,
      'name': nController.text,
      //'address': address2,
      'friends': FieldValue.arrayUnion(_init)
    });
    //firestore database에 현재 등록 유저의 정보 올리기
    //<Users 컬렉션 -> 현재 유저의 uid 도큐먼트>에 유저 데이터 추가
    //컬렉션에 도큐먼트를 추가할 때는 add를 사용하였지만
    //도큐먼트에 데이터를 추가할 때는 set을 사용한다.
    //set 안에는 Map형식의 값을 넣어줘야 한다.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      //키보드가 올라오면 하단에 오버플로우가 발생하므로
      //SingleChildScrollView로 감싸준다.
      child: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Image.asset(
                      'assets/images/1.png',
                      height: 100,
                      width: 400,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(40, 15, 40, 0),
                    child: Text(
                      '회원정보입력',
                      style: TextStyle(
                        color: Color.fromARGB(255, 116, 111, 111),
                        letterSpacing: 2.0,
                        fontSize: 15.0, // 넘는거 어켕할거임
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(40, 20, 40, 0),
                    child: TextFormField(
                        controller: nController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'[a-zA-Z0-9]').hasMatch(value)) {
                            return ("사용할 수 없는 이름입니다.");
                          }
                        },
                        onSaved: (value) {
                          eController.text = value!;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: "이름",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)))),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(40, 20, 40, 0),
                    child: TextFormField(
                        controller: eController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                            return ("잘못된 이메일 형식입니다.");
                          }
                        },
                        onSaved: (value) {
                          eController.text = value!;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mail),
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: "이메일",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)))),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(40, 20, 40, 0),
                    child: TextFormField(
                      controller: p1Controller,
                      obscureText: true,
                      validator: (value) {
                        RegExp regex = new RegExp(r'^.{6,}$');
                        if (!regex.hasMatch(value!)) {
                          return ("최소 6자리 이상의 비밀번호가 필요합니다.");
                        }
                      },
                      onSaved: (value) {
                        p1Controller.text = value!;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.vpn_key),
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "비밀번호",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(40, 20, 40, 0),
                    child: TextFormField(
                      controller: p2Controller,
                      obscureText: true,
                      validator: (value) {
                        RegExp regex = new RegExp(r'^.{6,}$');
                        if ((p1Controller.text == '' &&
                                p2Controller.text == '') ||
                            (p1Controller.text != p2Controller.text)) {
                          return ("비밀번호가 일치하지 않습니다.");
                        }
                      },
                      onSaved: (value) {
                        p2Controller.text = value!;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.vpn_key),
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "비밀번호 확인",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 200, 20, 0),
              padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 255, 138, 0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    minimumSize: Size(500, 50)),
                onPressed: () {
                  signUp(eController.text, p1Controller.text);
                },
                child: Text('회원가입하기',
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
  }
}
