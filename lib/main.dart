import 'package:flutter/material.dart';
import 'package:git_sem_custom_food/screens/categories.dart';
import 'package:git_sem_custom_food/screens/dealsoftheday.dart';
import 'package:git_sem_custom_food/screens/home.dart';
import 'package:git_sem_custom_food/screens/login_screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      home: FirebaseAuth.instance.currentUser == null ? WelcomeScreen() : MyApp(),
      title: "Custom Food",
      debugShowCheckedModeBanner: false,
    ),
  );
}

int _selectedIndex = 0;
final PageController controller = PageController(initialPage: 0);

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    _selectedIndex=0 ;
  }


  final _auth = FirebaseAuth.instance;
  User loggedInUser ;


  void getCurrentUser() async {
    await Firebase.initializeApp();
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    }
    catch(e){
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              onPageChanged: (value) => setState(() {
                _selectedIndex = controller.page.round();
              }),
              scrollDirection: Axis.vertical,
              controller: controller,
              children: [
                HomeScreen(),
                CategoriesScreen(),
                DealsOfTheDayScreen(),
              ],
            ),
            SideNavigationBar(),
          ],
        ),
      ),
    );
  }
}

class SideNavigationBar extends StatefulWidget {
  @override
  _SideNavigationBarState createState() => _SideNavigationBarState();
}

class _SideNavigationBarState extends State<SideNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 320,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
            color: Colors.black),
        height: 418,
        width: 45,
        child: NavigationRail(
          backgroundColor: Colors.transparent,
          groupAlignment: 0,
          selectedIconTheme: IconThemeData(color: Colors.white),
          unselectedIconTheme: IconThemeData(color: Colors.white),
          selectedIndex: _selectedIndex,
          onDestinationSelected: (int index) {
            setState(() {
              _selectedIndex = index;
              controller.animateToPage(_selectedIndex,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
            });
          },
          labelType: NavigationRailLabelType.selected,
          destinations: [
            NavigationRailDestination(
              icon: Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: RotatedBox(
                  quarterTurns: 135,
                  child: Text(
                    "HOME",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Comfortaa",
                      fontSize: 9,
                    ),
                  ),
                ),
              ),
              label: Image(
                image: AssetImage(
                    "assests/categories_screen/TabBar_Indicator/TabBar_Indicator.png"),
              ),
            ),
            NavigationRailDestination(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: RotatedBox(
                  quarterTurns: 135,
                  child: Text(
                    "Categories",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Comfortaa",
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              label: Image(
                image: AssetImage(
                    "assests/categories_screen/TabBar_Indicator/TabBar_Indicator.png"),
              ),
            ),
            NavigationRailDestination(
              icon: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: RotatedBox(
                  quarterTurns: 135,
                  child: Text(
                    "Deals of the Day",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Comfortaa",
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              label: Image(
                image: AssetImage(
                    "assests/categories_screen/TabBar_Indicator/TabBar_Indicator.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
