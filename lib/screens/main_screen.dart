import 'package:cookkug/screens/community_screen.dart';
import 'package:cookkug/screens/recipe_upload_screen.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';
import '../controllers/cook_controller.dart';
import 'chat_screen.dart';
import 'home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    Get.put(CookController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Center(
        child: IndexedStack(
          index: _currentIndex,
          children: [
            const HomeScreen(),
            const CommunityScreen(),
            Container(),
            const ChatScreen(),
            Text('index : $_currentIndex'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kMainColor,
        backgroundColor: kWhiteColor,
        onTap: (int index) {
          if (index == 2) {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return kUploadBottomSheet(context);
              },
            );
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                'assets/icons/home${_currentIndex == 0 ? '_fill' : ''}.svg'),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                'assets/icons/cookkug_friend${_currentIndex == 1 ? '_fill' : ''}.svg'),
            label: '레시피꾹',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                'assets/icons/share${_currentIndex == 2 ? '_fill' : ''}.svg'),
            label: '공유하기',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                'assets/icons/chat${_currentIndex == 3 ? '_fill' : ''}.svg'),
            label: '채팅',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                'assets/icons/my_cookkug${_currentIndex == 4 ? '_fill' : ''}.svg'),
            label: '나의쿡꾹',
          ),
        ],
      ),
    );
  }
}

Widget kUploadBottomSheet(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(16),
    height: 150,
    color: Colors.black.withAlpha(1),
    child: Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return const RecipeUploadScreen();
            }));
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: kGreyColor),
            ),
            child: Text('레시피 등록하기'),
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: kGreyColor),
          ),
          child: Text('게시물 등록하기'),
        ),
      ],
    ),
  );
}
