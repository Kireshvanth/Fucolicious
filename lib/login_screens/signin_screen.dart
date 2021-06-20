import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:git_sem_custom_food/login_screens/signup_screen.dart';
import 'package:git_sem_custom_food/main.dart';

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

class SignInScreen extends StatefulWidget {

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final _auth = FirebaseAuth.instance;
  String email ;
  String password ;



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
                  flex: 15,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 15,
                  child:  Container(
                    width: double.infinity,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Image.asset('assests/login_screens/Happy_meal_time/Happy_meal_time.png'),
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
          Container(
            child: SafeArea(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.91),
                    borderRadius: BorderRadius.circular(40) ,

                  ),

                  height: screenHeight/1.5,
                  width: screenWidth/1.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 18,
                        child: Container(
                          padding: EdgeInsets.only(top: 35 ,left: 29),
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [
                              Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold ,
                                  fontFamily: 'GoogleSans' ,
                                ),
                              ),
                              Image.asset('assests/login_screens/underline_path/Underline_Path.png'),
                            ],
                          ),
                        ),
                      ),
                      //login to ur account
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: EdgeInsets.only(left: 45),
                          child: Text(
                            'Login to your account',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.24),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: SizedBox(),
                      ),
                      //email textfield
                      Expanded(
                        flex: 10,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 39),
                          child: TextField(
                            onChanged: (value){
                              email = value ;
                            },
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'GoogleSans',
                            ),
                            decoration: kTextFieldDecoration.copyWith(hintText: 'Email'),

                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: SizedBox(),
                      ),
                      //password textstyle
                      Expanded(
                        flex: 10,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 39),
                          child: TextField(
                            onChanged: (value){
                              password = value ;
                            },
                            obscureText: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'GoogleSans',
                            ),
                            decoration: kTextFieldDecoration.copyWith(hintText: 'Password'),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: SizedBox(),
                      ),
                      //google sign in
                      Expanded(
                        flex: 10,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 39),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assests/login_screens/Google_G_Logo/Google_G_Logo.png'),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Sign In with Google',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'GoogleSans' ,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xff7B0000),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Color(0xff333333),
                              width: 2.0,
                            ),

                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: SizedBox(),
                      ),
                      //signin box
                      Expanded(
                        flex: 10,
                        child: Center(
                          child: GestureDetector(
                            onTap: () async{
                              try {
                                final user = await _auth.signInWithEmailAndPassword(
                                    email: email, password: password);

                                if (user != null) {
                                  Navigator.push(context,MaterialPageRoute(builder:(context)=> MyApp()));
                                }
                              }
                              catch(e){
                                print(e);
                              }
                            },
                            child: Container(
                              height: 42,
                              width: 105,
                              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 23),
                              child: Center(
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                    fontFamily: 'GoogleSans',
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: SizedBox(),
                      ),
                      //dont have an account
                      Expanded(
                        flex: 4,
                        child: Center(
                          child: Text(
                            'Don\'t have an account',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.24),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      //sign up box
                      Expanded(
                        flex: 10,
                        child: Center(
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context,MaterialPageRoute(builder:(context)=> SignUpScreen()));
                            },
                            child: Container(
                              height: 40,
                              width: 105,
                              child: Center(
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontFamily: 'GoogleSans',
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Color(0xff333333),
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: SizedBox(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

