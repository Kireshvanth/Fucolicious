import 'package:flutter/material.dart';
import 'package:git_sem_custom_food/screens/coffee/coffee_customisation.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screens/welcome_screen.dart';

final _auth = FirebaseAuth.instance;

class DealsOfTheDayScreen extends StatefulWidget {
  @override
  _DealsOfTheDayScreenState createState() => _DealsOfTheDayScreenState();
}

class _DealsOfTheDayScreenState extends State<DealsOfTheDayScreen> {
  @override
  Widget build(BuildContext context) {

    final PageController controllerdeals = PageController(initialPage: 1);

    Future<void> signOut() async {
      try{
        if(_auth != null){
          await _auth.signOut();
        }
        if(await GoogleSignIn().isSignedIn() == true){
          await GoogleSignIn().signOut() ;
        }
        Navigator.push(context,MaterialPageRoute(builder:(context)=> WelcomeScreen()));

      }
      catch(e){
        print(e);
      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Container(
                child: Column(
                  children: [
                    Expanded(
                      flex: 15,
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: 55,
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        height: 20,
                        width: double.maxFinite,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Image.asset('assests/deals_of_the_day/lines/Lines.png'),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: SmoothPageIndicator(
                          controller: controllerdeals,
                          count: 3,
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
                      flex: 6,
                      child: Center(
                        child: Text(
                          'Scroll to Discover',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 12,
                      child: SizedBox(),
                    ),
                  ],
                ),
              ),
              PageView(
                controller: controllerdeals,
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Expanded(
                          flex:15 ,
                          child: SizedBox(),
                        ),
                        Expanded(
                          flex:55 ,
                          child: Container(
                            child: Image.asset('assests/deals_of_the_day/card/Card.png'),
                            padding: EdgeInsets.only(left: 40,right: 20),
                          ),
                        ),
                        Expanded(
                          flex:30 ,
                          child: SizedBox(),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Expanded(
                          flex:15 ,
                          child: SizedBox(),
                        ),
                        Expanded(
                          flex:55 ,
                          child: Container(
                            child: Image.asset('assests/deals_of_the_day/card/Card.png'),
                            padding: EdgeInsets.only(left: 40,right: 20),
                          ),
                        ),
                        Expanded(
                          flex:30 ,
                          child: SizedBox(),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Expanded(
                          flex:15 ,
                          child: SizedBox(),
                        ),
                        Expanded(
                          flex:55 ,
                          child: Container(
                            child: Image.asset('assests/deals_of_the_day/card/Card.png'),
                            padding: EdgeInsets.only(left: 40,right: 20),
                          ),
                        ),
                        Expanded(
                          flex:30 ,
                          child: SizedBox(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                child: Column(
                  children: [
                    Expanded(
                      flex: 15,
                      child: Container(
                        child: Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                                children: [
                                  Image.asset('assests/deals_of_the_day/bg_watermark/BG_Watermark.png'),
                                  GestureDetector(
                                    onTap: (){
                                      signOut() ;
                                    },
                                    child: Image.asset('assests/deals_of_the_day/sign_out/Sign_Out_Icon.png'),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 40,top: 35),
                              child: Text(
                                'Deals of the Day',
                                style: TextStyle(
                                  fontFamily: 'Google Sans Bld',
                                  fontSize: 29,
                                  color: Colors.white,

                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 73,
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: 12,
                      child: Center(
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context,MaterialPageRoute(builder:(context)=> CoffeeCustomisation()));
                          },
                          child: Image.asset('assests/deals_of_the_day/Customize_Button/Customize_Button.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
