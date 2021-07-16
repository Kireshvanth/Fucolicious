import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screens/welcome_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

final _auth = FirebaseAuth.instance;

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

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
                padding: EdgeInsets.only(left: 60),
                child: Column(
                  children: [
                    Expanded(
                      flex: 15,
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: 45,
                      child: Image.asset('assests/home/Fucolicious_Logo/Fucolicious_Logo.png'),
                    ),
                    Expanded(
                      flex: 20,
                      child: Image.asset('assests/home/Voice_Assistant/Voice_Assistant.png'),
                    ),
                    Expanded(
                      flex: 10,
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        child: Image.asset('assests/home/Scroll_Group/Scroll_Group.png'),
                      ),
                    ),
                  ],
                ),
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
                                  Image.asset('assests/home/BG_watermark_1/BG_Watermark1.png'),
                                  GestureDetector(
                                    onTap: (){
                                      signOut() ;
                                    },
                                    child: Image.asset('assests/deals_of_the_day/sign_out/Sign_Out_Icon.png'),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 35,left: 30),
                                  child: Text(
                                    'Home',
                                    style: TextStyle(
                                      fontFamily: 'Google Sans Bld',
                                      fontSize: 29,
                                      color: Colors.white,

                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 30),
                                  child: Column(
                                    children: [
                                      Text(
                                        'CHOOSE &\nCUSTOMIZE',
                                        style: TextStyle(
                                          fontFamily: 'Google Sans Bld',
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        'Your Favourite\nFood',
                                        style: TextStyle(
                                          fontFamily: 'Google Sans Bld',
                                          fontSize: 12,
                                          color: Colors.white.withOpacity(0.5),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 85,
                      child: SizedBox(),
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


