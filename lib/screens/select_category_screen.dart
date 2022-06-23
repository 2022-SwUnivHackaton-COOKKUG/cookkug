import 'package:cookkug/constants.dart';
import 'package:flutter/material.dart';

class SelectCategoryScreen extends StatelessWidget {
  const SelectCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        foregroundColor: kBlackColor,
        centerTitle: false,
        title: Text('카테고리'),
        elevation: 1,
      ),
      body: ListView(
        children: kFoodCategoryList.map((e) {
          return ListTile(
            onTap: (){
              Navigator.of(context).pop(e);
            },
            title: Text(e),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: kGreyColor,
              size: 20,
            ),
          );
        }).toList(),
      ),
    );
  }
}
