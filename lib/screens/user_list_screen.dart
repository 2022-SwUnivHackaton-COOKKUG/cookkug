import 'package:cookkug/constants.dart';
import 'package:cookkug/models/user/cookkugUser.dart';
import 'package:flutter/material.dart';

import '../controllers/cookkug_user_controller.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        foregroundColor: kBlackColor,
        title: Text('유저 리스트'),
      ),
      body: FutureBuilder(
        future: CookkugUserController.to.getUserList(),
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.hasData) {
            List<CookkugUser> userList = snapshot.data! as List<CookkugUser>;
            return ListView(
              children: userList.map((user){
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.uid),
                );
              }).toList(),
            );
          }
          return Container();
        },
      ),
    );
  }
}
