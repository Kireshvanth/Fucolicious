import 'package:flutter/material.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:git_sem_custom_food/main.dart';
import 'package:git_sem_custom_food/screens/coffee/coffee_customisation.dart';


class CoffeeDashBoard extends StatefulWidget {
  @override
  _CoffeeDashBoardState createState() => _CoffeeDashBoardState();
}

class _CoffeeDashBoardState extends State<CoffeeDashBoard> {
  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height ;
    double screenWidth = MediaQuery.of(context).size.width ;

    return Scaffold(
      backgroundColor: Color(0xffFFFDF9),
      body: Stack(
        children: [
          //Starbucks Logo Watermark
          Container(
            child: Column(
              children: [
                Expanded(
                  flex: 25,
                  child: Center(
                    child: Image.asset('assests/categories_screen/Starbucks_Logo/Starbucks_Logo.png'),
                  ),
                ),
                Expanded(
                  flex: 75,
                  child: SizedBox(),
                ),
              ],
            ),
          ),
          //Other Components
          SafeArea(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 15,right: 10),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back,
                            ),
                          ),
                          Image.asset('assests/coffee/Cart_Icon/Cart_Icon.png'),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                    ),
                    flex: 8,
                  ),
                  Expanded(
                    flex: 6,
                    child: BorderedText(
                      strokeWidth: 5.0,
                      child: Text(
                        'STARBUCKS',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 37.0,
                          fontFamily: 'PrequelDemo',
                          fontStyle: FontStyle.italic,
                          shadows: [
                            Shadow(
                              offset: Offset(4.0, 0),
                              color: Colors.black,
                            ),
                          ],


                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'Featured',
                        style: TextStyle(
                          color: Color(0xff898886),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'GoogleSans',
                        ),
                      ),
                    ),
                    flex: 2,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'Cold Drinks',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'GoogleSans',
                        ),
                      ),
                    ),
                    flex: 4,
                  ),
                  Expanded(
                    flex: 2,
                    child: SizedBox(),
                  ),
                  //cards
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        UsableCard(
                          image: CircleAvatar(
                            child: Image.asset('assests/coffee/Coffee1/Coffee1.png'),
                            backgroundColor: Color(0xffF7F5EA),
                            radius: 65,
                          ),
                          cost: '\$10',
                          itemName: 'Caffé Latte',
                        ),
                        UsableCard(
                          image: CircleAvatar(
                            child: Image.asset('assests/coffee/Coffee1/Coffee1.png'),
                            backgroundColor: Color(0xffF7F5EA),
                            radius: 65,
                          ),
                          cost: '\$10',
                          itemName: 'Overnight\n Oatmeal',
                        ),
                        UsableCard(
                          image: CircleAvatar(
                            child: Image.asset('assests/coffee/Coffee1/Coffee1.png'),
                            backgroundColor: Color(0xffF7F5EA),
                            radius: 65,
                          ),
                          cost: '\$20',
                          itemName: 'Caffé Latte',
                        ),
                        UsableCard(
                          image: CircleAvatar(
                            child: Image.asset('assests/coffee/Coffee1/Coffee1.png'),
                            backgroundColor: Color(0xffF7F5EA),
                            radius: 65,
                          ),
                          cost: '\$30',
                          itemName: 'Caffé Latte',
                        ),
                        UsableCard(
                          image: CircleAvatar(
                            child: Image.asset('assests/coffee/Coffee1/Coffee1.png'),
                            backgroundColor: Color(0xffF7F5EA),
                            radius: 65,
                          ),
                          cost: '\$40',
                          itemName: 'Caffé Latte',
                        ),
                      ],
                    ),
                    flex: 30,
                  ),
                  Expanded(
                    child: SizedBox(),
                    flex: 6,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'Featured',
                        style: TextStyle(
                          color: Color(0xff898886),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'GoogleSans',
                        ),
                      ),
                    ),
                    flex: 2,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'Hot Drinks',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'GoogleSans',
                        ),
                      ),
                    ),
                    flex: 4,
                  ),
                  //cards
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        UsableCard(
                          image: CircleAvatar(
                            child: Image.asset('assests/coffee/Coffee1/Coffee1.png'),
                            backgroundColor: Color(0xffF8F8D9),
                            radius: 65,
                          ),
                          cost: '\$10',
                          itemName: 'Caffé Latte',
                        ),
                        UsableCard(
                          image: CircleAvatar(
                            child: Image.asset('assests/coffee/Coffee1/Coffee1.png'),
                            backgroundColor: Color(0xffF8F8D9),
                            radius: 65,
                          ),
                          cost: '\$10',
                          itemName: 'Overnight\n Oatmeal',
                        ),
                        UsableCard(
                          image: CircleAvatar(
                            child: Image.asset('assests/coffee/Coffee1/Coffee1.png'),
                            backgroundColor: Color(0xffF8F8D9),
                            radius: 65,
                          ),
                          cost: '\$20',
                          itemName: 'Caffé Latte',
                        ),
                        UsableCard(
                          image: CircleAvatar(
                            child: Image.asset('assests/coffee/Coffee1/Coffee1.png'),
                            backgroundColor: Color(0xffF8F8D9),
                            radius: 65,
                          ),
                          cost: '\$30',
                          itemName: 'Caffé Latte',
                        ),
                        UsableCard(
                          image: CircleAvatar(
                            child: Image.asset('assests/coffee/Coffee1/Coffee1.png'),
                            backgroundColor: Color(0xffF8F8D9),
                            radius: 65,
                          ),
                          cost: '\$40',
                          itemName: 'Caffé Latte',
                        ),
                      ],
                    ),
                    flex: 30,
                  ),
                  Expanded(
                    child: SizedBox(),
                    flex: 8,
                  ),
                ],
              ),
            ),
          ),
          //Button Home
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
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyApp()), (route) => false);
                      },
                      child: Image.asset('assests/coffee/Button_Home/button_home.png'),
                    ),
                  ),
                  flex: 8,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UsableCard extends StatelessWidget {

  final Widget image ;
  final String cost ;
  final String itemName ;

  UsableCard({@required this.image,@required this.cost , @required this.itemName});

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height ;
    double screenWidth = MediaQuery.of(context).size.width ;

    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder:(context)=> CoffeeCustomisation()));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: Color(0xffFFFDF9),
            border: Border.all(
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(40.0),
          ),
          width: screenWidth/3,
          child: Column(
            children: [
              Expanded(
                flex: 60,
                child: image,
              ),
              Expanded(
                flex: 20,
                child: Stack(
                  children: [
                    Center(
                      child: Image.asset('assests/coffee/Drawn_Path_Price/Drawn_Path_Price.png'),
                    ),
                    Center(
                      child: Text(
                        cost,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 20,
                child: Text(
                  itemName,
                  style: TextStyle(
                    fontFamily: 'GoogleSans',
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



