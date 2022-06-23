import 'package:flutter/material.dart';

class RecipeDetail extends StatelessWidget {
  const RecipeDetail({Key? key}) : super(key: key);

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
        body: ListView(children: [getRecipeDetail(context)]));
  }
}

Widget getRecipeDetail(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10),
          child: Image.asset('assets/food1.png'),
        ),
        Center(
          child: Text(
            '명란 아보카도덮밥',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Center(
          child: Text('간단하게면서도 건강까지 챙길 수 있는 초간단 덮밥 레시피에요!',
              style: TextStyle(fontSize: 13)),
        ),
        SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20),
              padding: EdgeInsets.all(15),
              width: 80,
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
                style: TextStyle(fontSize: 13),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.only(left: 20),
              width: 80,
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
                '15분이내',
                style: TextStyle(fontSize: 13),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(left: 20),
              width: 80,
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
                style: TextStyle(fontSize: 13),
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
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 20.0,
        ),
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
                '명란 2스푼',
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
                '아보카도 1개',
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
        SizedBox(height: 30),
        Text('조리순서',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 20,
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
                '1',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text('명란젓을 손질하여 2스푼양을 준비해주세요'),
          ],
        ),
        SizedBox(
          height: 20,
        ),
      ],
    ),
  );
}
