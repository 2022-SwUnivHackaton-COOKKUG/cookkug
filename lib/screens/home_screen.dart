import '../constants.dart';
import '../controllers/cook_controller.dart';
import '../models/cook/cook.dart';
import '../widgets/cooking_card.dart';
import '../widgets/popular_cooking_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        foregroundColor: kBlackColor,
        elevation: 0,
        title: const Text(
          'COOKKUG',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      body: ListView(
        children: [
          getRecommendedCook(context),
          getPopularCategory(
            selectedCategory: _selectedCategory ?? '',
            onPressed: (String category) {
              setState(() {
                _selectedCategory = category;
              });
            },
          )
        ],
      ),
    );
  }
}

Widget getRecommendedCook(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            '안선영님을 위한 추천요리',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        //TODO FutureBuilder로 서버로부터 데이터를 받아오면 그걸 여기서 변환해주는방식
        GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
            mainAxisExtent: MediaQuery.of(context).size.width * 3 / 5,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
          ),
          children: CookController.to.recommendCookList.map((Cook cook) {
            return CookingCard(cook: cook);
          }).toList(),
        ),
      ],
    ),
  );
}

Widget getPopularCategory({
  required String selectedCategory,
  required Function onPressed,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Text(
            '인기있는 카테고리',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: kCookingCategoryList.map((category) {
              return GestureDetector(
                onTap: () => onPressed(category['category']),
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  alignment: Alignment.center,
                  constraints: const BoxConstraints(
                    minWidth: 60,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: selectedCategory == category['category']
                          ? kPrimary50Color
                          : null),
                  child: Text(
                    category['categoryName'],
                    style: TextStyle(
                      color: selectedCategory == category['category']
                          ? kWhiteColor
                          : kPrimary30Color,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: CookController.to.recommendCookList.map((Cook cook) {
              return PopularCookingCard(cook: cook);
            }).toList(),
          ),
        ),
      ],
    ),
  );
}
