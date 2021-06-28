import 'package:flutter/material.dart';
import 'package:git_sem_custom_food/screens/burger/burger_customisation.dart';
import 'package:list_wheel_scroll_view_x/list_wheel_scroll_view_x.dart';
import 'package:git_sem_custom_food/main.dart';

class BurgerDashBoard extends StatefulWidget {
  @override
  _BurgerDashBoardState createState() => _BurgerDashBoardState();
}

class _BurgerDashBoardState extends State<BurgerDashBoard> {
  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height ;
    double screenWidth = MediaQuery.of(context).size.width ;

    ScrollController _controller1 ;
    ScrollController _controller2 ;

    return Scaffold(
      backgroundColor: Color(0xffFFFDF9),
      body: SafeArea(
        child: Stack(
          children: [
            //bg of all
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 20 ,
                    child: Container(
                      child: Image.asset(
                        'assests/burger/burger_dashboard/McDonald_BG_Image/McDonald_BG_Image.png',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      child: Image.asset(
                        'assests/burger/burger_dashboard/ImageToBGFilter/ImageToBGFilter.png',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 10 ,
                    child: Container(
                      child: Image.asset(
                        'assests/burger/burger_dashboard/bestseller_watermark/BESTSELLER_Watermark.png',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 27,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 8 ,
                    child: Container(
                      child: Image.asset(
                        'assests/burger/burger_dashboard/flame_grilled_watermark/FLAME_GRILLED_Watermark.png',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 15 ,
                    child: Container(
                      child: Image.asset(
                        'assests/burger/burger_dashboard/Fire_BG/Fire_BG.png',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),

                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Expanded(
                    flex: 20,
                    child: Center(
                      child: Image.asset('assests/burger/burger_dashboard/McDonald_Burger_Logo/McDonald_Burger_Logo.png'),
                    ),
                  ),
                  Expanded(
                    flex: 80,
                    child: SizedBox(),
                  ),
                ],
              ),
            ),
            //Other Components
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 8,
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
                          Image.asset('assests/burger/burger_dashboard/Cart_icon/Cart_Icon.png'),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 11,
                    child: SizedBox(),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'Featured',
                        style: TextStyle(
                          color: Color(0xff898886),
                          fontSize: 15,
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
                        'Most Popular',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'GoogleSans',
                        ),
                      ),
                    ),
                    flex: 5,
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  //cards
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder:(context)=> BurgerCustomisation()));
                      },
                      child: Hero(
                        tag: 'burger',
                        child: Container(
                          child: ListWheelScrollViewX(

                            controller: _controller1,
                            diameterRatio: 4,
                            itemExtent: 170,
                            useMagnifier: true,
                            magnification: 1.5,
                            scrollDirection: Axis.horizontal,
                            children: [
                              UsableCard(
                                image: Image.asset('assests/burger/burger_dashboard/rodeo_burger/rodeo_burger.png'),
                                cost: '\$10',
                                itemName: 'Rodeo Burger',
                                mustTry: true,
                              ),
                              UsableCard(
                                image: Image.asset('assests/burger/burger_dashboard/whooper/whooper.png'),
                                cost: '\$10',
                                itemName: 'Whooper',
                                mustTry: true,
                              ),
                              UsableCard(
                                image: Image.asset('assests/burger/burger_dashboard/rodeo_burger/rodeo_burger.png'),
                                cost: '\$10',
                                itemName: 'Rodeo Burger',
                              ),
                              UsableCard(
                                image: Image.asset('assests/burger/burger_dashboard/whooper/whooper.png'),
                                cost: '\$10',
                                itemName: 'Whooper',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    flex: 26,
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
                        'Flame Grilled',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'GoogleSans',
                        ),
                      ),
                    ),
                    flex: 5,
                  ),
                  //cards
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder:(context)=> BurgerCustomisation()));
                      },
                      child: Container(
                        child: ListWheelScrollViewX(
                          controller: _controller2,
                          itemExtent: 200,
                          useMagnifier: true,
                          magnification: 1.5,
                          scrollDirection: Axis.horizontal,
                          children: [
                            UsableCard(
                              image: Image.asset('assests/burger/burger_dashboard/whooper/whooper.png'),
                              cost: '\$10',
                              itemName: 'Whooper',
                              mustTry: true,
                            ),
                            UsableCard(
                              image: Image.asset('assests/burger/burger_dashboard/rodeo_burger/rodeo_burger.png'),
                              cost: '\$10',
                              itemName: 'Rodeo Burger',
                              mustTry: true,
                            ),
                            UsableCard(
                              image: Image.asset('assests/burger/burger_dashboard/rodeo_burger/rodeo_burger.png'),
                              cost: '\$20',
                              itemName: 'Rodeo Burger',
                            ),
                            UsableCard(
                              image: Image.asset('assests/burger/burger_dashboard/whooper/whooper.png'),
                              cost: '\$10',
                              itemName: 'Whooper',
                            ),
                          ],
                        ),
                      ),
                    ),
                    flex: 30,
                  ),
                  Expanded(
                    child: SizedBox(),
                    flex: 10,
                  ),
                ],
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
                        child: Image.asset('assests/burger/burger_dashboard/Button_Home/button-home.png'),
                      ),
                    ),
                    flex: 8,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UsableCard extends StatelessWidget {

  final Widget image ;
  final String cost ;
  final String itemName ;
  bool mustTry ;

  UsableCard({@required this.image,@required this.cost , @required this.itemName , this.mustTry });

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height ;
    double screenWidth = MediaQuery.of(context).size.width ;

    return Container(
      color: Colors.transparent,
      height: 180,
      width: 170,
      child: Column(
        children: [
          Expanded(
            flex: 50,
            child: Stack(
              children: [
                Container(
                  height: 110,
                  width: 170,
                  child: FittedBox(
                    child: image,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                mustTry==true
                    ? Padding(padding: EdgeInsets.only(left: 10 ,top: 20), child: Image.asset('assests/burger/burger_dashboard/must_try/must_try_image.png'),)
                    : Container(color: Colors.transparent,),
              ],
            ),
          ),
          Expanded(
            flex: 12,
            child: SizedBox(),
          ),
          Expanded(
            flex: 10,
            child: Center(
              child: Text(
                cost,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Center(
              child: Container(
                width: 40,
                height: 7,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Image.asset('assests/burger/burger_dashboard/Underline_Path/Underline_Path.png'),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: Text(
              itemName,
              style: TextStyle(
                fontFamily: 'GoogleSans',
                fontSize: 15,
              ),
            ),
          ),
          Expanded(
            flex: 13,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}