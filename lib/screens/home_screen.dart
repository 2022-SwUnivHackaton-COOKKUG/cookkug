import 'package:cached_network_image/cached_network_image.dart';

import '../constants.dart';
import '../controllers/cook_controller.dart';
import '../models/cook/cook.dart';
import '../widgets/cooking_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kWhiteColor,
        foregroundColor: kBlackColor,
        elevation: 0,
        centerTitle: false,
        title: SizedBox(
          height: 30,
          child: Image.asset('assets/logo/text_logo.png'),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: kMainColor),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications, color: kMainColor),
          ),
        ],
      ),
      body: ListView(
        children: [
          recipeRecommendedArea(context),
          recommendedCookArea(context),
        ],
      ),
    );
  }
}

Widget recipeRecommendedArea(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
    padding: const EdgeInsets.all(20),
    width: double.infinity,
    height: MediaQuery.of(context).size.width * 21 / 20,
    decoration: BoxDecoration(
      color: kWhiteColor,
      borderRadius: BorderRadius.circular(30),
      image: const DecorationImage(
        fit: BoxFit.fitHeight,
        image: AssetImage('assets/images/today_recipe_image.jpeg'),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 28,
              color: kWhiteColor,
              fontWeight: FontWeight.bold,
            ),
            children: [
              const TextSpan(text: '쿡꾹이 추천하는\n'),
              TextSpan(
                text: '오늘의 ',
                style: TextStyle(
                  color: kMainColor,
                ),
              ),
              const TextSpan(text: '요리레시피'),
            ],
          ),
        ),
        const Spacer(),
        Row(
          children: [
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: kWhiteColor,
              size: 14,
            ),
            Text(
              '꾹 눌러 추천받기',
              style: TextStyle(
                fontSize: 16,
                color: kWhiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget recommendedCookArea(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            '안선영님을 위한 초스피드 레시피',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        //TODO FutureBuilder로 서버로부터 데이터를 받아오면 그걸 여기서 변환해주는방식
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: CookController.to.recommendCookList.map((Cook cook) {
              return CookingCard(cook: cook);
            }).toList(),
          ),
        ),
      ],
    ),
  );
}
