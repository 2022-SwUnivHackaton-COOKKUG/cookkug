import 'package:cookkug/constants.dart';
import 'package:cookkug/models/recipe/recipe.dart';
import 'package:cookkug/widgets/recipe_card.dart';
import 'package:flutter/material.dart';

class RecipeKeyworkScreen extends StatelessWidget {
  final String keyword;
  final List<Recipe> recipeList;
  const RecipeKeyworkScreen(
      {Key? key, required this.keyword, required this.recipeList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        foregroundColor: kBlackColor,
        title: Text(keyword),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: GridView.count(
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            childAspectRatio: 3 / 4,
            children: recipeList.map((e) {
              return RecipeCard(recipe: e);
            }).toList()),
      ),
    );
  }
}
