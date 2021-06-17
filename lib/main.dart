import 'package:flutter/material.dart';
import 'package:git_sem_custom_food/screens/categories.dart';
import 'package:git_sem_custom_food/screens/dealsoftheday.dart';
import 'package:git_sem_custom_food/screens/home.dart';
import 'package:git_sem_custom_food/modules/sideNavBar.dart';
import 'package:git_sem_custom_food/login_screens/login_screen.dart';
import 'package:git_sem_custom_food/login_screens/welcome_screen.dart';

void main() {
  runApp(
    MaterialApp(
      home: WelcomeScreen(),
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
