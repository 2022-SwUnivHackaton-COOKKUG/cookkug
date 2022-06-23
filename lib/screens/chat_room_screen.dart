import 'package:cloud_firestore/cloud_firestore.dart';
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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseService().getChatRoomWithId(widget.chatRoomId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ChatRoom chatRoom = snapshot.data as ChatRoom;
            return Scaffold(
              backgroundColor: const Color(0xFF26253A),
              appBar: AppBar(
                backgroundColor: const Color(0xFF26253A),
                foregroundColor: Colors.white,
                elevation: 0,
                title: Text(chatRoom.userList.firstWhere((element) =>
                    element['id'] != UserController.to.user!.uid)['name']),
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
                                            color: const Color(0xFF29343E),
                                            borderRadius: BorderRadius.only(
                                              topLeft: const Radius.circular(5),
                                              topRight:
                                                  const Radius.circular(5),
                                              bottomLeft: chat.senderId ==
                                                      UserController
                                                          .to.user!.uid
                                                  ? const Radius.circular(5)
                                                  : const Radius.circular(0),
                                              bottomRight: chat.senderId ==
                                                      UserController
                                                          .to.user!.uid
                                                  ? const Radius.circular(0)
                                                  : const Radius.circular(5),
                                            ),
                                          ),
                                          child: Text(
                                            chat.message,
                                            style: const TextStyle(
                                              color: Colors.white,
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
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.only(
                                  left: 16,
                                  right: 16,
                                  top: 8,
                                  bottom: MediaQuery.of(context)
                                          .viewPadding
                                          .bottom +
                                      8,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(0xFF212031),
                                ),
                                child: Row(
                                  children: [
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF2B2A3A),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: TextField(
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Send Message',
                                            hintStyle: TextStyle(
                                              color: Color(0xFF71707F),
                                            ),
                                          ),
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                          controller: _messageController,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        await FirebaseService()
                                            .sendMessageInChatRoom(
                                          chatRoomId: chatRoom.id,
                                          message: _messageController.text,
                                        );

                                        _scrollController.animateTo(
                                          _scrollController
                                              .position.maxScrollExtent,
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeOut,
                                        );
                                        _messageController.clear();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: const Icon(
                                          Icons.near_me,
                                          color: Color(0xFF71707F),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
