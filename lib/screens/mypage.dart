import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookkug/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'mypagecheck.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'login_screen.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with TickerProviderStateMixin {
  TabController? tabcontroller;
  @override
  void initState() {
    super.initState();
    tabcontroller = TabController(length: 3, vsync: this);
  }

  List? _output;
  File? _image;

  String userE = "";
  String userN = "";

  final recipe = FirebaseFirestore.instance.collection('recipe');

  Future<String> getUser() async {
    final user = FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid);

    var docSnapshot = await user.get();
    userE = docSnapshot['email'];
    print(userE);
    userN = docSnapshot['name'];
    print(userN);

    return userE;
  }

  /*
  Widget _tabMenu() {
    return TabBar(
      controller: tabcontroller,
      indicatorColor: Color.fromARGB(255, 255, 138, 0),
      indicatorWeight: 3,
      tabs: [
        Container(
          padding: const EdgeInsets.all(10),
          child: Icon(
            Icons.apps,
            color: Color.fromARGB(255, 255, 138, 0),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Icon(
            Icons.people,
            color: Color.fromARGB(255, 255, 138, 0),
          ),
        ),
      ],
    );
  }

  Widget _tabVV() {
    return TabBarView(children: []);
  }

  Widget _tabView() {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 12,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.grey,
          );
        });
  }

  Widget _discoverPeople() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          child: Row(
            children: const [
              Text(
                'Discover People',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              Text(
                'See All',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: List.generate(10, (index) => const UserCard()).toList(),
          ),
        ),
      ],
    );
  }
  */

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
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications,
                  color: Color.fromARGB(255, 255, 138, 0),
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    //
                    _image == null
                        ? Container(
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8.0),
                              child: const ClipOval(
                                child: Image(
                                  image: AssetImage('assets/images/loopie.jpg'),
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
                                              color: Color.fromARGB(
                                                  255, 255, 138, 0),
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
                                              color: Color.fromARGB(
                                                  255, 255, 138, 0),
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
                                              color: Color.fromARGB(
                                                  255, 255, 138, 0),
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
                          )
                        : Image.file(
                            File(_image!.path),
                            width: 120.0,
                            height: 120.0,
                          ),
                    Column(children: [
                      Row(children: [
                        Column(
                          children: [
                            Text(
                              '2',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '레시피',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Column(
                          children: [
                            Text(
                              '0',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '팔로워',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Column(
                          children: [
                            Text(
                              '0',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '팔로잉',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ]),
                      SizedBox(
                        height: 20,
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
                    ]),
                    //
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
                      Text(
                        "안녕하세요. " + userN + "의 쿡꾹입니다.",
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
                //
                DefaultTabController(
                  length: 3,
                  child: TabBar(
                      indicatorColor: Color.fromARGB(255, 255, 138, 0),
                      tabs: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Icon(
                            Icons.restaurant,
                            color: Color.fromARGB(255, 255, 138, 0),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Icon(
                            Icons.apps,
                            color: Color.fromARGB(255, 255, 138, 0),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Icon(
                            Icons.favorite,
                            color: Color.fromARGB(255, 255, 138, 0),
                          ),
                        ),
                      ]),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: recipe.snapshots(),
                    builder: (context, streamSnapshot) {
                      if (streamSnapshot.hasData) {
                        return ListView.builder(
                          itemCount: streamSnapshot.data!.docs.length, //
                          itemBuilder: (context, index) {
                            final DocumentSnapshot documentSnapshot =
                                streamSnapshot.data!.docs[index]; //
                            return Card(
                              margin: const EdgeInsets.all(10),
                              child: ListTile(
                                leading: Image(
                                  image: NetworkImage(
                                      documentSnapshot['image'][0]),
                                  width: 60.0,
                                  height: 60.0,
                                  fit: BoxFit.fill,
                                ),
                                title: Text(documentSnapshot['recipeName']), //
                                subtitle:
                                    Text(documentSnapshot['recipeCategory']), //
                                trailing: IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('삭제'),
                                              content: SingleChildScrollView(
                                                child: Text('레시피를 삭제하시겠습니까?'),
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Text('삭제'),
                                                  onPressed: () {
                                                    //deleteUser();
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text('취소'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                )
                                              ],
                                            );
                                          });
                                    },
                                    icon: Icon(Icons.delete)),
                              ),
                            );
                          },
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
                /*
                  GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 2,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              childAspectRatio: 1,
                              mainAxisSpacing: 2,
                              crossAxisSpacing: 2),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          color: Colors.grey,
                        );
                      })
                      */
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
