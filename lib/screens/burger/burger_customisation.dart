import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:git_sem_custom_food/main.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:location/location.dart';
import 'package:fluttertoast/fluttertoast.dart' ;



final _auth = FirebaseAuth.instance ;

List wheelDataBun = ['REGULAR\nBUN', 'WHEAT\nBUN', 'SESAME\nSEED\nBUN'];
List wheelDataPatty = [
  'VEG\nPATTY',
  'POTATO\nPATTY',
  'BEEF\nPATTY',
  'CHICKEN\nPATTY',
  'FISH\nPATTY'
];
List wheelDataButter = [
  'SALTED\nBUTTER',
  'CLARIFIED\nBUTTER',
  'REGULAR\nButter'
];
List wheelDataCheese = [
  'AMERICAN\nCHEESE',
  'BRITAIN\nCHEESE',
  'PATOURISED\nCHEESE',
  'INDIAN\nCHEESE',
  'REGULAR\nCHEESE'
];
List wheelDataEgg = [
  'FOLDED\nEGG',
  'CHOPPED\nEGG',
  'SPREADED\nEGG',
  'HALF-BOIL\nEGG',
  'FULL-BOIL\nEGG',
  'REGULAR\nEGG'
];
List wheelDataFries = [
  'SMALL\nSIZE',
  'MEDIUM\nSIZE',
  'LARGE\nSIZE',
  'X-LARGE\nSIZE',
  'KITS'
];
List wheelDataLettuce = [
  'CRISP\nSHREDDED\nLETTUCE',
  'SHREDDED\nLETTUCE'
];



class BurgerCustomisation extends StatefulWidget {
  @override
  _BurgerCustomisationState createState() => _BurgerCustomisationState();
}

class _BurgerCustomisationState extends State<BurgerCustomisation> {

  final PageController controller = PageController(initialPage: 0);
  final _firestore = FirebaseFirestore.instance;
  User loggedInUser ;
  String email ;
  String time ;
  LocationData _locationData;

  Future<void> gettingEmail() async {
    try{
      if(_auth != null){
        final user = await _auth.currentUser;
        email = user.email ;
      }
      if(await GoogleSignIn().isSignedIn() == true){
        await GoogleSignIn().signOut() ;
        final user = await GoogleSignIn().currentUser;
        email = user.email ;
      }

    }
    catch(e){
      print(e);
    }
  }

  Future<void> getCurrentLocation() async {
    try{
      Location location =  new Location();

      bool _serviceEnabled;
      PermissionStatus _permissionGranted;
      // LocationData _locationData;

      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      _locationData = await location.getLocation();

    }
    catch(e){
      print(e);
    }
  }

  String _selectedBun = wheelDataBun[0] ;
  String _selectedPatty = wheelDataPatty[0] ;
  String _selectedLettuce = wheelDataLettuce[0] ;
  String _selectedButter = wheelDataButter[0] ;
  String _selectedCheese = wheelDataCheese[0] ;
  String _selectedEgg = wheelDataEgg[0] ;
  String _selectedFries = wheelDataFries[0] ;

  @override
  void initState() {
    super.initState();
    gettingEmail() ;
    getCurrentLocation() ;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xffFDFAF5),
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              scrollDirection: Axis.horizontal,
              controller: controller,
              children: [
                //bun
                Container(
                  child: Stack(
                    children: [
                      //bg images
                      Container(
                        child: Stack(
                          children: [
                            //bg image
                            Container(
                              height: double.infinity,
                              width: double.infinity,
                              child: FittedBox(
                                alignment: Alignment.topLeft,
                                fit: BoxFit.fill,
                                child: Image.asset(
                                    'assests/burger/burger_customization/Bg_image/BG_Image.png'),
                              ),
                            ),
                            //circle image
                            Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(left: screenWidth * 0.5),
                              child: Container(
                                height: screenHeight * 0.54,
                                width: screenWidth * 0.6,
                                child: FittedBox(
                                  alignment: Alignment.centerLeft,
                                  fit: BoxFit.fitHeight,
                                  child: Image.asset(
                                      'assests/burger/burger_customization/wheel/Wheel.png'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //other components
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //backarrow,image,cart
                            Expanded(
                              flex: 10,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      child: Icon(Icons.arrow_back),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    Image.asset(
                                        'assests/burger/burger_customization/Mcdonalds_logo/McDonalds_Logo.png'),
                                    Image.asset(
                                        'assests/burger/burger_dashboard/Cart_icon/Cart_Icon.png'),
                                  ],
                                ),
                              ),
                            ),
                            //customize text
                            Expanded(
                              flex: 14,
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: BorderedText(
                                  strokeWidth: 1,
                                  strokeColor: Colors.black.withOpacity(0.2),
                                  child: Text(
                                    'CUSTOMIZE',
                                    style: TextStyle(
                                      fontSize: 66,
                                      fontFamily: 'GoogleSans Bld',
                                      color: Colors.black.withOpacity(0.07),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 12,
                              child: Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(left: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                      child: Text(
                                        'Customize Your Own Burger',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black.withOpacity(0.47),
                                          fontFamily: 'GoogleSans',
                                        ),
                                      ),
                                    ),
                                    FittedBox(
                                      child: Text(
                                        'Select Your\nPreferred',
                                        style: TextStyle(
                                          fontSize: 32,
                                          color: Colors.black,
                                          fontFamily: 'GoogleSans Bld',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //bun text
                            Expanded(
                              flex: 8,
                              child: Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: FittedBox(
                                  child: BorderedText(
                                    strokeWidth: 3,
                                    strokeColor: Colors.black,
                                    child: Text(
                                      'Bun',
                                      style: TextStyle(
                                        fontSize: 50,
                                        color: Color(0xffFFCC00),
                                        fontFamily: 'GoogleSans Bld',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: SizedBox(),
                            ),
                            //price
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: EdgeInsets.only(left: 34),
                                child: FittedBox(
                                  child: Text(
                                    'PRICE',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontFamily: 'GoogleSans Bld',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: EdgeInsets.only(left: 34),
                                child: FittedBox(
                                  child: Text(
                                    '\$10',
                                    style: TextStyle(
                                      fontSize: 23,
                                      color: Color(0xffFFB31C).withOpacity(0.8),
                                      fontFamily: 'GoogleSans Bld',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.only(left: 34),
                                child: FittedBox(
                                  child: Text(
                                    'Whooper',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black.withOpacity(0.8),
                                      fontFamily: 'GoogleSans Bld',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: 100,
                                padding: EdgeInsets.only(left: 34),
                                child: Image.asset(
                                    'assests/burger/burger_customization/underline_path/Underline_Path.png'),
                              ),
                            ),
                            //burger image
                            Expanded(
                              flex: 17,
                              child: Hero(
                                tag: 'burger',
                                child: Container(
                                  width: 200,
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Image.asset(
                                        'assests/burger/burger_customization/burger_image/Burger_Image.png'),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: SizedBox(),
                            ),
                            Expanded(
                              flex: 5,
                              child: SizedBox(),
                            ),
                            //back and next button
                            Expanded(
                              flex: 5,
                              child: Container(
                                padding: EdgeInsets.only(right: 47, left: 50),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          controller.previousPage(
                                              duration: Duration(milliseconds: 500),
                                              curve: Curves.easeInOut);
                                        });
                                      },
                                      child: Container(
                                        height: 36,
                                        width: 88,
                                        child: Text(
                                          'Back',
                                          style: TextStyle(
                                            fontFamily: 'GoogleSans Bld',
                                            fontSize: 13,
                                            color: Colors.black.withOpacity(0.35),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          controller.nextPage(
                                              duration: Duration(milliseconds: 500),
                                              curve: Curves.easeInOut);
                                        });
                                      },
                                      child: Container(
                                        child: Stack(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(left: 4, top: 4),
                                              height: 36,
                                              width: 88,
                                              child: Center(
                                                child: Text(
                                                  'Next',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontFamily: 'GoogleSans Bld',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                color: Color(0xffFFE4B6),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                            ),
                                            DottedBorder(
                                              borderType: BorderType.RRect,
                                              radius: Radius.circular(10),
                                              strokeWidth: 1,
                                              dashPattern: [5, 2],
                                              color: Color(0xff4A3500),
                                              child: Container(
                                                height: 32,
                                                width: 84,
                                                color: Colors.transparent,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //button-home
                            Expanded(
                              flex: 10,
                              child: SizedBox(),
                            ),
                          ],
                        ),
                      ),
                      //circle text
                      Container(
                        alignment: Alignment.centerRight,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 23,
                              child: SizedBox(
                                height: screenHeight * 0.23,
                              ),
                            ),
                            Expanded(
                              flex: 54,
                              child: Container(
                                padding: EdgeInsets.only(left: screenWidth * 0.40),
                                // height: screenHeight * 0.5 ,
                                child: Center(
                                  child: ListWheelScrollView(
                                    onSelectedItemChanged: (value) {
                                      setState(() {
                                        _selectedBun=wheelDataBun[value];
                                      });
                                    },
                                    diameterRatio: 2,
                                    itemExtent: 200,
                                    offAxisFraction: -2,
                                    children: [
                                      Container(
                                        width: 120,
                                        child: Center(
                                          child: Text(
                                            wheelDataBun[0],
                                            style: TextStyle(
                                              color: _selectedBun==wheelDataBun[0]
                                                ? Colors.white
                                                : Color(0xffFFD685),
                                              fontFamily: 'GoogleSans Bld',
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 120,
                                        alignment: Alignment.topLeft,
                                        child: Center(
                                          child: Text(
                                            wheelDataBun[1],
                                            style: TextStyle(
                                              color: _selectedBun==wheelDataBun[1]
                                                  ? Colors.white
                                                  : Color(0xffFFD685),
                                              fontFamily: 'GoogleSans Bld',
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 120,
                                        child: Center(
                                          child: Text(
                                            wheelDataBun[2],
                                            style: TextStyle(
                                              color: _selectedBun==wheelDataBun[2]
                                                  ? Colors.white
                                                  : Color(0xffFFD685),
                                              fontFamily: 'GoogleSans Bld',
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 23,
                              child: SizedBox(
                                height: screenHeight * 0.23,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //Patty
                Container(
                  child: Stack(
                    children: [
                      //bg images
                      Container(
                        child: Stack(
                          children: [
                            //bg image
                            Container(
                              height: double.infinity,
                              width: double.infinity,
                              child: FittedBox(
                                alignment: Alignment.topLeft,
                                fit: BoxFit.fill,
                                child: Image.asset(
                                    'assests/burger/burger_customization/Bg_image/BG_Image.png'),
                              ),
                            ),
                            //circle image
                            Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(left: screenWidth * 0.5),
                              child: Container(
                                height: screenHeight * 0.54,
                                width: screenWidth * 0.6,
                                child: FittedBox(
                                  alignment: Alignment.centerLeft,
                                  fit: BoxFit.fitHeight,
                                  child: Image.asset(
                                      'assests/burger/burger_customization/wheel/Wheel.png'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //other components
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //backarrow,image,cart
                            Expanded(
                              flex: 10,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      child: Icon(Icons.arrow_back),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    Image.asset(
                                        'assests/burger/burger_customization/Mcdonalds_logo/McDonalds_Logo.png'),
                                    Image.asset(
                                        'assests/burger/burger_dashboard/Cart_icon/Cart_Icon.png'),
                                  ],
                                ),
                              ),
                            ),
                            //customize text
                            Expanded(
                              flex: 14,
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: BorderedText(
                                  strokeWidth: 1,
                                  strokeColor: Colors.black.withOpacity(0.2),
                                  child: Text(
                                    'CUSTOMIZE',
                                    style: TextStyle(
                                      fontSize: 66,
                                      fontFamily: 'GoogleSans Bld',
                                      color: Colors.black.withOpacity(0.07),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 12,
                              child: Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(left: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                      child: Text(
                                        'Customize Your Own Burger',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black.withOpacity(0.47),
                                          fontFamily: 'GoogleSans',
                                        ),
                                      ),
                                    ),
                                    FittedBox(
                                      child: Text(
                                        'Select Your\nPreferred',
                                        style: TextStyle(
                                          fontSize: 32,
                                          color: Colors.black,
                                          fontFamily: 'GoogleSans Bld',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //patty text
                            Expanded(
                              flex: 8,
                              child: Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: FittedBox(
                                  child: BorderedText(
                                    strokeWidth: 3,
                                    strokeColor: Colors.black,
                                    child: Text(
                                      'Patty',
                                      style: TextStyle(
                                        fontSize: 50,
                                        color: Color(0xffFFCC00),
                                        fontFamily: 'GoogleSans Bld',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: SizedBox(),
                            ),
                            //price
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: EdgeInsets.only(left: 34),
                                child: FittedBox(
                                  child: Text(
                                    'PRICE',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontFamily: 'GoogleSans Bld',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: EdgeInsets.only(left: 34),
                                child: FittedBox(
                                  child: Text(
                                    '\$10',
                                    style: TextStyle(
                                      fontSize: 23,
                                      color: Color(0xffFFB31C).withOpacity(0.8),
                                      fontFamily: 'GoogleSans Bld',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.only(left: 34),
                                child: FittedBox(
                                  child: Text(
                                    'Whooper',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black.withOpacity(0.8),
                                      fontFamily: 'GoogleSans Bld',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: 100,
                                padding: EdgeInsets.only(left: 34),
                                child: Image.asset(
                                    'assests/burger/burger_customization/underline_path/Underline_Path.png'),
                              ),
                            ),
                            //burger image
                            Expanded(
                              flex: 17,
                              child: Hero(
                                tag: 'burger',
                                child: Container(
                                  width: 200,
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Image.asset(
                                        'assests/burger/burger_customization/burger_image/Burger_Image.png'),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: SizedBox(),
                            ),
                            Expanded(
                              flex: 5,
                              child: SizedBox(),
                            ),
                            //back and next button
                            Expanded(
                              flex: 5,
                              child: Container(
                                padding: EdgeInsets.only(right: 47, left: 50),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          controller.previousPage(
                                              duration: Duration(milliseconds: 500),
                                              curve: Curves.easeInOut);
                                        });
                                      },
                                      child: Container(
                                        height: 36,
                                        width: 88,
                                        child: Text(
                                          'Back',
                                          style: TextStyle(
                                            fontFamily: 'GoogleSans Bld',
                                            fontSize: 13,
                                            color: Colors.black.withOpacity(0.35),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          controller.nextPage(
                                              duration: Duration(milliseconds: 500),
                                              curve: Curves.easeInOut);
                                        });
                                      },
                                      child: Container(
                                        child: Stack(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(left: 4, top: 4),
                                              height: 36,
                                              width: 88,
                                              child: Center(
                                                child: Text(
                                                  'Next',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontFamily: 'GoogleSans Bld',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                color: Color(0xffFFE4B6),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                            ),
                                            DottedBorder(
                                              borderType: BorderType.RRect,
                                              radius: Radius.circular(10),
                                              strokeWidth: 1,
                                              dashPattern: [5, 2],
                                              color: Color(0xff4A3500),
                                              child: Container(
                                                height: 32,
                                                width: 84,
                                                color: Colors.transparent,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //button-home
                            Expanded(
                              flex: 10,
                              child: SizedBox(),
                            ),
                          ],
                        ),
                      ),
                      //circle text
                      Container(
                        alignment: Alignment.centerRight,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 23,
                              child: SizedBox(
                                height: screenHeight * 0.23,
                              ),
                            ),
                            Expanded(
                              flex: 54,
                              child: Container(
                                padding: EdgeInsets.only(left: screenWidth * 0.40),
                                // height: screenHeight * 0.5 ,
                                child: Center(
                                  child: ListWheelScrollView(
                                    onSelectedItemChanged: (value) {
                                      setState(() {
                                        _selectedPatty = wheelDataPatty[value] ;
                                      });
                                    },
                                    diameterRatio: 2,
                                    itemExtent: 200,
                                    offAxisFraction: -2,
                                    children: [
                                      Container(
                                        width: 120,
                                        child: Center(
                                          child: Text(
                                            wheelDataPatty[0],
                                            style: TextStyle(
                                              color: _selectedPatty==wheelDataPatty[0]
                                                  ? Colors.white
                                                  : Color(0xffFFD685),
                                              fontFamily: 'GoogleSans Bld',
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 120,
                                        alignment: Alignment.topLeft,
                                        child: Center(
                                          child: Text(
                                            wheelDataPatty[1],
                                            style: TextStyle(
                                              color: _selectedPatty==wheelDataPatty[1]
                                                  ? Colors.white
                                                  : Color(0xffFFD685),
                                              fontFamily: 'GoogleSans Bld',
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 120,
                                        child: Center(
                                          child: Text(
                                            wheelDataPatty[2],
                                            style: TextStyle(
                                              color: _selectedPatty==wheelDataPatty[2]
                                                  ? Colors.white
                                                  : Color(0xffFFD685),
                                              fontFamily: 'GoogleSans Bld',
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 120,
                                        child: Center(
                                          child: Text(
                                            wheelDataPatty[3],
                                            style: TextStyle(
                                              color: _selectedPatty==wheelDataPatty[3]
                                                  ? Colors.white
                                                  : Color(0xffFFD685),
                                              fontFamily: 'GoogleSans Bld',
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 120,
                                        child: Center(
                                          child: Text(
                                            wheelDataPatty[4],
                                            style: TextStyle(
                                              color: _selectedPatty==wheelDataPatty[4]
                                                  ? Colors.white
                                                  : Color(0xffFFD685),
                                              fontFamily: 'GoogleSans Bld',
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 23,
                              child: SizedBox(
                                height: screenHeight * 0.23,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //lettuce
                Container(
                  child: Stack(
                    children: [
                      //bg images
                      Container(
                        child: Stack(
                          children: [
                            //bg image
                            Container(
                              height: double.infinity,
                              width: double.infinity,
                              child: FittedBox(
                                alignment: Alignment.topLeft,
                                fit: BoxFit.fill,
                                child: Image.asset(
                                    'assests/burger/burger_customization/Bg_image/BG_Image.png'),
                              ),
                            ),
                            //circle image
                            Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(left: screenWidth * 0.5),
                              child: Container(
                                height: screenHeight * 0.54,
                                width: screenWidth * 0.6,
                                child: FittedBox(
                                  alignment: Alignment.centerLeft,
                                  fit: BoxFit.fitHeight,
                                  child: Image.asset(
                                      'assests/burger/burger_customization/wheel/Wheel.png'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //other components
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //backarrow,image,cart
                            Expanded(
                              flex: 10,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      child: Icon(Icons.arrow_back),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    Image.asset(
                                        'assests/burger/burger_customization/Mcdonalds_logo/McDonalds_Logo.png'),
                                    Image.asset(
                                        'assests/burger/burger_dashboard/Cart_icon/Cart_Icon.png'),
                                  ],
                                ),
                              ),
                            ),
                            //customize text
                            Expanded(
                              flex: 14,
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: BorderedText(
                                  strokeWidth: 1,
                                  strokeColor: Colors.black.withOpacity(0.2),
                                  child: Text(
                                    'CUSTOMIZE',
                                    style: TextStyle(
                                      fontSize: 66,
                                      fontFamily: 'GoogleSans Bld',
                                      color: Colors.black.withOpacity(0.07),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 12,
                              child: Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(left: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                      child: Text(
                                        'Customize Your Own Burger',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black.withOpacity(0.47),
                                          fontFamily: 'GoogleSans',
                                        ),
                                      ),
                                    ),
                                    FittedBox(
                                      child: Text(
                                        'Select Your\nPreferred',
                                        style: TextStyle(
                                          fontSize: 32,
                                          color: Colors.black,
                                          fontFamily: 'GoogleSans Bld',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //lettuce text
                            Expanded(
                              flex: 8,
                              child: Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: FittedBox(
                                  child: BorderedText(
                                    strokeWidth: 3,
                                    strokeColor: Colors.black,
                                    child: Text(
                                      'Lettuce',
                                      style: TextStyle(
                                        fontSize: 50,
                                        color: Color(0xffFFCC00),
                                        fontFamily: 'GoogleSans Bld',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: SizedBox(),
                            ),
                            //price
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: EdgeInsets.only(left: 34),
                                child: FittedBox(
                                  child: Text(
                                    'PRICE',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontFamily: 'GoogleSans Bld',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: EdgeInsets.only(left: 34),
                                child: FittedBox(
                                  child: Text(
                                    '\$10',
                                    style: TextStyle(
                                      fontSize: 23,
                                      color: Color(0xffFFB31C).withOpacity(0.8),
                                      fontFamily: 'GoogleSans Bld',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.only(left: 34),
                                child: FittedBox(
                                  child: Text(
                                    'Whooper',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black.withOpacity(0.8),
                                      fontFamily: 'GoogleSans Bld',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: 100,
                                padding: EdgeInsets.only(left: 34),
                                child: Image.asset(
                                    'assests/burger/burger_customization/underline_path/Underline_Path.png'),
                              ),
                            ),
                            //burger image
                            Expanded(
                              flex: 17,
                              child: Hero(
                                tag: 'burger',
                                child: Container(
                                  width: 200,
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Image.asset(
                                        'assests/burger/burger_customization/burger_image/Burger_Image.png'),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: SizedBox(),
                            ),
                            Expanded(
                              flex: 5,
                              child: SizedBox(),
                            ),
                            //back and next button
                            Expanded(
                              flex: 5,
                              child: Container(
                                padding: EdgeInsets.only(right: 47, left: 50),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          controller.previousPage(
                                              duration: Duration(milliseconds: 500),
                                              curve: Curves.easeInOut);
                                        });
                                      },
                                      child: Container(
                                        height: 36,
                                        width: 88,
                                        child: Text(
                                          'Back',
                                          style: TextStyle(
                                            fontFamily: 'GoogleSans Bld',
                                            fontSize: 13,
                                            color: Colors.black.withOpacity(0.35),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          controller.nextPage(
                                              duration: Duration(milliseconds: 500),
                                              curve: Curves.easeInOut);
                                        });
                                      },
                                      child: Container(
                                        child: Stack(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(left: 4, top: 4),
                                              height: 36,
                                              width: 88,
                                              child: Center(
                                                child: Text(
                                                  'Next',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontFamily: 'GoogleSans Bld',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                color: Color(0xffFFE4B6),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                            ),
                                            DottedBorder(
                                              borderType: BorderType.RRect,
                                              radius: Radius.circular(10),
                                              strokeWidth: 1,
                                              dashPattern: [5, 2],
                                              color: Color(0xff4A3500),
                                              child: Container(
                                                height: 32,
                                                width: 84,
                                                color: Colors.transparent,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //button-home
                            Expanded(
                              flex: 10,
                              child: SizedBox(),
                            ),
                          ],
                        ),
                      ),
                      //circle text
                      Container(
                        alignment: Alignment.centerRight,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 23,
                              child: SizedBox(
                                height: screenHeight * 0.23,
                              ),
                            ),
                            Expanded(
                              flex: 54,
                              child: Container(
                                padding: EdgeInsets.only(left: screenWidth * 0.40),
                                // height: screenHeight * 0.5 ,
                                child: Center(
                                  child: ListWheelScrollView(
                                    onSelectedItemChanged: (value) {
                                      setState(() {
                                        _selectedLettuce = wheelDataLettuce[value];
                                      });
                                    },
                                    diameterRatio: 2,
                                    itemExtent: 200,
                                    offAxisFraction: -2,
                                    children: [
                                      Container(
                                        width: 120,
                                        child: Center(
                                          child: Text(
                                            wheelDataLettuce[0],
                                            style: TextStyle(
                                              color: _selectedLettuce==wheelDataLettuce[0]
                                                  ? Colors.white
                                                  : Color(0xffFFD685),
                                              fontFamily: 'GoogleSans Bld',
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 120,
                                        alignment: Alignment.topLeft,
                                        child: Center(
                                          child: Text(
                                            wheelDataLettuce[1],
                                            style: TextStyle(
                                              color: _selectedLettuce==wheelDataLettuce[1]
                                                  ? Colors.white
                                                  : Color(0xffFFD685),
                                              fontFamily: 'GoogleSans Bld',
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 23,
                              child: SizedBox(
                                height: screenHeight * 0.23,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //butter
                Container(
                  child: Stack(
                    children: [
                      //bg images
                      Container(
                        child: Stack(
                          children: [
                            //bg image
                            Container(
                              height: double.infinity,
                              width: double.infinity,
                              child: FittedBox(
                                alignment: Alignment.topLeft,
                                fit: BoxFit.fill,
                                child: Image.asset(
                                    'assests/burger/burger_customization/Bg_image/BG_Image.png'),
                              ),
                            ),
                            //circle image
                            Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(left: screenWidth * 0.5),
                              child: Container(
                                height: screenHeight * 0.54,
                                width: screenWidth * 0.6,
                                child: FittedBox(
                                  alignment: Alignment.centerLeft,
                                  fit: BoxFit.fitHeight,
                                  child: Image.asset(
                                      'assests/burger/burger_customization/wheel/Wheel.png'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //other components
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //backarrow,image,cart
                            Expanded(
                              flex: 10,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      child: Icon(Icons.arrow_back),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    Image.asset(
                                        'assests/burger/burger_customization/Mcdonalds_logo/McDonalds_Logo.png'),
                                    Image.asset(
                                        'assests/burger/burger_dashboard/Cart_icon/Cart_Icon.png'),
                                  ],
                                ),
                              ),
                            ),
                            //customize text
                            Expanded(
                              flex: 14,
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: BorderedText(
                                  strokeWidth: 1,
                                  strokeColor: Colors.black.withOpacity(0.2),
                                  child: Text(
                                    'CUSTOMIZE',
                                    style: TextStyle(
                                      fontSize: 66,
                                      fontFamily: 'GoogleSans Bld',
                                      color: Colors.black.withOpacity(0.07),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 12,
                              child: Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(left: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                      child: Text(
                                        'Customize Your Own Burger',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black.withOpacity(0.47),
                                          fontFamily: 'GoogleSans',
                                        ),
                                      ),
                                    ),
                                    FittedBox(
                                      child: Text(
                                        'Select Your\nPreferred',
                                        style: TextStyle(
                                          fontSize: 32,
                                          color: Colors.black,
                                          fontFamily: 'GoogleSans Bld',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //butter text
                            Expanded(
                              flex: 8,
                              child: Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: FittedBox(
                                  child: BorderedText(
                                    strokeWidth: 3,
                                    strokeColor: Colors.black,
                                    child: Text(
                                      'Butter',
                                      style: TextStyle(
                                        fontSize: 50,
                                        color: Color(0xffFFCC00),
                                        fontFamily: 'GoogleSans Bld',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: SizedBox(),
                            ),
                            //price
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: EdgeInsets.only(left: 34),
                                child: FittedBox(
                                  child: Text(
                                    'PRICE',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontFamily: 'GoogleSans Bld',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: EdgeInsets.only(left: 34),
                                child: FittedBox(
                                  child: Text(
                                    '\$10',
                                    style: TextStyle(
                                      fontSize: 23,
                                      color: Color(0xffFFB31C).withOpacity(0.8),
                                      fontFamily: 'GoogleSans Bld',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.only(left: 34),
                                child: FittedBox(
                                  child: Text(
                                    'Whooper',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black.withOpacity(0.8),
                                      fontFamily: 'GoogleSans Bld',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: 100,
                                padding: EdgeInsets.only(left: 34),
                                child: Image.asset(
                                    'assests/burger/burger_customization/underline_path/Underline_Path.png'),
                              ),
                            ),
                            //burger image
                            Expanded(
                              flex: 17,
                              child: Hero(
                                tag: 'burger',
                                child: Container(
                                  width: 200,
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Image.asset(
                                        'assests/burger/burger_customization/burger_image/Burger_Image.png'),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: SizedBox(),
                            ),
                            Expanded(
                              flex: 5,
                              child: SizedBox(),
                            ),
                            //back and next button
                            Expanded(
                              flex: 5,
                              child: Container(
                                padding: EdgeInsets.only(right: 47, left: 50),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          controller.previousPage(
                                              duration: Duration(milliseconds: 500),
                                              curve: Curves.easeInOut);
                                        });
                                      },
                                      child: Container(
                                        height: 36,
                                        width: 88,
                                        child: Text(
                                          'Back',
                                          style: TextStyle(
                                            fontFamily: 'GoogleSans Bld',
                                            fontSize: 13,
                                            color: Colors.black.withOpacity(0.35),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          controller.nextPage(
                                              duration: Duration(milliseconds: 500),
                                              curve: Curves.easeInOut);
                                        });
                                      },
                                      child: Container(
                                        child: Stack(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(left: 4, top: 4),
                                              height: 36,
                                              width: 88,
                                              child: Center(
                                                child: Text(
                                                  'Next',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontFamily: 'GoogleSans Bld',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                color: Color(0xffFFE4B6),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                            ),
                                            DottedBorder(
                                              borderType: BorderType.RRect,
                                              radius: Radius.circular(10),
                                              strokeWidth: 1,
                                              dashPattern: [5, 2],
                                              color: Color(0xff4A3500),
                                              child: Container(
                                                height: 32,
                                                width: 84,
                                                color: Colors.transparent,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //button-home
                            Expanded(
                              flex: 10,
                              child: SizedBox(),
                            ),
                          ],
                        ),
                      ),
                      //circle text
                      Container(
                        alignment: Alignment.centerRight,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 23,
                              child: SizedBox(
                                height: screenHeight * 0.23,
                              ),
                            ),
                            Expanded(
                              flex: 54,
                              child: Container(
                                padding: EdgeInsets.only(left: screenWidth * 0.40),
                                // height: screenHeight * 0.5 ,
                                child: Center(
                                  child: ListWheelScrollView(
                                    onSelectedItemChanged: (value) {
                                      setState(() {
                                        _selectedButter = wheelDataButter[value] ;
                                      });
                                    },
                                    diameterRatio: 2,
                                    itemExtent: 200,
                                    offAxisFraction: -2,
                                    children: [
                                      Container(
                                        width: 120,
                                        child: Center(
                                          child: Text(
                                            wheelDataButter[0],
                                            style: TextStyle(
                                              color: _selectedButter==wheelDataButter[0]
                                                  ? Colors.white
                                                  : Color(0xffFFD685),
                                              fontFamily: 'GoogleSans Bld',
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 120,
                                        alignment: Alignment.topLeft,
                                        child: Center(
                                          child: Text(
                                            wheelDataButter[1],
                                            style: TextStyle(
                                              color: _selectedButter==wheelDataButter[1]
                                                  ? Colors.white
                                                  : Color(0xffFFD685),
                                              fontFamily: 'GoogleSans Bld',
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 120,
                                        child: Center(
                                          child: Text(
                                            wheelDataButter[2],
                                            style: TextStyle(
                                              color: _selectedButter==wheelDataButter[2]
                                                  ? Colors.white
                                                  : Color(0xffFFD685),
                                              fontFamily: 'GoogleSans Bld',
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 23,
                              child: SizedBox(
                                height: screenHeight * 0.23,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //cheese
                Container(
                  child: Stack(
                    children: [
                      //bg images
                      Container(
                        child: Stack(
                          children: [
                            //bg image
                            Container(
                              height: double.infinity,
                              width: double.infinity,
                              child: FittedBox(
                                alignment: Alignment.topLeft,
                                fit: BoxFit.fill,
                                child: Image.asset(
                                    'assests/burger/burger_customization/Bg_image/BG_Image.png'),
                              ),
                            ),
                            //circle image
                            Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(left: screenWidth * 0.5),
                              child: Container(
                                height: screenHeight * 0.54,
                                width: screenWidth * 0.6,
                                child: FittedBox(
                                  alignment: Alignment.centerLeft,
                                  fit: BoxFit.fitHeight,
                                  child: Image.asset(
                                      'assests/burger/burger_customization/wheel/Wheel.png'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //other components
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //backarrow,image,cart
                            Expanded(
                              flex: 10,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      child: Icon(Icons.arrow_back),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    Image.asset(
                                        'assests/burger/burger_customization/Mcdonalds_logo/McDonalds_Logo.png'),
                                    Image.asset(
                                        'assests/burger/burger_dashboard/Cart_icon/Cart_Icon.png'),
                                  ],
                                ),
                              ),
                            ),
                            //customize text
                            Expanded(
                              flex: 14,
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: BorderedText(
                                  strokeWidth: 1,
                                  strokeColor: Colors.black.withOpacity(0.2),
                                  child: Text(
                                    'CUSTOMIZE',
                                    style: TextStyle(
                                      fontSize: 66,
                                      fontFamily: 'GoogleSans Bld',
                                      color: Colors.black.withOpacity(0.07),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 12,
                              child: Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(left: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                      child: Text(
                                        'Customize Your Own Burger',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black.withOpacity(0.47),
                                          fontFamily: 'GoogleSans',
                                        ),
                                      ),
                                    ),
                                    FittedBox(
                                      child: Text(
                                        'Select Your\nPreferred',
                                        style: TextStyle(
                                          fontSize: 32,
                                          color: Colors.black,
                                          fontFamily: 'GoogleSans Bld',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //cheese text
                            Expanded(
                              flex: 8,
                              child: Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: FittedBox(
                                  child: BorderedText(
                                    strokeWidth: 3,
                                    strokeColor: Colors.black,
                                    child: Text(
                                      'Cheese',
                                      style: TextStyle(
                                        fontSize: 50,
                                        color: Color(0xffFFCC00),
                                        fontFamily: 'GoogleSans Bld',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: SizedBox(),
                            ),
                            //price
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: EdgeInsets.only(left: 34),
                                child: FittedBox(
                                  child: Text(
                                    'PRICE',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontFamily: 'GoogleSans Bld',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: EdgeInsets.only(left: 34),
                                child: FittedBox(
                                  child: Text(
                                    '\$10',
                                    style: TextStyle(
                                      fontSize: 23,
                                      color: Color(0xffFFB31C).withOpacity(0.8),
                                      fontFamily: 'GoogleSans Bld',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.only(left: 34),
                                child: FittedBox(
                                  child: Text(
                                    'Whooper',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black.withOpacity(0.8),
                                      fontFamily: 'GoogleSans Bld',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: 100,
                                padding: EdgeInsets.only(left: 34),
                                child: Image.asset(
                                    'assests/burger/burger_customization/underline_path/Underline_Path.png'),
                              ),
                            ),
                            //burger image
                            Expanded(
                              flex: 17,
                              child: Hero(
                                tag: 'burger',
                                child: Container(
                                  width: 200,
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Image.asset(
                                        'assests/burger/burger_customization/burger_image/Burger_Image.png'),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: SizedBox(),
                            ),
                            Expanded(
                              flex: 5,
                              child: SizedBox(),
                            ),
                            //back and next button
                            Expanded(
                              flex: 5,
                              child: Container(
                                padding: EdgeInsets.only(right: 47, left: 50),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          controller.previousPage(
                                              duration: Duration(milliseconds: 500),
                                              curve: Curves.easeInOut);
                                        });
                                      },
                                      child: Container(
                                        height: 36,
                                        width: 88,
                                        child: Text(
                                          'Back',
                                          style: TextStyle(
                                            fontFamily: 'GoogleSans Bld',
                                            fontSize: 13,
                                            color: Colors.black.withOpacity(0.35),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          controller.nextPage(
                                              duration: Duration(milliseconds: 500),
                                              curve: Curves.easeInOut);
                                        });
                                      },
                                      child: Container(
                                        child: Stack(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(left: 4, top: 4),
                                              height: 36,
                                              width: 88,
                                              child: Center(
                                                child: Text(
                                                  'Next',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontFamily: 'GoogleSans Bld',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                color: Color(0xffFFE4B6),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                            ),
                                            DottedBorder(
                                              borderType: BorderType.RRect,
                                              radius: Radius.circular(10),
                                              strokeWidth: 1,
                                              dashPattern: [5, 2],
                                              color: Color(0xff4A3500),
                                              child: Container(
                                                height: 32,
                                                width: 84,
                                                color: Colors.transparent,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //button-home
                            Expanded(
                              flex: 10,
                              child: SizedBox(),
                            ),
                          ],
                        ),
                      ),
                      //circle text
                      Container(
                        alignment: Alignment.centerRight,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 23,
                              child: SizedBox(
                                height: screenHeight * 0.23,
                              ),
                            ),
                            Expanded(
                              flex: 54,
                              child: Container(
                                padding: EdgeInsets.only(left: screenWidth * 0.40),
                                // height: screenHeight * 0.5 ,
                                child: Center(
                                  child: ListWheelScrollView(
                                    onSelectedItemChanged: (value) {
                                      setState(() {
                                        _selectedCheese = wheelDataCheese[value] ;
                                      });
                                    },
                                    diameterRatio: 2,
                                    itemExtent: 200,
                                    offAxisFraction: -2,
                                    children: [
                                      Container(
                                        width: 120,
                                        child: Center(
                                          child: Text(
                                            wheelDataCheese[0],
                                            style: TextStyle(
                                              color: _selectedCheese==wheelDataCheese[0]
                                                  ? Colors.white
                                                  : Color(0xffFFD685),
                                              fontFamily: 'GoogleSans Bld',
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 120,
                                        alignment: Alignment.topLeft,
                                        child: Center(
                                          child: Text(
                                            wheelDataCheese[1],
                                            style: TextStyle(
                                              color: _selectedCheese==wheelDataCheese[1]
                                                  ? Colors.white
                                                  : Color(0xffFFD685),
                                              fontFamily: 'GoogleSans Bld',
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 120,
                                        child: Center(
                                          child: Text(
                                            wheelDataCheese[2],
                                            style: TextStyle(
                                              color: _selectedCheese==wheelDataCheese[2]
                                                  ? Colors.white
                                                  : Color(0xffFFD685),
                                              fontFamily: 'GoogleSans Bld',
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 120,
                                        child: Center(
                                          child: Text(
                                            wheelDataCheese[3],
                                            style: TextStyle(
                                              color: _selectedCheese==wheelDataCheese[3]
                                                  ? Colors.white
                                                  : Color(0xffFFD685),
                                              fontFamily: 'GoogleSans Bld',
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 120,
                                        child: Center(
                                          child: Text(
                                            wheelDataCheese[4],
                                            style: TextStyle(
                                              color: _selectedCheese==wheelDataCheese[4]
                                                  ? Colors.white
                                                  : Color(0xffFFD685),
                                              fontFamily: 'GoogleSans Bld',
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 23,
                              child: SizedBox(
                                height: screenHeight * 0.23,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //Egg
                Container(
                  child: Stack(
                    children: [
                      //bg images
                      Container(
                        child: Stack(
                          children: [
                            //bg image
                            Container(
                              height: double.infinity,
                              width: double.infinity,
                              child: FittedBox(
                                alignment: Alignment.topLeft,
                                fit: BoxFit.fill,
                                child: Image.asset(
                                    'assests/burger/burger_customization/Bg_image/BG_Image.png'),
                              ),
                            ),
                            //circle image
                            Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(left: screenWidth * 0.5),
                              child: Container(
                                height: screenHeight * 0.54,
                                width: screenWidth * 0.6,
                                child: FittedBox(
                                  alignment: Alignment.centerLeft,
                                  fit: BoxFit.fitHeight,
                                  child: Image.asset(
                                      'assests/burger/burger_customization/wheel/Wheel.png'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //other components
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //backarrow,image,cart
                            Expanded(
                              flex: 10,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      child: Icon(Icons.arrow_back),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    Image.asset(
                                        'assests/burger/burger_customization/Mcdonalds_logo/McDonalds_Logo.png'),
                                    Image.asset(
                                        'assests/burger/burger_dashboard/Cart_icon/Cart_Icon.png'),
                                  ],
                                ),
                              ),
                            ),
                            //customize text
                            Expanded(
                              flex: 14,
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: BorderedText(
                                  strokeWidth: 1,
                                  strokeColor: Colors.black.withOpacity(0.2),
                                  child: Text(
                                    'CUSTOMIZE',
                                    style: TextStyle(
                                      fontSize: 66,
                                      fontFamily: 'GoogleSans Bld',
                                      color: Colors.black.withOpacity(0.07),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 12,
                              child: Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(left: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                      child: Text(
                                        'Customize Your Own Burger',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black.withOpacity(0.47),
                                          fontFamily: 'GoogleSans',
                                        ),
                                      ),
                                    ),
                                    FittedBox(
                                      child: Text(
                                        'Select Your\nPreferred',
                                        style: TextStyle(
                                          fontSize: 32,
                                          color: Colors.black,
                                          fontFamily: 'GoogleSans Bld',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //Egg text
                            Expanded(
                              flex: 8,
                              child: Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: FittedBox(
                                  child: BorderedText(
                                    strokeWidth: 3,
                                    strokeColor: Colors.black,
                                    child: Text(
                                      'Egg',
                                      style: TextStyle(
                                        fontSize: 50,
                                        color: Color(0xffFFCC00),
                                        fontFamily: 'GoogleSans Bld',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: SizedBox(),
                            ),
                            //price
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: EdgeInsets.only(left: 34),
                                child: FittedBox(
                                  child: Text(
                                    'PRICE',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontFamily: 'GoogleSans Bld',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: EdgeInsets.only(left: 34),
                                child: FittedBox(
                                  child: Text(
                                    '\$10',
                                    style: TextStyle(
                                      fontSize: 23,
                                      color: Color(0xffFFB31C).withOpacity(0.8),
                                      fontFamily: 'GoogleSans Bld',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.only(left: 34),
                                child: FittedBox(
                                  child: Text(
                                    'Whooper',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black.withOpacity(0.8),
                                      fontFamily: 'GoogleSans Bld',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: 100,
                                padding: EdgeInsets.only(left: 34),
                                child: Image.asset(
                                    'assests/burger/burger_customization/underline_path/Underline_Path.png'),
                              ),
                            ),
                            //burger image
                            Expanded(
                              flex: 17,
                              child: Hero(
                                tag: 'burger',
                                child: Container(
                                  width: 200,
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Image.asset(
                                        'assests/burger/burger_customization/burger_image/Burger_Image.png'),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: SizedBox(),
                            ),
                            Expanded(
                              flex: 5,
                              child: SizedBox(),
                            ),
                            //back and next button
                            Expanded(
                              flex: 5,
                              child: Container(
                                padding: EdgeInsets.only(right: 47, left: 50),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          controller.previousPage(
                                              duration: Duration(milliseconds: 500),
                                              curve: Curves.easeInOut);
                                        });
                                      },
                                      child: Container(
                                        height: 36,
                                        width: 88,
                                        child: Text(
                                          'Back',
                                          style: TextStyle(
                                            fontFamily: 'GoogleSans Bld',
                                            fontSize: 13,
                                            color: Colors.black.withOpacity(0.35),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          controller.nextPage(
                                              duration: Duration(milliseconds: 500),
                                              curve: Curves.easeInOut);
                                        });
                                      },
                                      child: Container(
                                        child: Stack(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(left: 4, top: 4),
                                              height: 36,
                                              width: 88,
                                              child: Center(
                                                child: Text(
                                                  'Next',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontFamily: 'GoogleSans Bld',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                color: Color(0xffFFE4B6),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                            ),
                                            DottedBorder(
                                              borderType: BorderType.RRect,
                                              radius: Radius.circular(10),
                                              strokeWidth: 1,
                                              dashPattern: [5, 2],
                                              color: Color(0xff4A3500),
                                              child: Container(
                                                height: 32,
                                                width: 84,
                                                color: Colors.transparent,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //button-home
                            Expanded(
                              flex: 10,
                              child: SizedBox(),
                            ),
                          ],
                        ),
                      ),
                      //circle text
                      Container(
                        alignment: Alignment.centerRight,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 23,
                              child: SizedBox(
                                height: screenHeight * 0.23,
                              ),
                            ),
                            Expanded(
                              flex: 54,
                              child: Container(
                                padding: EdgeInsets.only(left: screenWidth * 0.40),
                                // height: screenHeight * 0.5 ,
                                child: Center(
                                  child: ListWheelScrollView(
                                    onSelectedItemChanged: (value) {
                                      setState(() {
                                        _selectedEgg = wheelDataEgg[value] ;
                                      });
                                    },
                                    diameterRatio: 2,
                                    itemExtent: 200,
                                    offAxisFraction: -2,
                                    children: [
                                      Container(
                                        width: 120,
                                        child: Center(
                                          child: Text(
                                            wheelDataEgg[0],
                                            style: TextStyle(
                                              color: _selectedEgg==wheelDataEgg[0]
                                                  ? Colors.white
                                                  : Color(0xffFFD685),
                                              fontFamily: 'GoogleSans Bld',
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 120,
                                        alignment: Alignment.topLeft,
                                        child: Center(
                                          child: Text(
                                            wheelDataEgg[1],
                                            style: TextStyle(
                                              color: _selectedEgg==wheelDataEgg[1]
                                                  ? Colors.white
                                                  : Color(0xffFFD685),
                                              fontFamily: 'GoogleSans Bld',
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 120,
                                        child: Center(
                                          child: Text(
                                            wheelDataEgg[2],
                                            style: TextStyle(
                                              color: _selectedEgg==wheelDataEgg[2]
                                                  ? Colors.white
                                                  : Color(0xffFFD685),
                                              fontFamily: 'GoogleSans Bld',
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 120,
                                        child: Center(
                                          child: Text(
                                            wheelDataEgg[3],
                                            style: TextStyle(
                                              color: _selectedEgg==wheelDataEgg[3]
                                                  ? Colors.white
                                                  : Color(0xffFFD685),
                                              fontFamily: 'GoogleSans Bld',
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 120,
                                        child: Center(
                                          child: Text(
                                            wheelDataEgg[4],
                                            style: TextStyle(
                                              color: _selectedEgg==wheelDataEgg[4]
                                                  ? Colors.white
                                                  : Color(0xffFFD685),
                                              fontFamily: 'GoogleSans Bld',
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 120,
                                        child: Center(
                                          child: Text(
                                            wheelDataEgg[5],
                                            style: TextStyle(
                                              color: _selectedEgg==wheelDataEgg[5]
                                                  ? Colors.white
                                                  : Color(0xffFFD685),
                                              fontFamily: 'GoogleSans Bld',
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 23,
                              child: SizedBox(
                                height: screenHeight * 0.23,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //Fries
                Container(
                  child: Stack(
                    children: [
                      //bg images
                      Container(
                        child: Stack(
                          children: [
                            //bg image
                            Container(
                              height: double.infinity,
                              width: double.infinity,
                              child: FittedBox(
                                alignment: Alignment.topLeft,
                                fit: BoxFit.fill,
                                child: Image.asset(
                                    'assests/burger/burger_customization/Bg_image/BG_Image.png'),
                              ),
                            ),
                            //circle image
                            Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(left: screenWidth * 0.5),
                              child: Container(
                                height: screenHeight * 0.54,
                                width: screenWidth * 0.6,
                                child: FittedBox(
                                  alignment: Alignment.centerLeft,
                                  fit: BoxFit.fitHeight,
                                  child: Image.asset(
                                      'assests/burger/burger_customization/wheel/Wheel.png'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //other components
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //backarrow,image,cart
                            Expanded(
                              flex: 10,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      child: Icon(Icons.arrow_back),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    Image.asset(
                                        'assests/burger/burger_customization/Mcdonalds_logo/McDonalds_Logo.png'),
                                    Image.asset(
                                        'assests/burger/burger_dashboard/Cart_icon/Cart_Icon.png'),
                                  ],
                                ),
                              ),
                            ),
                            //customize text
                            Expanded(
                              flex: 14,
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: BorderedText(
                                  strokeWidth: 1,
                                  strokeColor: Colors.black.withOpacity(0.2),
                                  child: Text(
                                    'CUSTOMIZE',
                                    style: TextStyle(
                                      fontSize: 66,
                                      fontFamily: 'GoogleSans Bld',
                                      color: Colors.black.withOpacity(0.07),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 12,
                              child: Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(left: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                      child: Text(
                                        'Customize Your Own Burger',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black.withOpacity(0.47),
                                          fontFamily: 'GoogleSans',
                                        ),
                                      ),
                                    ),
                                    FittedBox(
                                      child: Text(
                                        'Select Your\nPreferred',
                                        style: TextStyle(
                                          fontSize: 32,
                                          color: Colors.black,
                                          fontFamily: 'GoogleSans Bld',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //fries text
                            Expanded(
                              flex: 8,
                              child: Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: FittedBox(
                                  child: BorderedText(
                                    strokeWidth: 3,
                                    strokeColor: Colors.black,
                                    child: Text(
                                      'Fries',
                                      style: TextStyle(
                                        fontSize: 50,
                                        color: Color(0xffFFCC00),
                                        fontFamily: 'GoogleSans Bld',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: SizedBox(),
                            ),
                            //price
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: EdgeInsets.only(left: 34),
                                child: FittedBox(
                                  child: Text(
                                    'PRICE',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontFamily: 'GoogleSans Bld',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: EdgeInsets.only(left: 34),
                                child: FittedBox(
                                  child: Text(
                                    '\$10',
                                    style: TextStyle(
                                      fontSize: 23,
                                      color: Color(0xffFFB31C).withOpacity(0.8),
                                      fontFamily: 'GoogleSans Bld',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.only(left: 34),
                                child: FittedBox(
                                  child: Text(
                                    'Whooper',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black.withOpacity(0.8),
                                      fontFamily: 'GoogleSans Bld',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: 100,
                                padding: EdgeInsets.only(left: 34),
                                child: Image.asset(
                                    'assests/burger/burger_customization/underline_path/Underline_Path.png'),
                              ),
                            ),
                            //burger image
                            Expanded(
                              flex: 17,
                              child: Hero(
                                tag: 'burger',
                                child: Container(
                                  width: 200,
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Image.asset(
                                        'assests/burger/burger_customization/burger_image/Burger_Image.png'),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: SizedBox(),
                            ),
                            Expanded(
                              flex: 5,
                              child: SizedBox(),
                            ),
                            //back and place order button
                            Expanded(
                              flex: 5,
                              child: Container(
                                padding: EdgeInsets.only(right: 47, left: 50),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          controller.previousPage(
                                              duration: Duration(milliseconds: 500),
                                              curve: Curves.easeInOut);
                                        });
                                      },
                                      child: Container(
                                        height: 36,
                                        width: 88,
                                        child: Text(
                                          'Back',
                                          style: TextStyle(
                                            fontFamily: 'GoogleSans Bld',
                                            fontSize: 13,
                                            color: Colors.black.withOpacity(0.35),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (_)=> AlertDialog(
                                            elevation: 15,
                                            title: Text('Order to be placed'),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Bun :',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text('${_selectedBun.replaceAll('\n', ' ')}'),
                                                  ],
                                                ) ,
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Patty :',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text('${_selectedPatty.replaceAll('\n', ' ')}'),
                                                  ],
                                                ) ,
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Lettuce :',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text('${_selectedLettuce.replaceAll('\n', ' ')}'),
                                                  ],
                                                ) ,
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Butter :',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text('${_selectedButter.replaceAll('\n', ' ')}'),
                                                  ],
                                                ) ,
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Cheese :',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text('${_selectedCheese.replaceAll('\n', ' ')}'),
                                                  ],
                                                ) ,
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Egg :',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text('${_selectedEgg.replaceAll('\n', ' ')}'),
                                                  ],
                                                ) ,
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Fries :',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text('${_selectedFries.replaceAll('\n', ' ')}'),
                                                  ],
                                                ) ,
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Total Cost :',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      '\$10',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ) ,

                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: (){
                                                  Navigator.pop(context) ;
                                                },
                                                child: Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: 'GoogleSans Bld',
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  var time = DateTime.now().toString() ;
                                                  _firestore.collection('McDonalds').add({
                                                    'Bun' : '${_selectedBun.replaceAll('\n', ' ')}' ,
                                                    'Patty' : '${_selectedPatty.replaceAll('\n', ' ')}' ,
                                                    'Lettuce' : '${_selectedLettuce.replaceAll('\n', ' ')}',
                                                    'Butter' : '${_selectedButter.replaceAll('\n', ' ')}' ,
                                                    'Cheese' : '${_selectedCheese.replaceAll('\n', ' ')}' ,
                                                    'Egg' : '${_selectedEgg.replaceAll('\n', ' ')}' ,
                                                    'Fries' : '${_selectedFries.replaceAll('\n', ' ')}' ,
                                                    'Total Cost' : '\$10' ,
                                                    'User' : '$email',
                                                    'date_time' : time ,
                                                    'Latitude' : _locationData.latitude ,
                                                    'Longitude' : _locationData.longitude ,
                                                  });
                                                  await Fluttertoast.showToast(
                                                    msg: "Placed Order Successfully",
                                                    textColor: Color(0xffF8AD2C),
                                                    backgroundColor: Colors.white,
                                                  );

                                                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyApp()), (route) => false);
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(left: 4, top: 4),
                                                  height: 30,
                                                  width: 75,
                                                  child: Center(
                                                    child: Text(
                                                      'Confirm',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: 'GoogleSans Bld',
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xffFEDA92),
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(7),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      child: Container(
                                        child: Stack(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(left: 4, top: 4),
                                              height: 36,
                                              width: 103,
                                              child: Center(
                                                child: Text(
                                                  'Place Order',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'GoogleSans Bld',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                color: Color(0xffF8AD2C),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                            ),
                                            DottedBorder(
                                              borderType: BorderType.RRect,
                                              radius: Radius.circular(10),
                                              strokeWidth: 1,
                                              dashPattern: [5, 2],
                                              color: Color(0xff4A3500),
                                              child: Container(
                                                height: 32,
                                                width: 99,
                                                color: Colors.transparent,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //button-home
                            Expanded(
                              flex: 10,
                              child: SizedBox(),
                            ),
                          ],
                        ),
                      ),
                      //circle text
                      Container(
                        alignment: Alignment.centerRight,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 23,
                              child: SizedBox(
                                height: screenHeight * 0.23,
                              ),
                            ),
                            Expanded(
                              flex: 54,
                              child: Container(
                                padding: EdgeInsets.only(left: screenWidth * 0.40),
                                // height: screenHeight * 0.5 ,
                                child: Center(
                                  child: ListWheelScrollView(
                                    onSelectedItemChanged: (value) {
                                      setState(() {
                                        _selectedFries = wheelDataFries[value] ;
                                      });
                                    },
                                    diameterRatio: 2,
                                    itemExtent: 200,
                                    offAxisFraction: -2,
                                    children: [
                                      Container(
                                        width: 120,
                                        child: Center(
                                          child: Text(
                                            wheelDataFries[0],
                                            style: TextStyle(
                                              color: _selectedFries==wheelDataFries[0]
                                                  ? Colors.white
                                                  : Color(0xffFFD685),
                                              fontFamily: 'GoogleSans Bld',
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 120,
                                        alignment: Alignment.topLeft,
                                        child: Center(
                                          child: Text(
                                            wheelDataFries[1],
                                            style: TextStyle(
                                              color: _selectedFries==wheelDataFries[1]
                                                  ? Colors.white
                                                  : Color(0xffFFD685),
                                              fontFamily: 'GoogleSans Bld',
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 120,
                                        child: Center(
                                          child: Text(
                                            wheelDataFries[2],
                                            style: TextStyle(
                                              color: _selectedFries==wheelDataFries[2]
                                                  ? Colors.white
                                                  : Color(0xffFFD685),
                                              fontFamily: 'GoogleSans Bld',
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 120,
                                        child: Center(
                                          child: Text(
                                            wheelDataFries[3],
                                            style: TextStyle(
                                              color: _selectedFries==wheelDataFries[3]
                                                  ? Colors.white
                                                  : Color(0xffFFD685),
                                              fontFamily: 'GoogleSans Bld',
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 120,
                                        child: Center(
                                          child: Text(
                                            wheelDataFries[4],
                                            style: TextStyle(
                                              color: _selectedFries==wheelDataFries[4]
                                                  ? Colors.white
                                                  : Color(0xffFFD685),
                                              fontFamily: 'GoogleSans Bld',
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 23,
                              child: SizedBox(
                                height: screenHeight * 0.23,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex : 76,
                    child: SizedBox(),
                  ),
                  //dock
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: 7,
                        effect: ScrollingDotsEffect(
                          activeDotColor: Color(0xffFFB500),
                          strokeWidth: 1000,
                          dotHeight: 9,
                          dotWidth: 9,
                          fixedCenter: true,
                          dotColor: Color(0xff2D2D26),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex : 10,
                    child: SizedBox(),
                  ),
                  //button-home
                  Expanded(
                    flex: 7,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => MyApp()),
                                  (route) => false);
                        },
                        child: Image.asset(
                            'assests/burger/burger_customization/home_button/button-home.png'),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Container(
                        width: 150,
                        child: Divider(
                          height: 5,
                          color: Color(0xffAAA9AF),
                          thickness: 4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class WheelWidget extends StatelessWidget {
  final String text;
  WheelWidget({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Color(0xffFFD685),
            fontFamily: 'GoogleSans Bld',
            fontSize: 19,
          ),
        ),
      ),
    );
  }
}
