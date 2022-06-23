import 'package:cached_network_image/cached_network_image.dart';
import 'package:cookkug/constants.dart';
import 'package:cookkug/controllers/user_controller.dart';
import 'package:cookkug/models/chatRoom/chatRoom.dart';
import 'package:cookkug/screens/chat_room_screen.dart';
import 'package:cookkug/services/firebase_service.dart';
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
      body: FutureBuilder(
          future: FirebaseService().getChatRoomList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<ChatRoom> chatRoomList = snapshot.data as List<ChatRoom>;
              return ListView(
                children: chatRoomList.map((chatRoom) {
                  return kChatRoomListTile(context, chatRoom: chatRoom);
                }).toList(),
              );
            }
            return Container();
          }),
    );
  }
}

Widget kChatRoomListTile(BuildContext context, {required ChatRoom chatRoom}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      ListTile(
        onTap: () =>
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ChatRoomScreen(chatRoomId: chatRoom.id);
        })),
        leading: FutureBuilder(
            future: FirebaseService().getUserImage(chatRoom.userIdList
                .firstWhere(
                    (element) => element != UserController.to.user!.uid)),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                String imageUrl = snapshot.data as String;
                if (imageUrl != '') {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(),
                        errorWidget: (context, url, error) =>
                            const Center(child: Icon(Icons.error_outline)),
                      ),
                    ),
                  );
                }
              }
              return Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: kBlackColor),
                  color: kWhiteColor,
                ),
              );
            }),
        title: Text(chatRoom.userList.firstWhere(
            (element) => element['id'] != UserController.to.user!.uid)['name']),
        subtitle: Text(chatRoom.lastMessage),
      ),
    ],
  );
}
