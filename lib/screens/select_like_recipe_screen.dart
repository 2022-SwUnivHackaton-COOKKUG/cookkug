import 'package:cached_network_image/cached_network_image.dart';
import 'package:cookkug/constants.dart';
import 'package:cookkug/models/recipe/recipe.dart';
import 'package:cookkug/services/http_service.dart';
import 'package:flutter/material.dart';

import '../controllers/user_controller.dart';

class SelectLikeRecipeScreen extends StatefulWidget {
  const SelectLikeRecipeScreen({Key? key}) : super(key: key);

  @override
  State<SelectLikeRecipeScreen> createState() => _SelectLikeRecipeScreenState();
}

class _SelectLikeRecipeScreenState extends State<SelectLikeRecipeScreen> {
  List<String> recipeIdList = [];
  List<Recipe> recipeList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setRecipeList();
  }

  void setRecipeList() async {
    recipeList = await HttpService().getRandomRecipe();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${UserController.to.user!.name}님, 안녕하세요!',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '다음',
                    style: TextStyle(
                      fontSize: 16,
                      color: kMainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              SizedBox(height: 5),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kBlackColor,
                  ),
                  children: [
                    TextSpan(text: '좋아하는 레시피를 '),
                    TextSpan(
                        text: '꾹',
                        style: TextStyle(
                          color: kMainColor,
                        )),
                    TextSpan(text: '해주세요'),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Text('쿡꾹이 회원님의 고민을 줄여드릴게요!'),
              SizedBox(height: 30),
              Expanded(
                child: GridView.count(
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  crossAxisCount: 3,
                  children: recipeList.map((e) {
                    return GestureDetector(
                      onTap: () {
                        recipeIdList.add(e.id);
                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: recipeIdList.contains(e.id)
                              ? Border.all(
                                  width: 3,
                                  color: kMainColor,
                                )
                              : null,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: e.image[0],
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(),
                            errorWidget: (context, url, error) =>
                                const Center(child: Icon(Icons.error_outline)),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
