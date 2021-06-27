import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup_screen.dart';
import 'package:git_sem_custom_food/main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

final kTextFieldDecoration = InputDecoration(
  hintText: 'Enter the hintText',
  hintStyle: TextStyle(
    color: Colors.white.withOpacity(0.5),
    fontSize: 12,
    fontWeight: FontWeight.bold,
    fontFamily: 'GoogleSans',
  ),
  fillColor: Color(0xff151515),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(
      width: 1.0,
      color: Color(0xff333333),
    ),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(
      width: 2.0,
      color: Color(0xffFCAE13),
    ),
  ),
);

Future<UserCredential> signInWithGoogle() async {
  final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
  Fluttertoast.showToast(
    msg: "Signed In with Google",
    textColor: Colors.black,
    backgroundColor: Colors.white,
  );
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Stack(
          children: [
            //image of food , other texts- signin and signup
            Container(
              color: Colors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    flex: 15,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 15,
                    child: Container(
                      width: double.infinity,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Image.asset(
                            'assests/login_screens/Happy_meal_time/Happy_meal_time.png'),
                      ),
                    ),
                  ),
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
            //Fuctinality Container
            Column(
              children: [
                Expanded(
                  flex: 21,
                  child: Container(),
                ),
                //Black BG Blurred Container with all inside elements
                Expanded(
                  flex: 66,
                  child: Container(
                    width: 320,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(36),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(36),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                        child: Stack(
                          children: [
                            Container(
                              width: 320,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.75),
                                borderRadius: BorderRadius.circular(36),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'Sign In',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'GoogleSans',
                                    ),
                                  ),
                                  Image.asset(
                                      'assests/login_screens/underline_path/Underline_Path.png'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        //
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // SafeArea(
            //   child: Center(
            //     child: Container(
            //       decoration: BoxDecoration(
            //         color: Colors.transparent,
            //         borderRadius: BorderRadius.circular(40),
            //       ),
            //       height: screenHeight / 1.5,
            //       width: screenWidth / 1.2,
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.stretch,
            //         children: [
            //           Expanded(
            //             flex: 18,
            //             child: Container(
            //               padding: EdgeInsets.only(top: 35, left: 29),
            //               alignment: Alignment.topLeft,
            //               child: Column(
            //                 children: [
            //                   Text(
            //                     'Sign In',
            //                     style: TextStyle(
            //                       color: Colors.white,
            //                       fontSize: 30,
            //                       fontWeight: FontWeight.bold,
            //                       fontFamily: 'GoogleSans',
            //                     ),
            //                   ),
            //                   Image.asset(
            //                       'assests/login_screens/underline_path/Underline_Path.png'),
            //                 ],
            //               ),
            //             ),
            //           ),
            //           //login to ur account
            //           Expanded(
            //             flex: 4,
            //             child: Padding(
            //               padding: EdgeInsets.only(left: 45),
            //               child: Text(
            //                 'Login to your account',
            //                 style: TextStyle(
            //                   color: Colors.white.withOpacity(0.24),
            //                   fontSize: 15,
            //                 ),
            //               ),
            //             ),
            //           ),
            //           Expanded(
            //             flex: 3,
            //             child: SizedBox(),
            //           ),
            //           //email textfield
            //           Expanded(
            //             flex: 10,
            //             child: Container(
            //               padding: EdgeInsets.symmetric(horizontal: 39),
            //               child: TextField(
            //                 onChanged: (value) {
            //                   email = value;
            //                 },
            //                 keyboardType: TextInputType.emailAddress,
            //                 textAlign: TextAlign.center,
            //                 style: TextStyle(
            //                   color: Colors.white,
            //                   fontFamily: 'GoogleSans',
            //                 ),
            //                 decoration: kTextFieldDecoration.copyWith(
            //                     hintText: 'Email'),
            //               ),
            //             ),
            //           ),
            //           Expanded(
            //             flex: 3,
            //             child: SizedBox(),
            //           ),
            //           //password textstyle
            //           Expanded(
            //             flex: 10,
            //             child: Container(
            //               padding: EdgeInsets.symmetric(horizontal: 39),
            //               child: TextField(
            //                 onChanged: (value) {
            //                   password = value;
            //                 },
            //                 obscureText: true,
            //                 textAlign: TextAlign.center,
            //                 style: TextStyle(
            //                   color: Colors.white,
            //                   fontFamily: 'GoogleSans',
            //                 ),
            //                 decoration: kTextFieldDecoration.copyWith(
            //                     hintText: 'Password'),
            //               ),
            //             ),
            //           ),
            //           Expanded(
            //             flex: 3,
            //             child: SizedBox(),
            //           ),
            //           //google sign in
            //           Expanded(
            //             flex: 10,
            //             child: GestureDetector(
            //               onTap: () async {
            //                 setState(() {
            //                   showSpinner = true;
            //                 });
            //                 try {
            //                   final user = await signInWithGoogle();
            //                   if (user != null) {
            //                     if (await GoogleSignIn().isSignedIn() == true) {
            //                       Navigator.push(
            //                           context,
            //                           MaterialPageRoute(
            //                               builder: (context) => MyApp()));
            //                     }
            //                   }
            //                   setState(() {
            //                     showSpinner = false;
            //                   });
            //                 } catch (e) {
            //                   print(e);
            //                 }
            //                 setState(() {
            //                   showSpinner = false;
            //                 });
            //               },
            //               child: Container(
            //                 margin: EdgeInsets.symmetric(horizontal: 39),
            //                 child: Center(
            //                   child: Row(
            //                     mainAxisAlignment: MainAxisAlignment.center,
            //                     children: [
            //                       Image.asset(
            //                           'assests/login_screens/Google_G_Logo/Google_G_Logo.png'),
            //                       SizedBox(
            //                         width: 20,
            //                       ),
            //                       Text(
            //                         'Sign In with Google',
            //                         style: TextStyle(
            //                           color: Colors.white,
            //                           fontSize: 15,
            //                           fontWeight: FontWeight.bold,
            //                           fontFamily: 'GoogleSans',
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //                 decoration: BoxDecoration(
            //                   color: Color(0xff7B0000),
            //                   borderRadius: BorderRadius.circular(20),
            //                   border: Border.all(
            //                     color: Color(0xff333333),
            //                     width: 2.0,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ),
            //           Expanded(
            //             flex: 4,
            //             child: SizedBox(),
            //           ),
            //           //signin box
            //           Expanded(
            //             flex: 10,
            //             child: Center(
            //               child: GestureDetector(
            //                 onTap: () async {
            //                   setState(() {
            //                     showSpinner = true;
            //                   });
            //                   try {
            //                     final user =
            //                         await _auth.signInWithEmailAndPassword(
            //                             email: email, password: password);

            //                     if (user != null) {
            //                       Navigator.push(
            //                           context,
            //                           MaterialPageRoute(
            //                               builder: (context) => MyApp()));
            //                     }
            //                     setState(() {
            //                       showSpinner = false;
            //                     });
            //                   } catch (e) {
            //                     print(e);
            //                   }
            //                   setState(() {
            //                     showSpinner = false;
            //                   });
            //                 },
            //                 child: Container(
            //                   height: 42,
            //                   width: 105,
            //                   padding: EdgeInsets.symmetric(
            //                       vertical: 10, horizontal: 23),
            //                   child: Center(
            //                     child: Text(
            //                       'Sign In',
            //                       style: TextStyle(
            //                         fontFamily: 'GoogleSans',
            //                         fontSize: 14,
            //                         color: Colors.black,
            //                         fontWeight: FontWeight.bold,
            //                       ),
            //                     ),
            //                   ),
            //                   decoration: BoxDecoration(
            //                     boxShadow: [
            //                       BoxShadow(
            //                         color: Color(0xffFCAE13).withOpacity(0.5),
            //                         offset: Offset(
            //                             7, 7), // changes position of shadow
            //                       ),
            //                     ],
            //                     color: Color(0xffFCAE13),
            //                     borderRadius: BorderRadius.circular(15),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ),
            //           Expanded(
            //             flex: 8,
            //             child: SizedBox(),
            //           ),
            //           //dont have an account
            //           Expanded(
            //             flex: 4,
            //             child: Center(
            //               child: Text(
            //                 'Don\'t have an account',
            //                 style: TextStyle(
            //                   color: Colors.white.withOpacity(0.24),
            //                   fontSize: 15,
            //                 ),
            //               ),
            //             ),
            //           ),
            //           //sign up box
            //           Expanded(
            //             flex: 10,
            //             child: Center(
            //               child: GestureDetector(
            //                 onTap: () {
            //                   Navigator.push(
            //                       context,
            //                       MaterialPageRoute(
            //                           builder: (context) => SignUpScreen()));
            //                 },
            //                 child: Container(
            //                   height: 40,
            //                   width: 105,
            //                   child: Center(
            //                     child: Text(
            //                       'Sign Up',
            //                       style: TextStyle(
            //                         fontFamily: 'GoogleSans',
            //                         fontSize: 15,
            //                         color: Colors.white,
            //                         fontWeight: FontWeight.bold,
            //                       ),
            //                     ),
            //                   ),
            //                   decoration: BoxDecoration(
            //                     color: Colors.black,
            //                     borderRadius: BorderRadius.circular(15),
            //                     border: Border.all(
            //                       color: Color(0xff333333),
            //                       width: 2.0,
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ),
            //           Expanded(
            //             flex: 3,
            //             child: SizedBox(),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
