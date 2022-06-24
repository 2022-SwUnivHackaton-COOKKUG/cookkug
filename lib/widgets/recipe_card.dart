import 'package:cookkug/models/recipe/recipe.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../constants.dart';
import '../models/cook/cook.dart';
import '../screens/recipedetail.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  const RecipeCard({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //TODO 여기서도 연결해줄것
        Navigator.push(context,MaterialPageRoute(builder: (context){
          return RecipeDetail(recipe: recipe);
        }));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: 150,
                      height: 150,
                      child: CachedNetworkImage(
                        imageUrl: recipe.image[0],
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(),
                        errorWidget: (context, url, error) =>
                            const Center(child: Icon(Icons.error_outline)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.recipeName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: kLightGreyColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: kDarkGreyColor,
                        ),
                        Text(
                          recipe.cookingTime,
                          style: TextStyle(
                            fontSize: 12,
                            color: kDarkGreyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
