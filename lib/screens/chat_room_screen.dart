import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookkug/constants.dart';
import 'package:cookkug/controllers/user_controller.dart';
import 'package:cookkug/models/chat/chat.dart';
import 'package:cookkug/models/chatRoom/chatRoom.dart';
import 'package:cookkug/services/firebase_service.dart';
import 'package:flutter/material.dart';

import '../utils/local_utils.dart';

class ChatRoomScreen extends StatefulWidget {
  final String chatRoomId;
  const ChatRoomScreen({Key? key, required this.chatRoomId}) : super(key: key);

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController(
    initialScrollOffset: 0,
  );

  void sendMessage(String chatRoomId) async {
    if (_messageController.text.isEmpty) return;
    if (_messageController.text.replaceAll(' ', '') == '') return;
    await FirebaseService().sendMessageInChatRoom(
      chatRoomId: chatRoomId,
      message: _messageController.text,
    );

    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseService().getChatRoomWithId(widget.chatRoomId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ChatRoom chatRoom = snapshot.data as ChatRoom;
            return Scaffold(
              backgroundColor: kWhiteColor,
              appBar: AppBar(
                backgroundColor: kWhiteColor,
                foregroundColor: kBlackColor,
                elevation: 0,
                centerTitle: false,
                automaticallyImplyLeading: false,
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios),
                    ),
                    FutureBuilder(
                        future: FirebaseService().getUserImage(
                            chatRoom.userIdList.firstWhere((element) =>
                                element != UserController.to.user!.uid)),
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
                                        const Center(
                                            child: Icon(Icons.error_outline)),
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
                    const SizedBox(width: 20),
                    Text(chatRoom.userList.firstWhere((element) =>
                        element['id'] != UserController.to.user!.uid)['name']),
                  ],
                ),
              ),
              body: StreamBuilder(
                stream:
                    FirebaseService().getChatStreamWithChatRoomId(chatRoom.id),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    QuerySnapshot chatData = snapshot.data;
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 1),
                        curve: Curves.easeOut,
                      );
                    });

                    return SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: ListView(
                                controller: _scrollController,
                                children: chatData.docs.map((e) {
                                  Chat chat = Chat.fromJson(e.data());
                                  return SizedBox(
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment: chat.senderId ==
                                              UserController.to.user!.uid
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: kDarkGreyColor),
                                          ),
                                          child: Text(
                                            chat.message,
                                            style: TextStyle(
                                              color: kBlackColor,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4),
                                          child: Text(
                                            getDuration(chat.timeStamp),
                                            style: const TextStyle(
                                              fontSize: 8,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 10,
                              bottom:
                                  MediaQuery.of(context).viewPadding.bottom +
                                      10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: kWhiteColor,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: kWhiteColor,
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(color: kGreyColor),
                                    ),
                                    child: TextField(
                                      controller: _messageController,
                                      decoration: InputDecoration(
                                        icon: Container(
                                          alignment: Alignment.center,
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border:
                                                Border.all(color: kMainColor),
                                          ),
                                          child: Icon(
                                            Icons.add,
                                            color: kMainColor,
                                          ),
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      onSubmitted: (value){
                                        sendMessage(chatRoom.id);
                                      },
                                      style:  TextStyle(
                                        color: kBlackColor,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const Center(
                    child: Text('연결을 확인해주세요...'),
                  );
                },
              ),
            );
          }
          return Container();
        });
  }
}
