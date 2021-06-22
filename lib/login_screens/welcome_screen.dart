import 'package:flutter/material.dart';
import 'package:git_sem_custom_food/login_screens/signin_screen.dart';
import 'package:git_sem_custom_food/login_screens/signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

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
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Image(
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          alignment: Alignment.topLeft,
                          image: AssetImage(
                              'assests/login_screens/GetStarted_BG/GetStarted_BG_Image.png'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 60.0),
                        child: Image(
                          image: AssetImage(
                              "assests/login_screens/ImageToBlackFilter/ImageToBlackFilter.png"),
                          fit: BoxFit.fitWidth,
                          width: double.infinity,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 30,
                  child: Padding(
                    padding: EdgeInsets.only(left: 48, right: 36),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Get Started',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            color: Colors.white.withOpacity(0.3),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Customize your\nown Desserts\nand Beverages',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SignInScreen()));
                                },
                                child: Container(
                                  padding: EdgeInsets.only(left: 2),
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(
                                      fontFamily: 'GoogleSans',
                                      fontSize: 14,
                                      color: Colors.white.withOpacity(.51),
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SignUpScreen()));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Image(
                                          image: AssetImage(
                                              "assests/login_screens/Background/Background.png"),
                                        ),
                                      ),
                                      Image(
                                        image: AssetImage(
                                            "assests/login_screens/Dashed_Rectagle/Dashed_Rectagle.png"),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 23, top: 11),
                                        child: Text(
                                          'Sign Up',
                                          style: TextStyle(
                                            fontFamily: 'GoogleSans',
                                            fontSize: 11,
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
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
                      ],
                    ),
                  ),
                ),
                // Expanded(
                //   flex: 15,
                //   child: Padding(
                //     padding: EdgeInsets.only(left: 48),
                //     child: Text(
                //       'Customize your\nown Desserts\nand Beverages',
                //       textAlign: TextAlign.left,
                //       style: TextStyle(
                //         fontFamily: 'GoogleSans',
                //         color: Colors.white,
                //         fontSize: 28,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   ),
                // ),
                // Expanded(
                //   flex: 11,
                //   child: Container(
                //     padding: EdgeInsets.symmetric(horizontal: 50),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         GestureDetector(
                //           onTap: () {
                //             Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                     builder: (context) => SignInScreen()));
                //           },
                //           child: Container(
                //             child: Text(
                //               'Sign In',
                //               style: TextStyle(
                //                 fontFamily: 'GoogleSans',
                //                 fontSize: 18,
                //                 color: Colors.white.withOpacity(.51),
                //                 fontWeight: FontWeight.bold,
                //               ),
                //             ),
                //           ),
                //         ),
                //         GestureDetector(
                //           onTap: () {
                //             Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                     builder: (context) => SignUpScreen()));
                //           },
                //           child: Container(
                //             padding: EdgeInsets.all(10),
                //             child: Text(
                //               'Sign Up',
                //               style: TextStyle(
                //                 fontFamily: 'GoogleSans',
                //                 fontSize: 18,
                //                 color: Colors.black,
                //                 fontWeight: FontWeight.bold,
                //               ),
                //             ),
                //             decoration: BoxDecoration(
                //               boxShadow: [
                //                 BoxShadow(
                //                   color: Color(0xffFCAE13).withOpacity(0.5),
                //                   offset: Offset(
                //                       7, 7), // changes position of shadow
                //                 ),
                //               ],
                //               color: Color(0xffFCAE13),
                //               borderRadius: BorderRadius.circular(15),
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          //fucolicious text
          Container(
            padding: EdgeInsets.only(top: 35),
            alignment: Alignment.topRight,
            child: Image(
              image: AssetImage(
                  "assests/login_screens/Fucolicious/Fucolicious.png"),
              fit: BoxFit.cover,
              width: 18.5,
              height: 274,
            ),
          ),
        ],
      ),
    );
  }
}
