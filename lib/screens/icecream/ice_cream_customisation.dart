import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:git_sem_custom_food/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final Border kactiveintensityBorder = Border.all(color: Color(0xffFFD56D), width: 3);
final Border kinactiveintensityBorder = Border.all(color: Colors.transparent);
final _auth = FirebaseAuth.instance;

class IceCreamCustomisation extends StatefulWidget {
  @override
  _IceCreamCustomisationState createState() => _IceCreamCustomisationState();
}

class _IceCreamCustomisationState extends State<IceCreamCustomisation> {

  final _firestore = FirebaseFirestore.instance;
  User loggedInUser ;
  String email ;
  String time ;


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


  int selectedIntensity;
  String selectedSyrupValue;
  String selectedVariation;
  int cost = 0;
  int quantity = 0;
  String selectedServingType;
  bool _checkedNuts = false;
  bool _checkedSprinkles = false;
  bool _checkedChocoChips = false;
  bool _checkedCreamStick = false;
  bool _checkedBrownie = false;
  bool _checkedGems = false;
  bool _checkedDryFruits = false;
  bool _checkedCherry = false;
  List<String> selectedTopping = [];


  @override
  void initState() {
    super.initState();
    gettingEmail() ;

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xffF2F3F0),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              children: [
                //back arrow and bg
                Container(
                  color: Color(0xffF2F3F0),
                  height: 324,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(25.0),
                          child: Icon(Icons.arrow_back_ios),
                        ),
                      ),
                      Center(
                        child: Image.asset(
                            'assests/ice_cream/ice_cream_bg/Icecream_BG_Image.png'),
                      ),
                    ],
                  ),
                ),
                //other components
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    height: 1600,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(-4, -4),
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        //bottom swiper
                        Container(
                          width: 55,
                          height: 6,
                          decoration: BoxDecoration(
                            color: Color(0xff707070).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        // Matcha text , cost
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 27),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Matcha ice cream',
                                    style: TextStyle(
                                      fontSize: 27,
                                      fontFamily: 'Ragazzi ExB',
                                      color: Colors.black.withOpacity(0.8),
                                    ),
                                  ),
                                  Text(
                                    'Shade-grown matcha from Japan',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Comfortaa',
                                      color: Colors.black.withOpacity(0.35),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    '\$$cost',
                                    style: TextStyle(
                                      fontSize: 23,
                                      fontFamily: 'GoogleSans',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Image.asset(
                                      'assests/ice_cream/underline_path/Underline_Path.png'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        //variations
                        Container(
                          padding: EdgeInsets.only(left: 26),
                          alignment: Alignment.topLeft,
                          child: Text(
                            'VARIATIONS',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'GoogleSans Bld',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 23),
                          height: 140,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              VariationsCard(
                                onTap: () {
                                  setState(() {
                                    selectedVariation = 'Regular';
                                    cost = 3;
                                  });
                                },
                                borderColor: selectedVariation == 'Regular'
                                    ? Color(0xffFCAE13)
                                    : Color(0xffF2F2F2),
                                containerColor: selectedVariation == 'Regular'
                                    ? Color(0xffFFF9ED)
                                    : Color(0xffFCFCFC),
                                mainText: 'Matcha',
                                subText: 'Regular',
                                imageChildren: [
                                  Image.asset(
                                      'assests/ice_cream/ice_cream_logo/ice_cream_logo.png'),
                                ],
                              ),
                              VariationsCard(
                                onTap: () {
                                  setState(() {
                                    selectedVariation = 'With Blended Oreo';
                                    cost = 4;
                                  });
                                },
                                borderColor:
                                    selectedVariation == 'With Blended Oreo'
                                        ? Color(0xffFCAE13)
                                        : Color(0xffF2F2F2),
                                containerColor:
                                    selectedVariation == 'With Blended Oreo'
                                        ? Color(0xffFFF9ED)
                                        : Color(0xffFCFCFC),
                                mainText: 'Matcha',
                                subText: 'With Blended Oreo',
                                imageChildren: [
                                  Image.asset(
                                      'assests/ice_cream/ice_cream_logo/ice_cream_logo.png'),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Icon(
                                    Icons.add,
                                    size: 10,
                                    color: Color(0xff4A3500).withOpacity(0.24),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Image.asset(
                                      'assests/ice_cream/cookies_logo/cookies_logo.png'),
                                ],
                              ),
                              VariationsCard(
                                onTap: () {
                                  setState(() {
                                    selectedVariation = 'With Walnuts';
                                    cost = 5;
                                  });
                                },
                                borderColor: selectedVariation == 'With Walnuts'
                                    ? Color(0xffFCAE13)
                                    : Color(0xffF2F2F2),
                                containerColor:
                                    selectedVariation == 'With Walnuts'
                                        ? Color(0xffFFF9ED)
                                        : Color(0xffFCFCFC),
                                mainText: 'Matcha',
                                subText: 'With Walnuts',
                                imageChildren: [
                                  Image.asset(
                                      'assests/ice_cream/ice_cream_logo/ice_cream_logo.png'),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Icon(
                                    Icons.add,
                                    size: 10,
                                    color: Color(0xff4A3500).withOpacity(0.24),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Image.asset(
                                      'assests/ice_cream/walnut_logo/walnut_logo.png'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        // intensity
                        Container(
                          padding: EdgeInsets.only(left: 26),
                          alignment: Alignment.topLeft,
                          child: Text(
                            'INTENSITY',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'GoogleSans Bld',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //intensity 1
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIntensity = 1;
                                });
                              },
                              child: Container(
                                height: 59,
                                width: 53,
                                decoration: BoxDecoration(
                                  color: Color(0xff8DCB39),
                                  border: selectedIntensity == 1
                                      ? kactiveintensityBorder
                                      : kinactiveintensityBorder,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    bottomLeft: Radius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            //intensity 2
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIntensity = 2;
                                });
                              },
                              child: Container(
                                height: 59,
                                width: 53,
                                decoration: BoxDecoration(
                                  color: Color(0xff7EB832),
                                  border: selectedIntensity == 2
                                      ? kactiveintensityBorder
                                      : kinactiveintensityBorder,
                                ),
                              ),
                            ),
                            //intensity 3
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIntensity = 3;
                                });
                              },
                              child: Container(
                                height: 59,
                                width: 53,
                                decoration: BoxDecoration(
                                  color: Color(0xff6DA432),
                                  border: selectedIntensity == 3
                                      ? kactiveintensityBorder
                                      : kinactiveintensityBorder,
                                ),
                              ),
                            ),
                            //intensity 4
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIntensity = 4;
                                });
                              },
                              child: Container(
                                height: 59,
                                width: 53,
                                decoration: BoxDecoration(
                                  color: Color(0xff488523),
                                  border: selectedIntensity == 4
                                      ? kactiveintensityBorder
                                      : kinactiveintensityBorder,
                                ),
                              ),
                            ),
                            //intensity 5
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIntensity = 5;
                                });
                              },
                              child: Container(
                                height: 59,
                                width: 53,
                                decoration: BoxDecoration(
                                  color: Color(0xff4B7B1D),
                                  border: selectedIntensity == 5
                                      ? kactiveintensityBorder
                                      : kinactiveintensityBorder,
                                ),
                              ),
                            ),
                            //intensity 6
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIntensity = 6;
                                });
                              },
                              child: Container(
                                height: 59,
                                width: 53,
                                decoration: BoxDecoration(
                                  color: Color(0xff3A6513),
                                  border: selectedIntensity == 6
                                      ? kactiveintensityBorder
                                      : kinactiveintensityBorder,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 45,
                        ),
                        //Serving
                        Container(
                          padding: EdgeInsets.only(left: 26),
                          alignment: Alignment.topLeft,
                          child: Text(
                            'SERVING',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'GoogleSans Bld',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 103,
                          padding: EdgeInsets.only(left: 3),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              ServingCard(
                                onTap: () {
                                  setState(() {
                                    selectedServingType = 'Cone';
                                  });
                                },
                                borderColor: selectedServingType == 'Cone'
                                    ? Color(0xffFFBE3D)
                                    : Colors.transparent,
                                iceText: 'Cone',
                                backgroundImage: Image.asset(
                                    'assests/ice_cream/cone/Cone_Image.png'),
                              ),
                              ServingCard(
                                onTap: () {
                                  setState(() {
                                    selectedServingType = 'Cup';
                                  });
                                },
                                borderColor: selectedServingType == 'Cup'
                                    ? Color(0xffFFBE3D)
                                    : Colors.transparent,
                                iceText: 'Cup',
                                backgroundImage: Image.asset(
                                    'assests/ice_cream/cup/Cup_Image.png'),
                              ),
                              ServingCard(
                                onTap: () {
                                  setState(() {
                                    selectedServingType = 'Bar';
                                  });
                                },
                                borderColor: selectedServingType == 'Bar'
                                    ? Color(0xffFFBE3D)
                                    : Colors.transparent,
                                iceText: 'Bar',
                                backgroundImage: Image.asset(
                                    'assests/ice_cream/bar/Bar_Image.png'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 45,
                        ),
                        //matcha(scoop/quantity)
                        Container(
                          padding: EdgeInsets.only(left: 26),
                          alignment: Alignment.topLeft,
                          child: Text(
                            'SCOOP',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'GoogleSans Bld',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          width: double.infinity,
                          height: 45,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Matcha',
                                style: TextStyle(
                                  fontSize: 21,
                                  color: Colors.black.withOpacity(0.8),
                                  fontFamily: 'Ragazzi ExB',
                                ),
                              ),
                              SizedBox(
                                width: 60,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    quantity--;
                                  });
                                },
                                child: DottedBorder(
                                  strokeWidth: 2,
                                  dashPattern: [4, 3],
                                  radius: Radius.circular(14),
                                  borderType: BorderType.Circle,
                                  color: Color(0xffFCAE13),
                                  child: Icon(
                                    Icons.remove,
                                    size: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Text(
                                quantity.toString(),
                                style: TextStyle(
                                  fontFamily: 'GoogleSans Bld',
                                  fontSize: 23,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    quantity++;
                                  });
                                },
                                child: DottedBorder(
                                  strokeWidth: 2,
                                  dashPattern: [4, 3],
                                  radius: Radius.circular(14),
                                  borderType: BorderType.Circle,
                                  color: Color(0xffFCAE13),
                                  child: Icon(
                                    Icons.add,
                                    size: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //toppings
                        Container(
                          padding: EdgeInsets.only(left: 26),
                          alignment: Alignment.topLeft,
                          child: Text(
                            'TOPPINGS',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'GoogleSans Bld',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ToppingsCard(
                              activate: true,
                              toppingName: 'Nuts',
                              value: _checkedNuts,
                              onChanged: (bool value) {
                                setState(() {
                                  _checkedNuts = value;
                                  if (_checkedNuts == true) {
                                    selectedTopping.add('Nuts');
                                  } else {
                                    selectedTopping.remove('Nuts');
                                  }
                                });
                              },
                            ),
                            ToppingsCard(
                              activate: true,
                              toppingName: 'Sprinkles',
                              value: _checkedSprinkles,
                              onChanged: (bool value) {
                                setState(() {
                                  _checkedSprinkles = value;
                                  if (_checkedSprinkles == true) {
                                    selectedTopping.add('Sprinkles');
                                  } else {
                                    selectedTopping.remove('Sprinkles');
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ToppingsCard(
                              activate: true,
                              toppingName: 'Choco-chips',
                              value: _checkedChocoChips,
                              onChanged: (bool value) {
                                setState(() {
                                  _checkedChocoChips = value;
                                  if (_checkedChocoChips == true) {
                                    selectedTopping.add('Choco-chips');
                                  } else {
                                    selectedTopping.remove('Choco-chips');
                                  }
                                });
                              },
                            ),
                            ToppingsCard(
                              activate:
                                  selectedServingType == 'Bar' ? false : true,
                              toppingName: 'Cream stick',
                              value: _checkedCreamStick,
                              onChanged: (bool value) {
                                setState(() {
                                  _checkedCreamStick = value;
                                  if (_checkedCreamStick == true) {
                                    selectedTopping.add('Cream stick');
                                  } else {
                                    selectedTopping.remove('Cream stick');
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ToppingsCard(
                              activate: true,
                              toppingName: 'Brownie',
                              value: _checkedBrownie,
                              onChanged: (bool value) {
                                setState(() {
                                  _checkedBrownie = value;
                                  if (_checkedBrownie == true) {
                                    selectedTopping.add('Brownie');
                                  } else {
                                    selectedTopping.remove('Brownie');
                                  }
                                });
                              },
                            ),
                            ToppingsCard(
                              activate:
                                  selectedServingType == 'Cone' ? false : true,
                              toppingName: 'Gems',
                              value: _checkedGems,
                              onChanged: (bool value) {
                                setState(() {
                                  _checkedGems = value;
                                  if (_checkedGems == true) {
                                    selectedTopping.add('Gems');
                                  } else {
                                    selectedTopping.remove('Gems');
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ToppingsCard(
                              activate: selectedServingType == 'Bar' ||
                                      selectedServingType == 'Cone'
                                  ? false
                                  : true,
                              toppingName: 'Dry fruits',
                              value: _checkedDryFruits,
                              onChanged: (bool value) {
                                setState(() {
                                  _checkedDryFruits = value;
                                  if (_checkedDryFruits == true) {
                                    selectedTopping.add('Dry fruits');
                                  } else {
                                    selectedTopping.remove('Dry fruits');
                                  }
                                });
                              },
                            ),
                            ToppingsCard(
                              activate:
                                  selectedServingType == 'Bar' ? false : true,
                              toppingName: 'Cherry',
                              value: _checkedCherry,
                              onChanged: (bool value) {
                                setState(() {
                                  _checkedCherry = value;
                                  if (_checkedCherry == true) {
                                    selectedTopping.add('Cherry');
                                  } else {
                                    selectedTopping.remove('Cherry');
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        //Syrup
                        Container(
                          padding: EdgeInsets.only(left: 26),
                          alignment: Alignment.topLeft,
                          child: Text(
                            'SYRUP',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'GoogleSans Bld',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Column(
                          children: [
                            SyrupCard(
                              syrupText: 'Hot Fudge',
                              value: 'Hot Fudge',
                              groupValue: selectedSyrupValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedSyrupValue = value;
                                });
                              },
                            ),
                            SyrupCard(
                              syrupText: 'Chocolate Syrup',
                              value: 'Chocolate Syrup',
                              groupValue: selectedSyrupValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedSyrupValue = value;
                                });
                              },
                            ),
                            SyrupCard(
                              syrupText: 'Caramel',
                              value: 'Caramel',
                              groupValue: selectedSyrupValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedSyrupValue = value;
                                });
                              },
                            ),
                            SyrupCard(
                              syrupText: 'Strawberry Syrup',
                              value: 'Strawberry Syrup',
                              groupValue: selectedSyrupValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedSyrupValue = value;
                                });
                              },
                            ),
                            SyrupCard(
                              syrupText: 'Honey',
                              value: 'Honey',
                              groupValue: selectedSyrupValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedSyrupValue = value;
                                });
                              },
                            ),
                            SyrupCard(
                              syrupText: 'Melted Peanut Butter',
                              value: 'Melted Peanut Butter',
                              groupValue: selectedSyrupValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedSyrupValue = value;
                                });
                              },
                            ),
                          ],
                        ),
                        //place order
                        SizedBox(
                          height: 35,
                        ),
                        GestureDetector(
                          onTap: () async {
                            var time = DateTime.now().toString() ;

                            _firestore.collection('ibaco').add({
                              'Intensity' :  selectedIntensity ,
                              'Quantity' : quantity,
                              'Serving_Type' : selectedServingType,
                              'Syrup' : selectedSyrupValue ,
                              'Toppings' : selectedTopping,
                              'Total Cost' : '\$${cost * quantity}',
                              'User' : '$email',
                              'Variation' : 'Matcha $selectedVariation' ,
                              'date_time' : time ,
                            });
                          },
                          child: Container(
                            child: Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 4, top: 4),
                                  height: 60,
                                  width: 268,
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
                                      Radius.circular(16),
                                    ),
                                  ),
                                ),
                                DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: Radius.circular(16),
                                  strokeWidth: 1,
                                  dashPattern: [5, 2],
                                  color: Color(0xff4A3500),
                                  child: Container(
                                    height: 56,
                                    width: 264,
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
              ],
            ),
            // Button Home
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SizedBox(),
                    flex: 92,
                  ),
                  Expanded(
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyApp()));
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyApp()), (route) => false);
                        },
                        child: Image.asset(
                            'assests/ice_cream/button_home/button_home.png'),
                      ),
                    ),
                    flex: 8,
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

class SyrupCard extends StatelessWidget {
  final String syrupText;
  final String value;
  final String groupValue;
  final Function onChanged;

  SyrupCard(
      {@required this.syrupText,
      @required this.value,
      @required this.groupValue,
      @required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      width: 300,
      child: Center(
        child: RadioListTile(
          activeColor: Color(0xffF8AD2C),
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          title: Text(
            syrupText,
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Ragazzi ExB',
              color: Colors.black.withOpacity(0.8),
            ),
          ),
        ),
      ),
    );
  }
}

class ToppingsCard extends StatelessWidget {
  final String toppingName;
  final bool value;
  final Function(bool) onChanged;
  final bool activate;

  ToppingsCard(
      {@required this.toppingName,
      @required this.value,
      @required this.onChanged,
      @required this.activate});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 60,
      width: 200,
      child: CheckboxListTile(
        checkColor: Color(0xffF8AD2C),
        activeColor: Colors.transparent,
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(
          toppingName,
          style: TextStyle(
            decoration: activate == true
                ? TextDecoration.none
                : TextDecoration.lineThrough,
            fontSize: 18,
            fontFamily: 'Ragazzi ExB',
            color: activate == true
                ? Colors.black.withOpacity(0.8)
                : Colors.black.withOpacity(0.22),
          ),
        ),
        value: value,
        onChanged: activate == true ? onChanged : null,
      ),
    );
  }
}

class ServingCard extends StatelessWidget {
  final String iceText;
  final Widget backgroundImage;
  final Color borderColor;
  final Function onTap;

  ServingCard({
    @required this.iceText,
    @required this.backgroundImage,
    @required this.borderColor,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Stack(
          children: [
            Container(
              height: 103,
              width: 105,
              child: backgroundImage,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                border: Border.all(
                  color: borderColor,
                  width: 5,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 45),
              height: 103,
              width: 105,
              child: Center(
                child: Text(
                  iceText,
                  style: TextStyle(
                    fontFamily: 'Ragazzi ExB',
                    fontSize: 28,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VariationsCard extends StatelessWidget {
  final String mainText;
  final String subText;
  final List<Widget> imageChildren;
  final Color containerColor;
  final Color borderColor;
  final Function onTap;

  VariationsCard({
    @required this.mainText,
    @required this.subText,
    @required this.imageChildren,
    @required this.borderColor,
    @required this.containerColor,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: DottedBorder(
          dashPattern: [8, 8],
          borderType: BorderType.RRect,
          radius: Radius.circular(13),
          strokeWidth: 2,
          color: borderColor,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(13),
            child: Container(
              padding: EdgeInsets.only(left: 13, top: 14),
              height: 114,
              width: 135,
              color: containerColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: imageChildren,
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Text(
                    mainText,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black.withOpacity(0.8),
                      fontFamily: 'Ragazzi ExB',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    subText,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.black.withOpacity(0.48),
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
