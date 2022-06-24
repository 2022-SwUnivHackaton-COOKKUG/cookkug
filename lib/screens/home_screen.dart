import 'dart:math';
import 'package:cookkug/controllers/user_controller.dart';
import 'package:cookkug/models/recipe/recipe.dart';
import 'package:cookkug/screens/recipe_keyword_screen.dart';
import 'package:cookkug/services/firebase_service.dart';
import 'package:cookkug/services/http_service.dart';
import 'package:cookkug/widgets/cookkug_recipe_card.dart';
import '../constants.dart';
import '../controllers/cook_controller.dart';
import '../models/cook/cook.dart';
import '../widgets/cooking_card.dart';
import 'package:flutter/material.dart';

import '../widgets/cookkug_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(UserController.to.user!.uid);
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: const CookKugAppbar(),
      body: ListView(
        children: [
          kRecipeRecommendedArea(context),
          kNavigateToRecipeArea(context),
          kFriendCookArea(context),
          kRecentlyCookArea(context),
        ],
      ),
    );
  }
}

Widget kRecipeRecommendedArea(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(left: 16, right: 16),
    padding: const EdgeInsets.all(20),
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '오늘 뭐 먹지?',
          style: TextStyle(
            fontSize: 20,
            color: kMainColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const FittedBox(
          child: Text(
            '고민만하다 시간을 허비하는 자취생들을 위해',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: Image.asset(
                'assets/logo/character_logo_hat.png',
                fit: BoxFit.fill,
              ),
            ),
            const Expanded(
              child: FittedBox(
                child: Text(
                  '쿡꾹에서 준비한',
                  style: TextStyle(
                    fontSize: 100,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        const FittedBox(
          child: Text(
            '초스피드 레시피',
            style: TextStyle(
              fontSize: 100,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    ),
  );
}

Widget kNavigateToRecipeArea(BuildContext context) {
  Random rnd = Random();
  List<int> randomList = [];
  for(int i =0;i<3;i++){
    int value = rnd.nextInt(16);
    while(randomList.contains(value)){
      value = rnd.nextInt(16);
    }
    randomList.add(value);
  }
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: kLightGreyColor,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: kBlackColor,
            ),
            children: [
              const TextSpan(text: '#버튼을 '),
              TextSpan(
                  text: '꾹 ',
                  style: TextStyle(
                    color: kMainColor,
                  )),
              const TextSpan(text: '눌러 레시피 보러가기'),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            kRecipeButton(context, text: kKeyworkList[randomList[0]][0]),
            kRecipeButton(context, text: kKeyworkList[randomList[1]][0]),
            kRecipeButton(context, text: kKeyworkList[randomList[2]][0]),
          ],
        ),
      ],
    ),
  );
}

Widget kRecipeButton(BuildContext context, {required String text}) {
  return GestureDetector(
    onTap: ()async {
      List data = kKeyworkList.firstWhere((element) => element[0]==text);
      List<Recipe> recipeList = await HttpService().getRecipeListWithKeywork('${data[1]}');
      Navigator.push(context,MaterialPageRoute(builder: (context){
        return RecipeKeyworkScreen(keyword: data[0], recipeList: recipeList);
      }));
    },
    child: Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          '#$text',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

Widget kFriendCookArea(BuildContext context) {
  return FutureBuilder(
      future: FirebaseService().getRecipeList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Recipe> recipeList = snapshot.data as List<Recipe>;
          if(recipeList.isEmpty) return Container();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 40,
                      child: Image.asset(
                        'assets/logo/character_logo.png',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 5),
                        Text(
                          '친구의 레시피',
                          style: TextStyle(
                            color: kMainColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          ' 엿보기',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: recipeList.map((Recipe recipe) {
                      return CookkugRecipeCard(recipe: recipe);
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
      });
}

Widget kRecentlyCookArea(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(width: 5),
            Text(
              '최근에',
              style: TextStyle(
                color: kMainColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              ' 봤어요',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
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
