import 'dart:io';

import 'package:cookkug/constants.dart';
import 'package:cookkug/screens/select_category_screen.dart';
import 'package:cookkug/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class RecipeUploadScreen extends StatefulWidget {
  const RecipeUploadScreen({Key? key}) : super(key: key);
  @override
  State<RecipeUploadScreen> createState() => _RecipeUploadScreenState();
}

class _RecipeUploadScreenState extends State<RecipeUploadScreen> {
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _ingridientController = TextEditingController();
  TextEditingController _orderController = TextEditingController();

  List<XFile> images = [];

  String? recipeName;
  String? cookingTime;
  List<String> needIngredientList = [];
  List<String> cookingOrder = [];
  String? selectedCategory;

  void pickMultiImages() async {
    List<XFile>? pickedImages =
        await _picker.pickMultiImage(maxWidth: 240, maxHeight: 240);
    if (pickedImages == null) return;
    setState(() {
      images = pickedImages;
    });
  }

  void uploadRecipe() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      barrierDismissible: false,
    );
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (images.isEmpty) {
        Fluttertoast.showToast(msg: '한개이상의 레시피 이미지를 등록해주세요');
        return;
      }
      if (needIngredientList.isEmpty ||
          cookingOrder.isEmpty ||
          selectedCategory == null) {
        Fluttertoast.showToast(msg: '필요한 정보를 모두 입력해주세요');
        return;
      }
      bool uploadSuccess = await FirebaseService().uploadRecipe(
        images: images,
        recipeName: recipeName!,
        cookingTime: cookingTime!,
        recipeCategory: selectedCategory!,
        ingredientList: needIngredientList,
        cookingOrder: cookingOrder,
      );
      Navigator.of(context).pop();
      if (uploadSuccess) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: kWhiteColor,
        appBar: AppBar(
          backgroundColor: kWhiteColor,
          foregroundColor: kBlackColor,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => pickMultiImages(),
                        child: Container(
                          alignment: Alignment.center,
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: kLightGreyColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.camera_alt,
                                size: 36,
                                color: kGreyColor,
                              ),
                              Text(
                                '${images.length}/10',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: kGreyColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ...images.map((XFile file) {
                        return Container(
                          margin: const EdgeInsets.only(right: 10),
                          alignment: Alignment.center,
                          width: 100,
                          height: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              File(file.path),
                              fit: BoxFit.fill,
                              width: 100,
                              height: 100,
                            ),
                          ),
                        );
                      }).toList()
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    '레시피이름',
                    style: TextStyle(
                      fontSize: 16,
                      color: kDarkGreyColor,
                    ),
                  ),
                ),
                kCustomTextFormField(onSaved: (value) {
                  recipeName = value;
                }, validator: (value) {
                  if (value == null || value.length < 2) {
                    return '레시피 이름을 입력해주세요';
                  }
                  return null;
                }, onSubmitted: (value) {
                  recipeName = value;
                }),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      '소요 시간',
                      style: TextStyle(
                        fontSize: 16,
                        color: kDarkGreyColor,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: kCustomTextFormField(
                        onSaved: (value) {
                          cookingTime = value;
                        },
                        validator: (value) {
                          if (value == null) return '소요시간을 입력해주세요';
                          return null;
                        },
                        suffix: Text(
                          '분',
                          style: TextStyle(
                            color: kGreyColor,
                          ),
                        ),
                        onSubmitted: (value) {
                          cookingTime = value;
                        },
                        isEnd: true,
                      ),
                    ),
                    const Divider(),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(),
                GestureDetector(
                  onTap: () async {
                    String? result = await Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const SelectCategoryScreen();
                    }));
                    if (result != null) {
                      setState(() {
                        selectedCategory = result;
                      });
                    }
                  },
                  child: Container(
                    color: kWhiteColor,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Text(
                          '카테고리 선택',
                          style: TextStyle(
                            fontSize: 16,
                            color: kDarkGreyColor,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          selectedCategory ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            color: kDarkGreyColor,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: kDarkGreyColor,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    '필요한 재료',
                    style: TextStyle(
                      fontSize: 16,
                      color: kDarkGreyColor,
                    ),
                  ),
                ),
                kCustomTextFormField(
                  onSaved: (value) {},
                  validator: (value) {
                    return null;
                  },
                  controller: _ingridientController,
                  suffix: GestureDetector(
                    onTap: () {
                      needIngredientList.add(_ingridientController.text);
                      _ingridientController.clear();
                      setState(() {

                      });
                    },
                    child: Text(
                      '+',
                      style: TextStyle(
                        fontSize: 16,
                        color: kGreyColor,
                      ),
                    ),
                  ),
                  onSubmitted: (value) {
                    needIngredientList.add(value);
                    _ingridientController.clear();
                    setState(() {

                    });
                  },
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: needIngredientList.map((e) {
                      return Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          color: kLightGreyColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Text(
                              e,
                              style: TextStyle(
                                color: kDarkGreyColor,
                              ),
                            ),
                            const SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                needIngredientList.remove(e);
                                setState(() {});
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: kGreyColor,
                                ),
                                child: Icon(
                                  Icons.clear,
                                  size: 12,
                                  color: kWhiteColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    '레시피 순서',
                    style: TextStyle(
                      fontSize: 16,
                      color: kDarkGreyColor,
                    ),
                  ),
                ),
                getRecipeOrder(cookingOrder, (String value) {
                  cookingOrder.remove(value);
                  setState(() {});
                }),
                Row(
                  children: [
                    Text(
                      '${cookingOrder.length + 1}',
                      style: TextStyle(
                        fontSize: 18,
                        color: kGreyColor,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: kCustomTextFormField(
                        controller: _orderController,
                        onSaved: (value) {},
                        validator: (value) {
                          return null;
                        },
                        suffix: GestureDetector(
                          onTap: () {
                            cookingOrder.add(_orderController.text);
                            _orderController.clear();
                            setState(() {

                            });
                          },
                          child: Text(
                            '+',
                            style: TextStyle(
                              fontSize: 16,
                              color: kGreyColor,
                            ),
                          ),
                        ),
                        onSubmitted: (value) {
                          cookingOrder.add(value);
                          _orderController.clear();
                          setState(() {

                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () => uploadRecipe(),
                  child: Material(
                    borderRadius: BorderRadius.circular(16),
                    elevation: 3,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      alignment: Alignment.center,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: kMainColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        '레시피 등록하기',
                        style: TextStyle(
                          fontSize: 18,
                          color: kWhiteColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).padding.bottom + 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget kCustomTextFormField({
  required FormFieldSetter onSaved,
  required FormFieldValidator validator,
  required Function onSubmitted,
  TextEditingController? controller,
  Widget? suffix,
  bool isEnd = false,
}) {
  return TextFormField(
    controller: controller,
    onSaved: (val) => onSaved(val),
    validator: (val) => validator(val),
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelStyle: const TextStyle(
        fontSize: 16,
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(
          width: 1,
        ),
      ),
      suffix: suffix,
    ),
    onFieldSubmitted: (value) => onSubmitted(value),
    textAlign: isEnd ? TextAlign.end : TextAlign.start,
    maxLines: 1,
  );
}

Widget getRecipeOrder(List<String> cookingOrder, Function removeValue) {
  List<Widget> result = [];
  for (int i = 0; i < cookingOrder.length; i++) {
    result.add(Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            '${i + 1}',
            style: TextStyle(
              fontSize: 18,
              color: kGreyColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              cookingOrder[i],
              style: TextStyle(
                color: kDarkGreyColor,
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () => removeValue(cookingOrder[i]),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: kGreyColor,
              ),
              child: Icon(
                Icons.clear,
                size: 16,
                color: kWhiteColor,
              ),
            ),
          ),
        ],
      ),
    ));
  }
  return Column(
    children: result,
  );
}
