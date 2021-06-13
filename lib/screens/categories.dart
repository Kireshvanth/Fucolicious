import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_swipable/flutter_swipable.dart';
import 'package:carousel_pro/carousel_pro.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    // double drawnPathX = 8.69;
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            // width: screenWidth,
            child: Column(
              children: [
                // SizedBox(
                //   height: 48,
                // ),
                Expanded(
                  child: Container(),
                  flex: 1,
                ),
                Image(
                  image: AssetImage(
                      "assests/categories_screen/Starbucks_Logo/Starbucks_Logo.png"),
                ),
                Expanded(
                  flex: 8,
                  child: Container(),
                ),
                // SizedBox(height: 474.75), //374.75
                Image(
                  image: AssetImage(
                      "assests/categories_screen/STARBUCKS_Watermark/STARBUCKS_Watermark.png"),
                ),
              ],
            ),
          ),
          Positioned(
            top: 251.17,
            left: 40.87,
            child: Stack(
              children: [
                Image(
                    image: AssetImage(
                        "assests/categories_screen/Coffee_Card_Watermark/Coffee_Card_Watermark.png")),
                Positioned(
                  top: 16.83,
                  left: 27.13,
                  child: Column(
                    children: [
                      Container(
                        width: 322,
                        height: 444,
                        child: Carousel(
                          indicatorBgPadding: 2.0,
                          autoplay: false,
                          dotBgColor: Colors.transparent,
                          boxFit: BoxFit.fitHeight,
                          dotIncreasedColor: Color(0xffFFB500),
                          images: [
                            Image.asset(
                                'assests/categories_screen/Coffee_Card/Coffee_Card.png'),
                            Image.asset(
                                'assests/categories_screen/Coffee_Card/Coffee_Card.png'),
                            Image.asset(
                                'assests/categories_screen/Coffee_Card/Coffee_Card.png'),
                          ],
                        ),
                      ),
                      Image(
                          image: AssetImage(
                              "assests/categories_screen/Dock/Dock.png")),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.69, top: 159.69),
            child: Image(
                image: AssetImage(
                    "assests/categories_screen/Drawn_Path/Drawn_Path.png")),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(15, 131, 15, 11),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select Category",
                      style: TextStyle(
                          fontFamily: "Kenyan Coffee",
                          fontSize: 29,
                          shadows: [
                            Shadow(
                              // bottomLeft
                              offset: Offset(-0.7, -0.7),
                              color: Color.fromRGBO(255, 242, 210, 1),
                            ),
                            Shadow(
                              // bottomRight
                              offset: Offset(0.7, -0.7),
                              color: Color.fromRGBO(255, 242, 210, 1),
                            ),
                            Shadow(
                              // topRight
                              offset: Offset(0.7, 0.7),
                              color: Color.fromRGBO(255, 242, 210, 1),
                            ),
                            Shadow(
                              // topLeft
                              offset: Offset(-0.7, 0.7),
                              color: Color.fromRGBO(255, 242, 210, 1),
                            ),
                          ]),
                    ),
                    Text(
                      "COFFEE",
                      style: TextStyle(
                        fontFamily: "Antipasto Pro",
                        fontSize: 62,
                        color: Color.fromRGBO(244, 239, 227, 1),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Swipe Down",
                        style: TextStyle(
                          fontFamily: "Comfortaa",
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                      Image(
                        image: AssetImage(
                            "assests/categories_screen/Down_Arrow/Down_Arrow.png"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Container(
          //   width: double.infinity,
          //   height: double.infinity,
          //   child: GestureDetector(onDoubleTap: () {
          //     setState(() {
          //       drawnPathX = 15;
          //     });
          //   }),
          // ),
        ],
      ),
    );
  }
}
