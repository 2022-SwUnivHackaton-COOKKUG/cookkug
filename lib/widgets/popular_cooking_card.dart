import 'package:cached_network_image/cached_network_image.dart';
import '../constants.dart';
import '../models/cook/cook.dart';
import 'package:flutter/material.dart';

class PopularCookingCard extends StatelessWidget {
  final Cook cook;
  const PopularCookingCard({Key? key, required this.cook}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        width: 150,
        height: 230,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                width: 150,
                height: 175,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: kNeutral10Color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    SizedBox(
                      width: 150,
                      child: Text(
                        cook.foodName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.4,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '소요시간',
                      style: TextStyle(
                        fontSize: 12,
                        color: kNeutral30Color,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${cook.cookingTime}분',
                          style: TextStyle(
                            fontSize: 12,
                            color: kNeutral90Color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: kWhiteColor,
                          ),
                          child: const Icon(
                            Icons.bookmark_border,
                            size: 18,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 25,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(55),
                child: SizedBox(
                  width: 110,
                  height: 110,
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
          ],
        ),
      ),
    );
  }
}
