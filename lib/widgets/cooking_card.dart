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
        width: 120,
        margin: const EdgeInsets.only(right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: 120,
                height: 120,
                child: CachedNetworkImage(
                  imageUrl: cook.image,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(),
                  errorWidget: (context, url, error) =>
                      const Center(child: Icon(Icons.error_outline)),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cook.foodName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height:3),
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
                          '${cook.cookingTime}분',
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
