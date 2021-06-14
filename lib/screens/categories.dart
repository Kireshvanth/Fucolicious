import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_swipable/flutter_swipable.dart';
import 'package:carousel_pro/carousel_pro.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    // var screenHeight = MediaQuery.of(context).size.height;
    // var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          //Coffee Elements
          PageView(
            scrollDirection: Axis.horizontal,
            controller: controller,
            children: [
              Stack(
                children: [
                  //Starbucks Logo, Starbucks Watermark
                  Container(
                    // width: screenWidth,
                    child: Column(
                      children: [
                        Expanded(
                          //-------Empty Space-----------
                          child: Container(),
                          flex: 1,
                        ),
                        //-------Starbucks Logo--------
                        Image(
                          image: AssetImage(
                              "assests/categories_screen/Starbucks_Logo/Starbucks_Logo.png"),
                        ),
                        //-------Empty Space-----------
                        Expanded(
                          flex: 8,
                          child: Container(),
                        ),
                        //-------Starbucks Watermark--------
                        Image(
                          image: AssetImage(
                              "assests/categories_screen/STARBUCKS_Watermark/STARBUCKS_Watermark.png"),
                        ),
                      ],
                    ),
                  ),
                  //Coffee Card, Coffee Card Watermark
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
                                child: Image(
                                  image: AssetImage(
                                      "assests/categories_screen/Coffee_Card/Coffee_Card.png"),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  //Drawn Path
                  Padding(
                    padding: const EdgeInsets.only(left: 8.69, top: 159.69),
                    child: Image(
                        image: AssetImage(
                            "assests/categories_screen/Drawn_Path/Drawn_Path.png")),
                  ),
                  //COFFEE Text
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 167, 15, 11),
                    child: Text(
                      "COFFEE",
                      style: TextStyle(
                        fontFamily: "Antipasto Pro",
                        fontSize: 62,
                        color: Color.fromRGBO(244, 239, 227, 1),
                      ),
                    ),
                  ),
                ],
              ),
              Burger(),
              IceCream(),
            ],
          ),
          //Dock
          Padding(
            padding: EdgeInsets.only(left: 68, right: 20),
            child: Column(
              children: [
                Expanded(
                  child: Container(),
                  flex: 34,
                ),
                Image(
                    image:
                        AssetImage("assests/categories_screen/Dock/Dock.png")),
                Expanded(
                  child: Container(),
                  flex: 7,
                ),
              ],
            ),
          ),
          //Select Category
          Container(
            padding: EdgeInsets.fromLTRB(15, 131, 15, 11),
            child: Text(
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
          ),
          // Swipe Down
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: Container()),
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
        ],
      ),
    );
  }
}


class Burger extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //Starbucks Logo, Starbucks Watermark
        Container(
          // width: screenWidth,
          child: Column(
            children: [
              Expanded(
                //-------Empty Space-----------
                child: Container(),
                flex: 1,
              ),
              //-------Starbucks Logo--------
              Image(
                image: AssetImage(
                    "assests/categories_screen/Starbucks_Logo/Starbucks_Logo.png"),
              ),
              //-------Empty Space-----------
              Expanded(
                flex: 8,
                child: Container(),
              ),
              //-------Starbucks Watermark--------
              Image(
                image: AssetImage(
                    "assests/categories_screen/STARBUCKS_Watermark/STARBUCKS_Watermark.png"),
              ),
            ],
          ),
        ),
        //Coffee Card, Coffee Card Watermark
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
                      child: Image(
                        image: AssetImage(
                            "assests/categories_screen/Coffee_Card/Coffee_Card.png"),
                      ),
                      // child: Carousel(
                      //   indicatorBgPadding: 2.0,
                      //   autoplay: false,
                      //   dotBgColor: Colors.transparent,
                      //   boxFit: BoxFit.fitHeight,
                      //   dotIncreasedColor: Color(0xffFFB500),
                      //   images: [
                      //     Image.asset(
                      //         'assests/categories_screen/Coffee_Card/Coffee_Card.png'),
                      //     Image.asset(
                      //         'assests/categories_screen/Coffee_Card/Coffee_Card.png'),
                      //     Image.asset(
                      //         'assests/categories_screen/Coffee_Card/Coffee_Card.png'),
                      //   ],
                      // ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        //Drawn Path
        Padding(
          padding: const EdgeInsets.only(left: 8.69, top: 159.69),
          child: Image(
              image: AssetImage(
                  "assests/categories_screen/Drawn_Path/Drawn_Path.png")),
        ),
        //COFFEE Text
        Container(
          padding: EdgeInsets.fromLTRB(15, 167, 15, 11),
          child: Text(
            "COFFEE",
            style: TextStyle(
              fontFamily: "Antipasto Pro",
              fontSize: 62,
              color: Color.fromRGBO(244, 239, 227, 1),
            ),
          ),
        ),
      ],
    );
  }
}

class IceCream extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //Starbucks Logo, Starbucks Watermark
        Container(
          // width: screenWidth,
          child: Column(
            children: [
              Expanded(
                //-------Empty Space-----------
                child: Container(),
                flex: 1,
              ),
              //-------Starbucks Logo--------
              Image(
                image: AssetImage(
                    "assests/categories_screen/Starbucks_Logo/Starbucks_Logo.png"),
              ),
              //-------Empty Space-----------
              Expanded(
                flex: 8,
                child: Container(),
              ),
              //-------Starbucks Watermark--------
              Image(
                image: AssetImage(
                    "assests/categories_screen/STARBUCKS_Watermark/STARBUCKS_Watermark.png"),
              ),
            ],
          ),
        ),
        //Coffee Card, Coffee Card Watermark
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
                      child: Image(
                        image: AssetImage(
                            "assests/categories_screen/Coffee_Card/Coffee_Card.png"),
                      ),
                      // child: Carousel(
                      //   indicatorBgPadding: 2.0,
                      //   autoplay: false,
                      //   dotBgColor: Colors.transparent,
                      //   boxFit: BoxFit.fitHeight,
                      //   dotIncreasedColor: Color(0xffFFB500),
                      //   images: [
                      //     Image.asset(
                      //         'assests/categories_screen/Coffee_Card/Coffee_Card.png'),
                      //     Image.asset(
                      //         'assests/categories_screen/Coffee_Card/Coffee_Card.png'),
                      //     Image.asset(
                      //         'assests/categories_screen/Coffee_Card/Coffee_Card.png'),
                      //   ],
                      // ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        //Drawn Path
        Padding(
          padding: const EdgeInsets.only(left: 8.69, top: 159.69),
          child: Image(
              image: AssetImage(
                  "assests/categories_screen/Drawn_Path/Drawn_Path.png")),
        ),
        //COFFEE Text
        Container(
          padding: EdgeInsets.fromLTRB(15, 167, 15, 11),
          child: Text(
            "COFFEE",
            style: TextStyle(
              fontFamily: "Antipasto Pro",
              fontSize: 62,
              color: Color.fromRGBO(244, 239, 227, 1),
            ),
          ),
        ),
      ],
    );
  }
}
