import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_swipable/flutter_swipable.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          //Container1 Starbucks logo,Starbucks watermark
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 30,
                  child: Image.asset(
                      'assests/categories_screen/Starbucks_Logo/Starbucks_Logo.png'),
                ),
                Expanded(
                  flex: 40,
                  child: SizedBox(),
                ),
                Expanded(
                  child: Image.asset(
                      'assests/categories_screen/STARBUCKS_Watermark/STARBUCKS_Watermark.png'),
                  flex: 30,
                ),
              ],
            ),
          ),
          //Container2 Card watermark,swipeDown text,downArrow Icon
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 30,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 47,
                  child: Container(
                    margin: EdgeInsets.only(left: screenWidth / 10),
                    child: Image.asset(
                        'assests/categories_screen/Coffee_Card_Watermark/Coffee_Card_Watermark.png'),
                  ),
                ),
                Expanded(
                  flex: 16,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 7,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Swipe Down',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Icon(
                          Icons.expand_more,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //Container3 Card of that category,Selectcategory text ,coffee text , drawn path
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 12,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 18,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: screenWidth / 25),
                        child: Text(
                          'Select Category',
                          style: TextStyle(
                            fontFamily: 'Kenyan Coffee',
                            fontStyle: FontStyle.italic,
                            fontSize: screenHeight / 25,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 1
                              ..color = Color(0xffFFF2D2),
                          ),
                        ),
                      ),
                      Container(
                        height: screenHeight / 10,
                        child: FittedBox(
                          alignment: Alignment.topLeft,
                          child: Image.asset(
                            'assests/categories_screen/Categories_name_with_drawn_path/coffee.png',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 46,
                  child: Swipable(
                    child: Container(
                      margin: EdgeInsets.only(
                          left: screenWidth / 4, top: screenHeight / 100),
                      child: Image.asset(
                          'assests/categories_screen/Coffee_Card/Coffee_Card.png'),
                    ),
                  ),
                ),
                Expanded(
                  flex: 24,
                  child: SizedBox(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
