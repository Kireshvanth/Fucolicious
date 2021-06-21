import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:git_sem_custom_food/login_screens/welcome_screen.dart';
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Home"),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: (){
                signOut() ;
              },
              child: Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}


