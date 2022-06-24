import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cookkug/constants.dart';
import 'package:cookkug/services/firebase_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cookkug/services/firebase_service.dart';
import 'dart:io';

class PostUpload extends StatefulWidget {
  const PostUpload({Key? key}) : super(key: key);

  @override
  State<PostUpload> createState() => _PostUploadState();
}

class _PostUploadState extends State<PostUpload> {
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  List<XFile> images = [];
  String? notes;
  TextEditingController _ingridientController = TextEditingController();

  List<String> needHashtagList = []; //

  void uploadPost() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      barrierDismissible: false,
    );
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      //if (images.isEmpty) {
      //  Fluttertoast.showToast(msg: '한개이상의 게시물 이미지를 등록해주세요');
      //  return;
      //}
      if (needHashtagList.isEmpty || notes!.isEmpty) {
        Fluttertoast.showToast(msg: '필요한 정보를 모두 입력해주세요');
        return;
      }
      bool uploadSuccess = await FirebaseService().uploadPost(
        images: images,
        note: notes!,
        hashtagList: needHashtagList,
      );
      Navigator.of(context).pop();
      if (uploadSuccess) {
        Navigator.of(context).pop();
      }
    }
  }

  Widget _chang() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          ...images.map((XFile file) {
                        return Container(
                          margin: const EdgeInsets.only(right: 10),
                          alignment: Alignment.center,
                          width: 100,
                          height: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              File(file.path),
                              fit: BoxFit.fill,
                              width: 100,
                              height: 100,
                            ),
                          ),
                        );
                      }).toList(),
          /*
          SizedBox(
            width: 80,
            height: 80,
            child: Image(
              image: AssetImage('assets/images/loopie.jpg'),
            ),
            /*Icon(
              Icons.camera_alt,
              size: 36,
              color: Colors.grey,
            ),*/
          ),
          */
          Expanded(
              child: TextField(
            maxLines: null,
            decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15),
                hintText: '문구 입력'),
          )),
        ],
      ),
    );
  }

  Widget _hashtag(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      child: Text(
        title,
        style: TextStyle(fontSize: 17),
      ),
    );
  }

  Widget get line => const Divider(color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '게시물 업로드',
            style: TextStyle(
                color: Colors.black,
                letterSpacing: 1.0,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white, // 앱바의 배경 색
          elevation: 0.0, // 앱바 입체감
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.share,
                color: Color.fromARGB(255, 255, 138, 0),
              ),
            )
          ],
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
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _chang(),
                line,
                _hashtag('해시태그 추가'),
                //
                kCustomTextFormField(
                  onSaved: (value) {},
                  validator: (value) {
                    return null;
                  },
                  controller: _ingridientController,
                  suffix: GestureDetector(
                    onTap: () {
                      needHashtagList.add(_ingridientController.text);
                      _ingridientController.clear();
                    },
                    child: Text(
                      '+',
                      style: TextStyle(
                        fontSize: 16,
                        color: kGreyColor,
                      ),
                    ),
                  ),
                  onSubmitted: (value) {
                    needHashtagList.add(value);
                    _ingridientController.clear();
                  },
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: needHashtagList.map((e) {
                      return Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          color: kLightGreyColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Text(
                              e,
                              style: TextStyle(
                                color: kDarkGreyColor,
                              ),
                            ),
                            const SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                needHashtagList.remove(e);
                                setState(() {});
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: kGreyColor,
                                ),
                                child: Icon(
                                  Icons.clear,
                                  size: 12,
                                  color: kWhiteColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                //
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 255, 138, 0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        minimumSize: const Size(500, 50)),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      '게시물 업로드하기',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2.0,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  //
  Widget kCustomTextFormField({
    required FormFieldSetter onSaved,
    required FormFieldValidator validator,
    required Function onSubmitted,
    TextEditingController? controller,
    Widget? suffix,
    bool isEnd = false,
  }) {
    return TextFormField(
      controller: controller,
      onSaved: (val) => onSaved(val),
      validator: (val) => validator(val),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: const TextStyle(
          fontSize: 16,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide(
            width: 1,
          ),
        ),
        suffix: suffix,
      ),
      onFieldSubmitted: (value) => onSubmitted(value),
      textAlign: isEnd ? TextAlign.end : TextAlign.start,
      maxLines: 1,
    );
  }
//
}
