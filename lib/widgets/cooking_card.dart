import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../constants.dart';
import '../models/cook/cook.dart';

class CookingCard extends StatelessWidget {
  final Cook cook;
  const CookingCard({Key? key, required this.cook}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: PhysicalModel(
          color: kWhiteColor,
          elevation: 5,
          borderRadius: BorderRadius.circular(10),
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: cook.image,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(),
                      errorWidget: (context, url, error) =>
                          const Center(child: Icon(Icons.error_outline)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cook.foodName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: kBlackColor.withAlpha(680),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        const Expanded(flex: 4, child: Text('조리시간')),
                        Expanded(flex: 5, child: Text('${cook.cookingTime}분')),
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(flex: 4, child: Text('난이도')),
                        Expanded(flex: 5, child: Text(cook.difficulty)),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
