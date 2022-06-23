import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';
import '../widgets/cookkug_appbar.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: const CookKugAppbar(),
      body: ListView(
        children: [
          kTopInfoArea(),
          const SizedBox(height: 20),
          kCommunityCard(
            title: '제목1',
            content: '내용1',
            imageUrl:
                'https://recipe1.ezmember.co.kr/cache/recipe/2020/05/23/128f4433b502ebc9df0bb6ebb494396d1_m.jpg',
            authorName: '정훈이',
            getTimeDifference: '1시간전',
            sympathyCount: 2,
            commentCount: 3,
            isOdd: true
          ),
          kCommunityCard(
              title: '제목2',
              content: '내용2',
              imageUrl:
              'https://recipe1.ezmember.co.kr/cache/recipe/2020/05/23/128f4433b502ebc9df0bb6ebb494396d1_m.jpg',
              authorName: '정훈이2',
              getTimeDifference: '1시간전',
              sympathyCount: 4,
              commentCount: 7,
              isOdd: false,
          ),
          kCommunityCard(
              title: '제목1',
              content: '내용1',
              imageUrl:
              'https://recipe1.ezmember.co.kr/cache/recipe/2020/05/23/128f4433b502ebc9df0bb6ebb494396d1_m.jpg',
              authorName: '정훈이',
              getTimeDifference: '1시간전',
              sympathyCount: 2,
              commentCount: 3,
              isOdd: true,
          ),
        ],
      ),
    );
  }
}

Widget kTopInfoArea() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                color: kBlackColor,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(text: '주변 자취생들은', style: TextStyle(color: kMainColor)),
                const TextSpan(text: ' 뭐 먹는지 궁금하다면?'),
              ],
            ),
          ),
        ),
        const FittedBox(
          child: Text(
            '꾹친에서 함께 고민나누고, 정보 공유하고!',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget kCommunityCard({
  required String title,
  required String content,
  required String imageUrl,
  required String authorName,
  required String getTimeDifference,
  required int sympathyCount,
  required int commentCount,
  required bool isOdd,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    width: double.infinity,
    color: isOdd?kLightGreyColor:kWhiteColor,
    child: Column(
      children: [
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    content,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: 60,
                height: 60,
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(),
                  errorWidget: (context, url, error) =>
                      const Center(child: Icon(Icons.error_outline)),
                ),
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                authorName,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
              Text(
                getTimeDifference,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        Divider(color: kDarkGreyColor),
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
          child: Row(
            children: [
              SvgPicture.asset('assets/icons/cookkug_friend.svg', width: 20),
              const SizedBox(width: 5),
              Text(
                '공감$sympathyCount',
                style: TextStyle(color: kDarkGreyColor),
              ),
              const SizedBox(width: 10),
              Icon(Icons.chat_bubble_outline, color: kMainColor, size: 20),
              const SizedBox(width: 5),
              Text(
                '댓글$commentCount',
                style: TextStyle(color: kDarkGreyColor),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
