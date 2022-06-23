import 'package:cookkug/screens/select_like_recipe_screen.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../controllers/local_controller.dart';
import '../screens/user_list_screen.dart';

class CookKugAppbar extends StatelessWidget implements PreferredSizeWidget {
  
  const CookKugAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kWhiteColor,
      foregroundColor: kBlackColor,
      elevation: 0,
      centerTitle: false,
      title: SizedBox(
        height: 30,
        child: Image.asset('assets/logo/text_logo.png'),
      ),
      actions: [
        IconButton(
          onPressed: () {
LocalController().clearSharedPreferences();
          },
          icon: Icon(Icons.search, color: kMainColor),
        ),
        IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return UserListScreen();
            }));
          },
          icon: Icon(Icons.notifications, color: kMainColor),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
