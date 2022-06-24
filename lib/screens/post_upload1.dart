import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'post_upload2.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const PostUpload()));
            },
            icon: Icon(
              Icons.arrow_forward,
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _image == null
                  ? Container(
                      width: 400,
                      height: 400,
                      child: Icon(
                        Icons.camera_alt,
                        size: 36,
                        color: Colors.grey,
                      ),
                    )
                  : Image.file(File(_image!.path)),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.zoom_out_map,
                      color: Color.fromARGB(255, 255, 138, 0),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          getImage(ImageSource.gallery);
                        },
                        icon: Icon(
                          Icons.photo_album,
                          color: Color.fromARGB(255, 255, 138, 0),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      IconButton(
                        onPressed: () {
                          getImage(ImageSource.camera);
                        },
                        icon: Icon(
                          Icons.photo_camera,
                          color: Color.fromARGB(255, 255, 138, 0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 16,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      color: Colors.grey,
                    );
                  }),
            ],
          ),
        ),
      ),
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
