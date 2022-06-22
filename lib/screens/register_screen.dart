import 'package:cookkug/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

final _formKey = GlobalKey<FormState>();

final _searchController = TextEditingController();

final List<String> _init = [];

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  final eController = TextEditingController();

  final p1Controller = TextEditingController();

  final p2Controller = TextEditingController();

  final nController = TextEditingController();

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      var navigator = Navigator.of(context);
      bool result = await FirebaseService().registerWithEmailAndPassword(email:email,password:password);
      if(result){
        Fluttertoast.showToast(msg: '쿡꾹 계정이 생성되었습니다.');
        navigator.pop();
        return;
      }
      Fluttertoast.showToast(msg: '이미 가입된 이메일입니다');
    }
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
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Image.asset(
                      'assets/images/1.png',
                      height: 100,
                      width: 400,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(40, 15, 40, 0),
                    child: const Text(
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
                    margin: const EdgeInsets.fromLTRB(40, 20, 40, 0),
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
                            prefixIcon: const Icon(Icons.person),
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: "이름",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)))),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(40, 20, 40, 0),
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
                            prefixIcon: const Icon(Icons.mail),
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: "이메일",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)))),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                    child: TextFormField(
                      controller: p1Controller,
                      obscureText: true,
                      validator: (value) {
                        RegExp regex = RegExp(r'^.{6,}$');
                        if (!regex.hasMatch(value!)) {
                          return ("최소 6자리 이상의 비밀번호가 필요합니다.");
                        }
                      },
                      onSaved: (value) {
                        p1Controller.text = value!;
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
                    margin: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                    child: TextFormField(
                      controller: p2Controller,
                      obscureText: true,
                      validator: (value) {
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
                          prefixIcon: const Icon(Icons.vpn_key),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "비밀번호 확인",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 200, 20, 0),
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 255, 138, 0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    minimumSize: const Size(500, 50)),
                onPressed: () {
                  signUp(eController.text, p1Controller.text);
                },
                child: const Text('회원가입하기',
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
