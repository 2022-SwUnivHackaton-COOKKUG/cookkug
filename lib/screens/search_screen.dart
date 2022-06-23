import 'package:flutter/material.dart';


class Search extends StatelessWidget {
  final TextEditingController _searchControl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0x00ffffff),
          foregroundColor: Colors.black,
          elevation: 0.0,
          leadingWidth: 20,
          //automaticallyImplyLeading: false,
          // The search area here
          title: Container(
            width: double.infinity,
            height: 40,

            decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(25.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3.0,
                ),
              ],

            ),
            child: Center(
              child: TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20,bottom: 5),
                    hintText: '검색어를 입력해주세요',
                    border: InputBorder.none),

              ),
            ),
          ),
        ),

        body: ListView(

            children: [
              getSearch(context)
            ]
        )
    );

  }
}
Widget getSearch(BuildContext context) {
  return Padding(

    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),

          Container(
            alignment: Alignment.topLeft,
            child:Text(
              '최근 검색어',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),

          ),

          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(

                    margin: EdgeInsets.only(top:20),
                    padding: EdgeInsets.all(6),
                    width:80,
                    height:30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 3.0,
                        ),
                      ],
                    ),
                    child: Text(
                      '스팸 돈부리',
                      style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,

                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),

                  Container(

                    margin: EdgeInsets.only(top:20),
                    padding: EdgeInsets.all(6),
                    width:80,
                    height:30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 3.0,
                        ),
                      ],
                    ),
                    child: Text(
                      '김치볶음밥',
                      style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,

                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(

                    margin: EdgeInsets.only(top:20),
                    padding: EdgeInsets.all(6),
                    width:50,
                    height:30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 3.0,
                        ),
                      ],
                    ),
                    child: Text(
                      '마늘',
                      style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,

                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 80,
              ),

              Container(

                //margin: EdgeInsets.only(10),
                padding: EdgeInsets.all(15),
                width:450,
                height:80,
                decoration: BoxDecoration(
                  image: DecorationImage(

                      image: AssetImage(
                        'assets/images/food1.png',


                      ),
                      fit: BoxFit.fill
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 3.0,

                    ),
                  ],
                ),
                child: Text(
                  '자취생도\n건강식 할수있어!',
                  style: TextStyle(fontSize: 20, color : Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right,

                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.topLeft,
                child:Text(
                  '요즘 핫한 레시피 랭킹 TOP5',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),

              ),
              SizedBox(
                height: 20,
              ),

              Container(

                child: ListView.builder(

                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,

                  itemCount: 5,
                  itemBuilder: (BuildContext context, int i){


                    return Container(

                      height: 50,
                      width: MediaQuery.of(context).size.width,

                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            blurRadius: 5.0,
                            //offset: Offset(5.0, 10.0),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(15),

                      child: Text('$i',
                        style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                      ),

                    );
                  },
                ),
              ),

            ],
          )

        ]
    ),
  );

}