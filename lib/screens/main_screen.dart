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
            Text('index : $_currentIndex'),
            Text('index : $_currentIndex'),
            const ChatScreen(),
            Text('index : $_currentIndex'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kBlackColor,
        backgroundColor: kWhiteColor,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(_currentIndex == 0 ? Icons.home : Icons.home_outlined),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon:
                Icon(_currentIndex == 1 ? Icons.search : Icons.search_outlined),
            label: '검색',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                _currentIndex == 2 ? Icons.favorite : Icons.favorite_outline),
            label: '꾹한음식',
          ),
          BottomNavigationBarItem(
            icon: Icon(_currentIndex == 3
                ? Icons.chat_bubble
                : Icons.chat_bubble_outline),
            label: '채팅',
          ),
          BottomNavigationBarItem(
            icon:
                Icon(_currentIndex == 4 ? Icons.person : Icons.person_outline),
            label: '마이페이지',
          ),
        ],
      ),
    );
  }
}
