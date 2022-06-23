import 'package:flutter/material.dart';

import '../controllers/cook_controller.dart';
import '../models/cook/cook.dart';
import '../models/recipe/recipe.dart';
import '../widgets/cooking_card.dart';

class RecipeDetail extends StatelessWidget {
  final Recipe recipe;
  const RecipeDetail({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0x00ffffff),
          elevation: 0.0,
          centerTitle: false,
          title: Text(
            '쿡꾹이 추천하는 오늘의 레시피',
            style: TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, color: Colors.black)),
        ),
        body: ListView(children: [getRecipeDetail(context, recipe)]));
  }
}

Widget getRecipeDetail(BuildContext context, Recipe recipe) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10),
          child: Image.asset('assets/images/food1.png'),
        ),
        Center(
          child: Text(
            recipe.recipeName,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Center(
          child: Text('간단하게면서도 건강까지 챙길 수 있는 초간단 덮밥 레시피에요!',
              style: TextStyle(fontSize: 12)),
        ),
        SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              padding: EdgeInsets.all(15),
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 3.0,
                  ),
                ],
              ),
              child: Text(
                '1인분',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.only(left: 10),
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(color: Colors.grey, blurRadius: 3.0),
                ],
              ),
              child: Text(
                recipe.cookingTime,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.only(left: 10),
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 3.0,
                  ),
                ],
              ),
              child: Text(
                '쉬워요!',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        SizedBox(
          width: 30,
        ),
        SizedBox(
          height: 30,
        ),
        Text('준비해주세요!',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 20.0,
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10),
                  padding: EdgeInsets.all(6),
                  width: 70,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 3.0,
                      ),
                    ],
                  ),
                  child: Text(
                    '명란2스푼',
                    style: TextStyle(fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  padding: EdgeInsets.all(6),
                  width: 70,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 3.0,
                      ),
                    ],
                  ),
                  child: Text(
                    '아보카도2개',
                    style: TextStyle(fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  padding: EdgeInsets.all(6),
                  width: 70,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 3.0,
                      ),
                    ],
                  ),
                  child: Text(
                    '계란 1알',
                    style: TextStyle(fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  padding: EdgeInsets.all(6),
                  width: 70,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 3.0,
                      ),
                    ],
                  ),
                  child: Text(
                    '새싹채소',
                    style: TextStyle(fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15),
                  padding: EdgeInsets.all(6),
                  width: 70,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 3.0,
                      ),
                    ],
                  ),
                  child: Text(
                    '밥1인분',
                    style: TextStyle(fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  padding: EdgeInsets.all(6),
                  width: 70,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 3.0,
                      ),
                    ],
                  ),
                  child: Text(
                    '참기름 2스푼',
                    style: TextStyle(fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )
          ],
        ),
        SizedBox(height: 30),
        Text('조리순서',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 20,
        ),
        Column(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 15),
                  padding: EdgeInsets.all(8),
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(100)),
                  child: Text(
                    '1',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '명란젓을 손질하여 2스푼양을 준비해주세요',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 15),
                  padding: EdgeInsets.all(8),
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(100)),
                  child: Text(
                    '2',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '양파는 가늘게 채 썰어주세요',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Text('함께먹으면 괜찮은 조합',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 20,
        ),
        Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: CookController.to.recommendCookList.map((Cook cook) {
                  return CookingCard(cook: cook);
                }).toList(),
              ),
            ),
          ],
        )
      ],
    ),
  );
}
