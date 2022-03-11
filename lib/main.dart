import 'games/ChooseGamePage.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color backgroundColor = const Color.fromRGBO(196, 196, 196, 100);

    return MaterialApp(
      theme: ThemeData(
        backgroundColor: backgroundColor,
        primaryColor: Colors.white,
        accentColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Homepage(),
        '/choosegame': (context) => ChooseGamePage(),
      },
    );
  }
}

// create stateless widget
class Homepage extends StatelessWidget {
  Color backgroundColor = const Color.fromRGBO(196, 196, 196, 100);
  Color cardColor = const Color.fromRGBO(138, 138, 138, 100);
  Color whiteColor = const Color.fromRGBO(255, 255, 255, 100);
  double mediumFontSize = 36.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CarouselSlider(
              options: CarouselOptions(height: 400.0),
              items: <Widget>[
                // Search n destroy card
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/choosegame');
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(color: cardColor),
                      child: // set as text at bottom
                          Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Search N Destroy',
                            style: TextStyle(
                                fontSize: mediumFontSize,
                                color: whiteColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                ),

                // Custom Saved Games Card
                Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(color: cardColor),
                    child: // set as text at bottom
                        Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Custom Games',
                          style: TextStyle(
                              fontSize: mediumFontSize,
                              color: whiteColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
