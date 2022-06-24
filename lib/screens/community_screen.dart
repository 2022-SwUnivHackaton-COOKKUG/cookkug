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
              title: '크림스프와 스튜의 중간쯤🥛',
              content: '크림스튜 레시피를 보고 했긴한데 사랑니때문에 이가 아파서 재료를 좀 잘게 썰었더니 스프처럼 됐네요😆맛있으면 장땡!',
              imageUrl:
              'https://img.freepik.com/free-photo/soup-puree-of-champignon-in-bowl-on-light-board-top_423299-4764.jpg?size=626&ext=jpg',
              authorName: '프로자취러',
              getTimeDifference: '1시간전',
              sympathyCount: 24,
              commentCount: 31,
              isOdd: true
          ),
          kCommunityCard(
            title: '시금치미트아라비아따🌱',
            content: '넣은 건 다 나열한 음식이름이 먼가 웃기네요😆플레이팅 망했지만 맛있어서 괜찮아진😉',
            imageUrl:
            'https://img.freepik.com/free-photo/spicy-spaghetti-in-a-frying-pan_1150-22155.jpg?size=626&ext=jpg&ga=GA1.2.1213798442.1656026467',
            authorName: '파스타장인',
            getTimeDifference: '4시간전',
            sympathyCount: 41,
            commentCount: 16,
            isOdd: false,
          ),
          kCommunityCard(
            title: '비빔만두🥟',
            content: '점심에도 만두먹고 저녁에도 만두먹는 만두광인..나야나..🤍 언제가 피드에서 보고 꼭 먹어야지 벼르고 있었는데 드디어! 만두 쪼오끔 탔지만 맛있게 잘 먹었습니다😆',
            imageUrl:
            'https://img.freepik.com/free-photo/gunmandu-kimchi-mandu-korean-dumpling-on-plate-served-with-spicy-sauce-close-up_511235-8033.jpg?size=338&ext=jpg&ga=GA1.2.1213798442.1656026467',
            authorName: '만두맛나용!',
            getTimeDifference: '10시간전',
            sympathyCount: 11,
            commentCount: 13,
            isOdd: true,
          ),
          kCommunityCard(
            title: '반미 샌드위치🥖',
            content: '재료가 많은가? 했는데 많으면 맛있지! 해서 다 쑤셔 넣었더니 완성된 욕망의 반미 샌드위치,,🥰 한 입에 들어가진 않지만 넘 맛있게 잘 먹었습니다😆',
            imageUrl:
            'https://img.freepik.com/free-photo/delicious-sandwich-with-lettuce_144627-33591.jpg?size=626&ext=jpg&ga=GA1.2.1213798442.1656026467',
            authorName: '파스타장인',
            getTimeDifference: '4시간전',
            sympathyCount: 21,
            commentCount: 17,
            isOdd: false,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kMainColor,
        onPressed: (){},
        child: Icon(Icons.add),
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