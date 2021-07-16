import 'package:dotted_border/dotted_border.dart' ;
import 'package:dotted_line/dotted_line.dart' ;
import 'package:flutter/material.dart' ;
import 'package:sleek_circular_slider/sleek_circular_slider.dart' ;
import 'package:cloud_firestore/cloud_firestore.dart' ;
import 'package:firebase_auth/firebase_auth.dart' ;
import 'package:google_sign_in/google_sign_in.dart' ;
import 'package:location/location.dart' ;
import 'package:fluttertoast/fluttertoast.dart' ;
import 'package:git_sem_custom_food/main.dart';


List milkTypeAssetList = [
  'assests/coffee/coffee_customisation_two/almond/Almond.png',
  'assests/coffee/coffee_customisation_two/coconut/Coconut.png',
  'assests/coffee/coffee_customisation_two/whole/Whole.png',
];

List sugarTypeAssetList = [
  'assests/coffee/coffee_customisation_two/white/White.png',
  'assests/coffee/coffee_customisation_two/cane/cane.png',
  'assests/coffee/coffee_customisation_two/honey/honey.png',
];
final _auth = FirebaseAuth.instance ;



class CoffeeCustomisation extends StatefulWidget {

  @override
  _CoffeeCustomisationState createState() => _CoffeeCustomisationState();
}

class _CoffeeCustomisationState extends State<CoffeeCustomisation> {

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


  double _milkTypeOpacity = 0 ;
  double _sugarTypeOpacity = 0 ;
  double _sugarLevelOpacity = 0 ;
  double _caffeineLevelOpacity = 0 ;


  String selectedMilkTypeAsset = milkTypeAssetList[0] ;
  String selectedSugarTypeAsset = sugarTypeAssetList[0] ;
  String selectedTemperature = 'Normal';
  String selectedSugarLevel = 'No Sugar' ;
  String selectedCaffeineLevel = 'Very Light' ;
  String selectedMilkType = 'Almond';
  String selectedSugarType = 'White' ;
  String selectedSyrup = 'Caramel Syrup';
  List selectedToppings =[] ;


  double _currentSliderValueNumber = 1 ;

  @override
  void initState() {
    super.initState();
    gettingEmail() ;
    getCurrentLocation() ;
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width ;
    double screenHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom ;
    final PageController controller = PageController(initialPage: 0);

    return Scaffold(
      backgroundColor: Color(0xff181101),
      body: SafeArea(
        child: PageView(
          controller: controller,
          scrollDirection: Axis.vertical,
          children: [
            Container(
              color: Color(0xff181101),
              child: Stack(
                children: [
                  //circle with coffee image
                  Container(
                    child: Stack(
                      children: [
                        Container(
                          height : screenHeight * 0.55,
                          width: screenWidth,
                          padding : EdgeInsets.only(top: screenHeight * 0.07,left: screenWidth * 0.4),
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Image.asset('assests/coffee/coffee_customization/dotted_circle_watermark/Dotted_Circle_Watermark.png'),
                          ),
                        ),
                        Container(
                          height : screenHeight * 0.63,
                          width: screenWidth,
                          padding : EdgeInsets.only(top: screenHeight * 0.05,left: screenWidth * 0.3),
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Image.asset('assests/coffee/coffee_customization/coffee_image/Coffee_Image.png'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //other components
                  Container(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Container(
                            padding: EdgeInsets.only(left: 25 , right: 45),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context) ;
                                  },
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                  ),
                                ),
                                Image.asset('assests/coffee/coffee_customization/coffee_customization_logo/Coffee_Customization_Logo.png'),
                                Container(height: 1,color: Colors.transparent,)

                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: SizedBox(),
                        ),
                        //starbucks text
                        Expanded(
                          flex: 3,
                          child: Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(left: 30),
                            child: FittedBox(
                              child: Row(
                                children: [
                                  Text(
                                    'STARBUCKS',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: 'GoogleSans Bld',
                                    ),
                                  ),
                                  Text(
                                    ' /',
                                    style: TextStyle(
                                      color: Color(0xffFFC560) ,
                                      fontSize: 15 ,
                                      fontFamily: 'GoogleSans Bld' ,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: Container(
                            height: screenHeight * 0.10,
                            width: screenWidth,
                            padding: EdgeInsets.only(left: 30),
                            child: FittedBox(
                              alignment: Alignment.topLeft,
                              fit: BoxFit.fitHeight,
                              child: Image.asset('assests/coffee/coffee_customization/caffe_latte/CaffeLatte.png'),
                            ),
                          ),
                        ),
                        //price text
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(left: 30),
                            child: FittedBox(
                              child: Row(
                                children: [
                                  Text(
                                    'PRICE',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontFamily: 'GoogleSans Bld',
                                    ),
                                  ),
                                  Text(
                                    ' /',
                                    style: TextStyle(
                                      color: Color(0xffFFC560) ,
                                      fontSize: 10 ,
                                      fontFamily: 'GoogleSans Bld' ,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            padding: EdgeInsets.only(left: 30),
                            alignment: Alignment.topLeft,
                            child: FittedBox(
                              child: Text(
                                '\$10',
                                style: TextStyle(
                                  color: Color(0xffFCAE13) ,
                                  fontSize: 25 ,
                                  fontFamily: 'GoogleSans Bld' ,
                                ),
                              ),
                            ),
                          ),
                        ),
                        //category text
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(left: 30),
                            child: FittedBox(
                              child: Row(
                                children: [
                                  Text(
                                    'CATEGORY',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: 'GoogleSans Bld',
                                    ),
                                  ),
                                  Text(
                                    ' /',
                                    style: TextStyle(
                                      color: Color(0xffFFC560) ,
                                      fontSize: 12 ,
                                      fontFamily: 'GoogleSans Bld' ,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            padding: EdgeInsets.only(left: 30),
                            alignment: Alignment.topLeft,
                            child: FittedBox(
                              child: Text(
                                'Cold Drinks',
                                style: TextStyle(
                                  color: Color(0xff828282) ,
                                  fontSize: 14 ,
                                  fontFamily: 'GoogleSans Bld' ,
                                ),
                              ),
                            ),
                          ),
                        ),
                        //special text
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(left: 30),
                            child: FittedBox(
                              child: Row(
                                children: [
                                  Text(
                                    'SPECIAL CATEGORY',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontFamily: 'GoogleSans Bld',
                                    ),
                                  ),
                                  Text(
                                    ' /',
                                    style: TextStyle(
                                      color: Color(0xffFFC560) ,
                                      fontSize: 11 ,
                                      fontFamily: 'GoogleSans Bld' ,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            padding: EdgeInsets.only(left: 30),
                            alignment: Alignment.topLeft,
                            child: FittedBox(
                              child: Text(
                                'Bestseller',
                                style: TextStyle(
                                  color: Color(0xff828282) ,
                                  fontSize: 13 ,
                                  fontFamily: 'GoogleSans Bld' ,
                                ),
                              ),
                            ),
                          ),
                        ),
                        //Caffe Latte
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(left: 30),
                            child: FittedBox(
                              child: Row(
                                children: [
                                  Text(
                                    'Caffé Latte',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: 'GoogleSans Bld',
                                    ),
                                  ),
                                  Text(
                                    ' /',
                                    style: TextStyle(
                                      color: Color(0xffFFC560) ,
                                      fontSize: 14 ,
                                      fontFamily: 'GoogleSans Bld' ,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Container(
                            padding: EdgeInsets.only(left: 30),
                            alignment: Alignment.topLeft,
                            child: FittedBox(
                              child: Text(
                                'Our dark, rich espresso\nbalanced with steamed\nmilk and a layer of foam',
                                style: TextStyle(
                                  color: Color(0xff828282) ,
                                  fontSize: 14 ,
                                  fontFamily: 'GoogleSans Bld' ,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: SizedBox(),
                        ),
                        //machine image
                        Expanded(
                          flex: 45,
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 50),
                                  child: Image.asset('assests/coffee/coffee_customization/swipe_down/Swipe_Down_Asset.png'),
                                ),
                                Container(
                                  height: screenHeight * 0.45,
                                  width: screenWidth,
                                  child: FittedBox(
                                    fit: BoxFit.fitHeight,
                                    child: Image.asset('assests/coffee/coffee_customization/coffee_machine/Coffee_Machine_Group.png'),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 60, top: 80),
                                  child: Image.asset('assests/coffee/coffee_customization/click_on_machine/Click_on_Machine_Group.png'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
                color: Color(0xff181101),
                child: Stack(
                  children: [
                    Container(
                      child: ListView(
                        children: [
                          Container(
                            height: 300,
                            color: Colors.transparent,
                            child: Column(
                              children: [
                                //back arrow row
                                Container(
                                  padding: EdgeInsets.only(left: 25 , right: 45),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap:(){
                                          Navigator.pop(context) ;
                                        },
                                        child: Icon(
                                          Icons.arrow_back_ios,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Image.asset('assests/coffee/coffee_customisation_two/coffee_customisation_logo/Coffee_Customization_Logo.png'),
                                      Container(height: 1,width: 1,color: Colors.transparent,)

                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                //starbucks
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        //starbucks
                                        Container(
                                          alignment: Alignment.topLeft,
                                          padding: EdgeInsets.only(left: 25),
                                          child: Row(
                                            children: [
                                              Text(
                                                'STARBUCKS',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontFamily: 'GoogleSans Bld',
                                                ),
                                              ),
                                              Text(
                                                ' /',
                                                style: TextStyle(
                                                  color: Color(0xffFFC560) ,
                                                  fontSize: 10 ,
                                                  fontFamily: 'GoogleSans Bld' ,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 25),
                                          child: Image.asset('assests/coffee/coffee_customisation_two/caffe_latte/CaffeLatte.png'),

                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        //category
                                        Container(
                                          alignment: Alignment.topLeft,
                                          padding: EdgeInsets.only(left: 25),
                                          child: Row(
                                            children: [
                                              Text(
                                                'CATEGORY',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 9,
                                                  fontFamily: 'GoogleSans Bld',
                                                ),
                                              ),
                                              Text(
                                                ' /',
                                                style: TextStyle(
                                                  color: Color(0xffFFC560) ,
                                                  fontSize: 9 ,
                                                  fontFamily: 'GoogleSans Bld' ,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 25),
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'Cold Drinks',
                                            style: TextStyle(
                                              color: Color(0xff828282) ,
                                              fontSize: 11 ,
                                              fontFamily: 'GoogleSans Bld' ,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 40,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        //price
                                        Container(
                                          alignment: Alignment.topLeft,
                                          padding: EdgeInsets.only(left: 30),
                                          child: Row(
                                            children: [
                                              Text(
                                                'PRICE',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontFamily: 'GoogleSans Bld',
                                                ),
                                              ),
                                              Text(
                                                ' /',
                                                style: TextStyle(
                                                  color: Color(0xffFFC560) ,
                                                  fontSize: 10 ,
                                                  fontFamily: 'GoogleSans Bld' ,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 30),
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            '\$10',
                                            style: TextStyle(
                                              color: Color(0xffFCAE13) ,
                                              fontSize: 25 ,
                                              fontFamily: 'GoogleSans Bld' ,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        //special category
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Row(
                                            children: [
                                              Text(
                                                'SPECIAL CATEGORY',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 9,
                                                  fontFamily: 'GoogleSans Bld',
                                                ),
                                              ),
                                              Text(
                                                ' /',
                                                style: TextStyle(
                                                  color: Color(0xffFFC560) ,
                                                  fontSize: 9 ,
                                                  fontFamily: 'GoogleSans Bld' ,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'Bestseller',
                                            style: TextStyle(
                                              color: Color(0xff828282) ,
                                              fontSize: 11 ,
                                              fontFamily: 'GoogleSans Bld' ,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 40,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 25),
                                      child: Image.asset('assests/coffee/coffee_customisation_two/coffee_image_with_border/Coffee_Image_With_Border.png'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          //page 2
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 17),
                            height: 1800,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40.0),
                              border: Border.all(
                                color: Color(0xffFFC560) ,
                                width: 5,
                              ),
                            ),
                            child: Column(
                              children: [
                                //customise text
                                SizedBox(
                                  height: 17,
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(left: 30),
                                  child: Row(
                                    children: [
                                      Text(
                                        'CUSTOMIZE',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: 'GoogleSans Bld',
                                        ),
                                      ),
                                      Text(
                                        ' /',
                                        style: TextStyle(
                                          color: Color(0xffFFC560) ,
                                          fontSize: 14 ,
                                          fontFamily: 'GoogleSans Bld' ,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 30),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Your Coffee',
                                    style: TextStyle(
                                      color: Color(0xff828282).withOpacity(0.40) ,
                                      fontSize: 14 ,
                                      fontFamily: 'GoogleSans Bld' ,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 17,
                                ),
                                //dotted line
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: DottedLine(
                                    direction: Axis.horizontal,
                                    dashColor: Color(0xff4A3500),
                                    dashLength: 5,
                                    dashGapLength: 5,
                                    lineThickness: 2,
                                  ),
                                ),
                                SizedBox(
                                  height: 17,
                                ),

                                //preferred milk and sugar
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(left: 30),
                                  child: Row(
                                    children: [
                                      Text(
                                        'SELECT YOUR PREFERRED',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 9,
                                          fontFamily: 'GoogleSans Bld',
                                        ),
                                      ),
                                      Text(
                                        ' /',
                                        style: TextStyle(
                                          color: Color(0xffFFC560) ,
                                          fontSize: 9 ,
                                          fontFamily: 'GoogleSans Bld' ,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 30),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Milk & Sugar',
                                    style: TextStyle(
                                      color: Color(0xff4A3500).withOpacity(0.40) ,
                                      fontSize: 9 ,
                                      fontFamily: 'GoogleSans Bld' ,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 180,
                                  width: screenWidth * 0.9,
                                  child: Stack(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(top: 50),
                                        child: Image.asset('assests/coffee/coffee_customisation_two/Press_and_Hold_Asset/Press_and_Hold_Asset.png'),
                                        alignment: Alignment.topCenter,
                                      ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        height: 170,
                                        width: screenWidth * 0.45,
                                        child: FittedBox(
                                          child: Stack(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(left: 10),
                                                child: AnimatedOpacity(
                                                  duration: Duration(milliseconds: 300),
                                                  opacity: _milkTypeOpacity,
                                                  child: Image.asset('assests/coffee/coffee_customisation_two/select_milk_types/select_milk_types.png'),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(top: 75,left: 60),
                                                child: GestureDetector(
                                                  onLongPress: (){
                                                    setState(() {
                                                      if(_milkTypeOpacity == 0){
                                                        _milkTypeOpacity = 1 ;
                                                        _sugarTypeOpacity = 0 ;
                                                      }
                                                      else if (_milkTypeOpacity == 1) {
                                                        _milkTypeOpacity = 0 ;
                                                      }
                                                    });

                                                  },
                                                  child: Image.asset(selectedMilkTypeAsset),
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: (){
                                                setState(() {
                                                  selectedMilkTypeAsset = milkTypeAssetList[0] ;
                                                  selectedMilkType = 'Almond';
                                                });
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(top: 50,left: 25),
                                                height: 40,
                                                width: 40,
                                                color: Colors.transparent,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: (){
                                                setState(() {
                                                  selectedMilkTypeAsset = milkTypeAssetList[1] ;
                                                  selectedMilkType = 'Coconut' ;
                                                });
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(top: 15,left: 20),
                                                height: 40,
                                                width: 40,
                                                color: Colors.transparent,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: (){
                                                setState(() {
                                                  selectedMilkTypeAsset = milkTypeAssetList[2] ;
                                                  selectedMilkType = 'Whole' ;
                                                });
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(top: 50,left: 25),
                                                height: 40,
                                                width: 40,
                                                color: Colors.transparent,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      //sugar type
                                      Container(
                                        alignment: Alignment.topRight,
                                        height: 170,
                                        width: screenWidth * 0.9,
                                        child: FittedBox(
                                          child: Stack(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(left: 10),
                                                child: AnimatedOpacity(
                                                  duration: Duration(milliseconds: 300),
                                                  opacity: _sugarTypeOpacity,
                                                  child: Image.asset('assests/coffee/coffee_customisation_two/select_sugar_types/select_sugar_types.png'),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(top: 75,left: 60),
                                                child: GestureDetector(
                                                  onLongPress: (){
                                                    setState(() {
                                                      if(_sugarTypeOpacity == 0){
                                                        _sugarTypeOpacity = 1 ;
                                                        _milkTypeOpacity = 0 ;
                                                      }
                                                      else if (_sugarTypeOpacity == 1) {
                                                        _sugarTypeOpacity = 0 ;
                                                      }
                                                    });

                                                  },
                                                  child: Image.asset(selectedSugarTypeAsset),
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.topRight,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: (){
                                                setState(() {
                                                  selectedSugarTypeAsset = sugarTypeAssetList[0] ;
                                                  selectedSugarType = 'White' ;
                                                });
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(top: 50,right: 25),
                                                height: 40,
                                                width: 40,
                                                color: Colors.transparent,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: (){
                                                setState(() {
                                                  selectedSugarTypeAsset = sugarTypeAssetList[1] ;
                                                  selectedSugarType = 'Cane' ;
                                                });
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(top: 15,right: 20),
                                                height: 40,
                                                width: 40,
                                                color: Colors.transparent,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: (){
                                                setState(() {
                                                  selectedSugarTypeAsset = sugarTypeAssetList[2] ;
                                                  selectedSugarType = 'Honey' ;
                                                });
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(top: 50,right: 25),
                                                height: 40,
                                                width: 40,
                                                color: Colors.transparent,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 80,right: 85),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'SELECT YOUR',
                                            style: TextStyle(
                                                color: Color(0xff4A3500),
                                                fontSize: 9,
                                                fontFamily: 'GoogleSans Bld',
                                            ),
                                          ),
                                          Text(
                                            'MILK',
                                            style: TextStyle(
                                              color: Color(0xffFCAE13),
                                              fontSize: 9,
                                              fontFamily: 'GoogleSans Bld',
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'SELECT YOUR',
                                            style: TextStyle(
                                              color: Color(0xff4A3500),
                                              fontSize: 9,
                                              fontFamily: 'GoogleSans Bld',
                                            ),
                                          ),
                                          Text(
                                            'SUGAR\nTYPE',
                                            style: TextStyle(
                                              color: Color(0xffFCAE13),
                                              fontSize: 9,
                                              fontFamily: 'GoogleSans Bld',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                //dotted line
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  child: DottedLine(
                                    direction: Axis.horizontal,
                                    dashColor: Color(0xffFFC560).withOpacity(0.56),
                                    dashLength: 5,
                                    dashGapLength: 5,
                                    lineThickness: 1,
                                  ),
                                ),
                                SizedBox(
                                  height: 17,
                                ),
                                //preferred sugar and caffeine level text
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(left: 30),
                                  child: Row(
                                    children: [
                                      Text(
                                        'SELECT YOUR PREFERRED',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 9,
                                          fontFamily: 'GoogleSans Bld',
                                        ),
                                      ),
                                      Text(
                                        ' /',
                                        style: TextStyle(
                                          color: Color(0xffFFC560) ,
                                          fontSize: 9 ,
                                          fontFamily: 'GoogleSans Bld' ,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 30),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Sugar & Caffeine Level',
                                    style: TextStyle(
                                      color: Color(0xff4A3500).withOpacity(0.40) ,
                                      fontSize: 9 ,
                                      fontFamily: 'GoogleSans Bld' ,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 180,
                                  width: screenWidth * 0.9,
                                  child: Stack(
                                    children: [
                                      Container(
                                        child: Image.asset('assests/coffee/coffee_customisation_two/Swipe_Up_or_Down_Asset_sugar/Swipe_Up_or_Down_Asset_sugar.png'),
                                        alignment: Alignment.topCenter,
                                      ),
                                      //sugar level
                                      Container(
                                        alignment: Alignment.topLeft,
                                        height: 170,
                                        width: screenWidth * 0.45,
                                        child: FittedBox(
                                          child: Stack(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(left: 14,top: 50),
                                                child: AnimatedOpacity(
                                                  duration: Duration(milliseconds: 300),
                                                  opacity: _sugarLevelOpacity,
                                                  child: Image.asset('assests/coffee/coffee_customisation_two/sugar_selected_bg/sugar_selected_bg.png'),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(top: 75,left: 60),
                                                child: SleekCircularSlider(
                                                  innerWidget: (double value){
                                                    return Image.asset('assests/coffee/coffee_customisation_two/sugar_selected/Sugar_Selected.png');
                                                  },
                                                  appearance: CircularSliderAppearance(
                                                    size: 100,
                                                    customColors: CustomSliderColors(
                                                      trackColor: Color(0xffFEF2BA),
                                                      progressBarColors: [Color(0xff000000),Color(0xffFFAD17),Color(0xffFFD175),Color(0xffFFD074),Color(0xffFDF900)],
                                                    ),
                                                  ),
                                                  initialValue: 0,
                                                  onChange: (double value){
                                                    setState(() {
                                                      _sugarLevelOpacity = 1 ;
                                                    });
                                                  },
                                                  onChangeEnd: (double value){
                                                    setState(() {
                                                      _sugarLevelOpacity = 0 ;
                                                      if(value<=10){
                                                        selectedSugarLevel = 'No Sugar';
                                                      }
                                                      else if(value<=35){
                                                        selectedSugarLevel = 'Little Sugar';
                                                      }
                                                      else if(value<=65){
                                                        selectedSugarLevel = 'Medium Sugar';
                                                      }
                                                      else if(value<=90){
                                                        selectedSugarLevel = 'Extra Sugar';
                                                      }
                                                      else if(value<=100){
                                                        selectedSugarLevel = 'Nothing But Sugar';
                                                      }
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      //caffeine level
                                      Container(
                                        alignment: Alignment.topRight,
                                        height: 170,
                                        width: screenWidth * 0.9,
                                        child: FittedBox(
                                          child: Stack(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(left: 1,top: 50),
                                                child: AnimatedOpacity(
                                                  duration: Duration(milliseconds: 300),
                                                  opacity: _caffeineLevelOpacity,
                                                  child: Image.asset('assests/coffee/coffee_customisation_two/caffeine_selected_bg/Caffeine_Selected_bg.png'),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(top: 75,left: 50),
                                                child: SleekCircularSlider(
                                                  innerWidget: (double value){
                                                    return Container(
                                                      padding: EdgeInsets.only(left: 10),
                                                      child: Image.asset('assests/coffee/coffee_customisation_two/caffine_selected/Caffeine_Selected.png'),
                                                    );
                                                  },
                                                  appearance: CircularSliderAppearance(
                                                    size: 100,
                                                    customColors: CustomSliderColors(
                                                      trackColor: Color(0xffFEF2BA),
                                                      progressBarColors: [Color(0xff000000),Color(0xffFFAD17),Color(0xffFFD175),Color(0xffFFD074),Color(0xffFDF900)],
                                                    ),
                                                  ),
                                                  initialValue: 0,
                                                  onChange: (double value){
                                                    setState(() {
                                                      _caffeineLevelOpacity = 1 ;
                                                    });
                                                  },
                                                  onChangeEnd: (double value){
                                                    setState(() {
                                                      _caffeineLevelOpacity = 0 ;
                                                      if(value<=10){
                                                        selectedCaffeineLevel = 'Very Light';
                                                      }
                                                      else if(value<=35){
                                                        selectedCaffeineLevel = 'Light';
                                                      }
                                                      else if(value<=65){
                                                        selectedCaffeineLevel = 'Medium';
                                                      }
                                                      else if(value<=90){
                                                        selectedCaffeineLevel = 'Strong';
                                                      }
                                                      else if(value<=100){
                                                        selectedCaffeineLevel = 'Black Coffee';
                                                      }
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 80,right: 85),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'SELECT YOUR',
                                            style: TextStyle(
                                              color: Color(0xff4A3500),
                                              fontSize: 9,
                                              fontFamily: 'GoogleSans Bld',
                                            ),
                                          ),
                                          Text(
                                            'SUGAR\nLEVEL',
                                            style: TextStyle(
                                              color: Color(0xffFCAE13),
                                              fontSize: 9,
                                              fontFamily: 'GoogleSans Bld',
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'SELECT YOUR',
                                            style: TextStyle(
                                              color: Color(0xff4A3500),
                                              fontSize: 9,
                                              fontFamily: 'GoogleSans Bld',
                                            ),
                                          ),
                                          Text(
                                            'CAFFEINE\nLEVEL',
                                            style: TextStyle(
                                              color: Color(0xffFCAE13),
                                              fontSize: 9,
                                              fontFamily: 'GoogleSans Bld',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                //temperature
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(left: 30),
                                  child: Row(
                                    children: [
                                      Text(
                                        'SELECT YOUR PREFERRED',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 9,
                                          fontFamily: 'GoogleSans Bld',
                                        ),
                                      ),
                                      Text(
                                        ' /',
                                        style: TextStyle(
                                          color: Color(0xffFFC560) ,
                                          fontSize: 9 ,
                                          fontFamily: 'GoogleSans Bld' ,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 30),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Temperature',
                                    style: TextStyle(
                                      color: Color(0xff4A3500).withOpacity(0.40) ,
                                      fontSize: 9 ,
                                      fontFamily: 'GoogleSans Bld' ,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  child: Stack(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(left: 70),
                                        child: Image.asset('assests/coffee/coffee_customisation_two/Swipe_Up_or_Down_Asset_temp/Swipe_Up_or_Down_Asset_temp.png'),
                                      ),
                                      Container(
                                        child: Center(
                                          child: Image.asset('assests/coffee/coffee_customisation_two/temp_selected/Temp_Selected.png'),
                                        ),
                                      ),
                                      //slider
                                      Container(
                                        padding: EdgeInsets.only(left: 18,top: 25,bottom: 25),
                                        height: 150,
                                        child: Center(
                                          child: RotatedBox(
                                            quarterTurns: -1,
                                            child: SliderTheme(
                                              data: SliderTheme.of(context).copyWith(
                                                trackHeight: 2,
                                                thumbColor: Color(0xffFCAE13),
                                                overlayColor: Color(0xffFCAE13).withOpacity(0.5),
                                                thumbShape: RoundSliderThumbShape(
                                                  enabledThumbRadius: 3.0,
                                                ),
                                                overlayShape: RoundSliderOverlayShape(
                                                  overlayRadius: 10,
                                                ),
                                              ),
                                              child: Slider(
                                                inactiveColor: Color(0xffFCAE13).withOpacity(0.2),
                                                activeColor: Color(0xffFCAE13),
                                                value: _currentSliderValueNumber,
                                                min: 1,
                                                max: 3,
                                                divisions: 2,
                                                label: selectedTemperature,
                                                onChanged: (double value) {
                                                  setState(() {
                                                    _currentSliderValueNumber = value;
                                                    if(_currentSliderValueNumber == 1){
                                                      selectedTemperature = 'Normal' ;
                                                    }
                                                    if(_currentSliderValueNumber == 2){
                                                      selectedTemperature = 'Cold' ;
                                                    }
                                                    if(_currentSliderValueNumber == 3){
                                                      selectedTemperature = 'Very Cold' ;
                                                    }
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                //dotted line
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  child: DottedLine(
                                    direction: Axis.horizontal,
                                    dashColor: Color(0xffFFC560).withOpacity(0.56),
                                    dashLength: 5,
                                    dashGapLength: 5,
                                    lineThickness: 1,
                                  ),
                                ),
                                SizedBox(
                                  height: 17,
                                ),
                                //preferred syrup text
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(left: 30),
                                  child: Row(
                                    children: [
                                      Text(
                                        'DRAG AND DROP YOUR PREFERRED',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 9,
                                          fontFamily: 'GoogleSans Bld',
                                        ),
                                      ),
                                      Text(
                                        ' /',
                                        style: TextStyle(
                                          color: Color(0xffFFC560) ,
                                          fontSize: 9 ,
                                          fontFamily: 'GoogleSans Bld' ,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 30),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Syrup',
                                    style: TextStyle(
                                      color: Color(0xff4A3500).withOpacity(0.40) ,
                                      fontSize: 9 ,
                                      fontFamily: 'GoogleSans Bld' ,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: DottedBorder(
                                    strokeWidth: 2,
                                    dashPattern: [5,5],
                                    color: Color(0xffFFC560),
                                    borderType: BorderType.RRect,
                                    radius: Radius.circular(28),
                                    child: Container(
                                      padding: EdgeInsets.only(top: 15),
                                      height: 160,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SyrupCard(
                                            text: 'CARAMEL',
                                            imageContainer: Draggable<List>(
                                              data: [1,'Caramel Syrup'],
                                              child: Container(
                                                child: Image.asset('assests/coffee/coffee_customisation_two/caramel_image/Caramel_Image.png'),
                                              ),
                                              feedback: Container(
                                                child: Image.asset('assests/coffee/coffee_customisation_two/caramel_image/Caramel_Image.png'),
                                              ),
                                              childWhenDragging: Container(
                                                margin: EdgeInsets.only(left: 5,top: 10),
                                                height: 60,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(17),
                                                  color: Color(0xffF4EFE8),
                                                  border: Border.all(width: 1 , color: Colors.black ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SyrupCard(
                                            text: 'VANILLA',
                                            imageContainer: Draggable<List>(
                                              data: [1,'Vanilla Syrup'],
                                              child: Container(
                                                child: Image.asset('assests/coffee/coffee_customisation_two/vanilla/Vanilla_Image.png'),
                                              ),
                                              feedback: Container(
                                                child: Image.asset('assests/coffee/coffee_customisation_two/vanilla/Vanilla_Image.png'),
                                              ),
                                              childWhenDragging: Container(
                                                margin: EdgeInsets.only(left: 5,top: 10),
                                                height: 60,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(17),
                                                  color: Color(0xffF4EFE8),
                                                  border: Border.all(width: 1 , color: Colors.black ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SyrupCard(
                                            text: 'HAZELNUT',
                                            imageContainer: Draggable<List>(
                                              data: [1,'Hazelnut Syrup'],
                                              child: Container(
                                                child: Image.asset('assests/coffee/coffee_customisation_two/hazel_nut/Hazelnut_Image.png'),
                                              ),
                                              feedback: Container(
                                                child: Image.asset('assests/coffee/coffee_customisation_two/hazel_nut/Hazelnut_Image.png'),
                                              ),
                                              childWhenDragging: Container(
                                                margin: EdgeInsets.only(left: 5,top: 10),
                                                height: 60,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(17),
                                                  color: Color(0xffF4EFE8),
                                                  border: Border.all(width: 1 , color: Colors.black ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SyrupCard(
                                            text: 'SUGAR-FREE\nVANILLA',
                                            imageContainer: Draggable<List>(
                                              data: [1,'Sugar Free Vanilla Syrup'],
                                              child: Container(
                                                child: Image.asset('assests/coffee/coffee_customisation_two/sugarfree_vanilla/Sugarfree_Vanilla_Image.png'),
                                              ),
                                              feedback: Container(
                                                child: Image.asset('assests/coffee/coffee_customisation_two/sugarfree_vanilla/Sugarfree_Vanilla_Image.png'),
                                              ),
                                              childWhenDragging: Container(
                                                margin: EdgeInsets.only(left: 5,top: 10),
                                                height: 60,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(17),
                                                  color: Color(0xffF4EFE8),
                                                  border: Border.all(width: 1 , color: Colors.black ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 70,
                                ),
                                //preferred toppings
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(left: 30),
                                  child: Row(
                                    children: [
                                      Text(
                                        'DRAG AND DROP YOUR PREFERRED',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 9,
                                          fontFamily: 'GoogleSans Bld',
                                        ),
                                      ),
                                      Text(
                                        ' /',
                                        style: TextStyle(
                                          color: Color(0xffFFC560) ,
                                          fontSize: 9 ,
                                          fontFamily: 'GoogleSans Bld' ,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 30),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Toppings',
                                    style: TextStyle(
                                      color: Color(0xff4A3500).withOpacity(0.40) ,
                                      fontSize: 9 ,
                                      fontFamily: 'GoogleSans Bld' ,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 35),
                                  child: DottedBorder(
                                    strokeWidth: 2,
                                    dashPattern: [5,5],
                                    color: Color(0xffFFC560),
                                    borderType: BorderType.RRect,
                                    radius: Radius.circular(28),
                                    child: Container(
                                      padding: EdgeInsets.only(top: 15,bottom: 15),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ToppingsCard(
                                                text: 'Whipped\nCream',
                                                imageContainer: Draggable<List>(
                                                  data: [2,'Whipped Cream'],
                                                  child: Container(
                                                    child: Image.asset('assests/coffee/coffee_customisation_two/whipped_cream/Whipped_Cream_Image.png'),
                                                  ),
                                                  feedback: Container(
                                                    child: Image.asset('assests/coffee/coffee_customisation_two/whipped_cream/Whipped_Cream_Image.png'),
                                                  ),
                                                  childWhenDragging: Container(
                                                    margin: EdgeInsets.only(left: 5,top: 10),
                                                    height: 60,
                                                    width: 60,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(17),
                                                      color: Color(0xffF4EFE8),
                                                      border: Border.all(width: 1 , color: Colors.black ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              ToppingsCard(
                                                text: 'Sprinkles',
                                                imageContainer: Draggable<List>(
                                                  data: [2,'Sprinkles'],
                                                  child: Container(
                                                    child: Image.asset('assests/coffee/coffee_customisation_two/sprinkles/Sprinkles_Image.png'),
                                                  ),
                                                  feedback: Container(
                                                    child: Image.asset('assests/coffee/coffee_customisation_two/sprinkles/Sprinkles_Image.png'),
                                                  ),
                                                  childWhenDragging: Container(
                                                    margin: EdgeInsets.only(left: 5,top: 10),
                                                    height: 60,
                                                    width: 60,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(17),
                                                      color: Color(0xffF4EFE8),
                                                      border: Border.all(width: 1 , color: Colors.black ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              ToppingsCard(
                                                text: 'Caramel\nDrizzle',
                                                imageContainer: Draggable<List>(
                                                  data: [2,'Caramel Drizzle'],
                                                  child: Container(
                                                    child: Image.asset('assests/coffee/coffee_customisation_two/caramel_drizzle/Caramel_Drizzle_Image.png'),
                                                  ),
                                                  feedback: Container(
                                                    child: Image.asset('assests/coffee/coffee_customisation_two/caramel_drizzle/Caramel_Drizzle_Image.png'),
                                                  ),
                                                  childWhenDragging: Container(
                                                    margin: EdgeInsets.only(left: 5,top: 10),
                                                    height: 60,
                                                    width: 60,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(17),
                                                      color: Color(0xffF4EFE8),
                                                      border: Border.all(width: 1 , color: Colors.black ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [

                                              ToppingsCard(
                                                text: 'Chocolate\nDrizzle',
                                                imageContainer: Draggable<List>(
                                                  data: [2,'Chocolate Drizzle'],
                                                  child: Container(
                                                    child: Image.asset('assests/coffee/coffee_customisation_two/chocolate_drizzle/Chocolate_Drizzle_Image.png'),
                                                  ),
                                                  feedback: Container(
                                                    child: Image.asset('assests/coffee/coffee_customisation_two/chocolate_drizzle/Chocolate_Drizzle_Image.png'),
                                                  ),
                                                  childWhenDragging: Container(
                                                    margin: EdgeInsets.only(left: 5,top: 10),
                                                    height: 60,
                                                    width: 60,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(17),
                                                      color: Color(0xffF4EFE8),
                                                      border: Border.all(width: 1 , color: Colors.black ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              ToppingsCard(
                                                text: 'Cinnamon\nPowder',
                                                imageContainer: Draggable<List>(
                                                  data: [2,'Cinnamon Powder'],
                                                  child: Container(
                                                    child: Image.asset('assests/coffee/coffee_customisation_two/cinnaman_powder/Cinnamon_Powder_Image.png'),
                                                  ),
                                                  feedback: Container(
                                                    child: Image.asset('assests/coffee/coffee_customisation_two/cinnaman_powder/Cinnamon_Powder_Image.png'),
                                                  ),
                                                  childWhenDragging: Container(
                                                    margin: EdgeInsets.only(left: 5,top: 10),
                                                    height: 60,
                                                    width: 60,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(17),
                                                      color: Color(0xffF4EFE8),
                                                      border: Border.all(width: 1 , color: Colors.black ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              ToppingsCard(
                                                text: 'Cocoa\nPowder',
                                                imageContainer: Draggable<List>(
                                                  data: [2,'Cocoa Powder'],
                                                  child: Container(
                                                    child: Image.asset('assests/coffee/coffee_customisation_two/cocoa_powder/Cocoa_Powder_Image.png'),
                                                  ),
                                                  feedback: Container(
                                                    child: Image.asset('assests/coffee/coffee_customisation_two/cocoa_powder/Cocoa_Powder_Image.png'),
                                                  ),
                                                  childWhenDragging: Container(
                                                    margin: EdgeInsets.only(left: 5,top: 10),
                                                    height: 60,
                                                    width: 60,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(17),
                                                      color: Color(0xffF4EFE8),
                                                      border: Border.all(width: 1 , color: Colors.black ),
                                                    ),
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 200,
                            color: Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: (){
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
                                          'Milk Type : ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text('$selectedMilkType'),
                                      ],
                                    ) ,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Sugar Type :',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text('$selectedSugarType'),
                                      ],
                                    ) ,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Sugar Level :',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text('$selectedSugarLevel'),
                                      ],
                                    ) ,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Caffeine Level :',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text('$selectedCaffeineLevel'),
                                      ],
                                    ) ,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Temperature :',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text('$selectedTemperature'),
                                      ],
                                    ) ,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Syrup :',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text('$selectedSyrup'),
                                      ],
                                    ) ,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Toppings :',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text('$selectedToppings'),
                                        ),
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
                                    onPressed: () async{
                                      if(_locationData != null){
                                        var time = DateTime.now().toString() ;

                                        await _firestore.collection('Starbucks').add({
                                          'Milk Type' : selectedMilkType,
                                          'Sugar Type' : selectedSugarType,
                                          'Sugar Level' : selectedSugarLevel,
                                          'Caffeine Level' : selectedCaffeineLevel,
                                          'Temperature' : selectedTemperature,
                                          'Syrup' : selectedSyrup,
                                          'Toppings' : selectedToppings,
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

                                      }
                                      else{
                                        await Fluttertoast.showToast(
                                          msg: "Turn on your location to place your order",
                                          textColor: Color(0xffF8AD2C),
                                          backgroundColor: Colors.white,
                                        );
                                        Navigator.pop(context);
                                      }

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
                            alignment: Alignment.bottomCenter,
                            height: screenHeight,
                            width: screenWidth,
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: DragTarget(
                                builder: (BuildContext context,
                                    List<dynamic> accepted,
                                    List<dynamic> rejected){
                                  return Image.asset('assests/coffee/coffee_customization/coffee_machine/Coffee_Machine_Group.png') ;
                                },
                                onAccept: (List data){
                                  setState(() {
                                    if(data[0]==1){
                                      selectedSyrup = data[1];
                                    }
                                    if(data[0]==2){
                                      if(selectedToppings.contains(data[1]) == false){
                                        selectedToppings.add(data[1]);
                                      }
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 80),
                          alignment: Alignment.bottomLeft,
                          height: screenHeight,
                          width: screenWidth,
                          child: Image.asset('assests/coffee/coffee_customisation_two/click_on_machine/Click_on_Machine_Group.png'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    ) ;
  }
}

class SyrupCard extends StatefulWidget {

  final Widget imageContainer;
  final String text;

  SyrupCard({
    @required this.imageContainer,
    @required this.text,
  });

  @override
  _SyrupCardState createState() => _SyrupCardState();
}

class _SyrupCardState extends State<SyrupCard> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          widget.imageContainer,
          Text(
            widget.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              shadows: [
                Shadow(
                  offset: Offset(1, 1),
                  color: Color(0xffFCAE13),
                ),
              ],
              color: Color(0xff4A3500),
              fontSize: 12,
              fontFamily: 'GoogleSans Bld',
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            'Syrup',
            style: TextStyle(
              color: Colors.black.withOpacity(0.36),
              fontSize: 9,
              fontFamily: 'GoogleSans Bld',
            ),
          ),
        ],
      ),
    );
  }
}

class ToppingsCard extends StatefulWidget {

  final Widget imageContainer;
  final String text;

  ToppingsCard({
    @required this.imageContainer,
    @required this.text,
  });

  @override
  _ToppingsCardState createState() => _ToppingsCardState();
}

class _ToppingsCardState extends State<ToppingsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          widget.imageContainer,
          Text(
            widget.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              shadows: [
                Shadow(
                  offset: Offset(0.3, 0.3),
                  color: Color(0xffFCAE13),
                ),
              ],
              color: Color(0xff4A3500),
              fontSize: 11,
              fontFamily: 'GoogleSans Bld',
            ),
          ),
        ],
      ),
    );
  }
}




