import 'package:cookkug/models/recipe/recipe.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../screens/recipedetail.dart';

class CookkugRecipeCard extends StatelessWidget {
  final Recipe recipe;
  const CookkugRecipeCard({Key? key, required this.recipe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {  Navigator.push(context,MaterialPageRoute(builder: (context){
        return RecipeDetail(recipe: recipe);
      }));},
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 120,
                  height: 120,
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
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.authorName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    recipe.recipeName,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
