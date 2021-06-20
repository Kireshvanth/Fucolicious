import 'package:flutter/material.dart';
import 'package:git_sem_custom_food/login_screens/signin_screen.dart';
import 'package:git_sem_custom_food/login_screens/signup_screen.dart';

class WelcomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height ;
    double screenWidth = MediaQuery.of(context).size.width ;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          //image of food , other texts- signin and signup
          Container(
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 70,
                  child: Container(
                    width: double.infinity,
                    height: screenHeight/7,
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Image.asset('assests/login_screens/GetStarted_BG/GetStarted_BG_Image.png'),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsets.only(left: 48),
                    child: Text(
                      'Get Started',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'GoogleSans',
                        color: Colors.white.withOpacity(0.3),
                        fontSize: 20 ,
                        fontWeight: FontWeight.bold ,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 15,
                  child: Padding(
                    padding: EdgeInsets.only(left: 48),
                    child: Text(
                      'Customize your\nown Desserts\nand Beverages',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'GoogleSans',
                        color: Colors.white,
                        fontSize: 28 ,
                        fontWeight: FontWeight.bold ,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 11,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context,MaterialPageRoute(builder:(context)=> SignInScreen()));
                          },
                          child: Container(
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                fontFamily: 'GoogleSans',
                                fontSize: 18,
                                color: Colors.white.withOpacity(.51),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context,MaterialPageRoute(builder:(context)=> SignUpScreen()));
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                fontFamily: 'GoogleSans',
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xffFCAE13).withOpacity(0.5),
                                  offset: Offset(7, 7), // changes position of shadow
                                ),
                              ],
                              color: Color(0xffFCAE13),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          //fucolicious text
          Container(
            padding: EdgeInsets.only(top: 40),
            alignment: Alignment.centerRight,
            child: RotatedBox(
              quarterTurns: -1,
              child: Text(
                'FUCOLICIOUS',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 20,
                  fontFamily: 'GoogleSans',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


