import 'package:cookkug/constants.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        foregroundColor: kBlackColor,
        elevation: 0,
        title: const Text('채팅'),
      ),
      body: ListView(
        children: [
          kChatRoomListTile(
            otherId: '1',
            otherName: '정훈1',
            lastMessage: '안녕하세요',
          ),
          kChatRoomListTile(
            otherId: '1',
            otherName: '정훈1',
            lastMessage: '안녕하세요',
          ),
        ],
      ),
    );
  }
}

Widget kChatRoomListTile({
  required String otherId,
  required String otherName,
  required String lastMessage,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: kBlackColor,
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        title: Text(otherName),
        subtitle: Text(lastMessage),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Divider(),
      ),
    ],
  );
}
