import 'package:flutter/material.dart';
import 'games.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => Homepage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/host': (context) => HostPageWidget(),
        '/join': (context) => const JoinPageWidget(),
      },
    );
  }
}

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<Homepage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Padding(
            //   padding: const EdgeInsets.only(
            //     left: 5,
            //     top: 2,
            //     right: 5,
            //     bottom: 2,
            //   ),
            //   child: ElevatedButton(
            //     style: TextButton.styleFrom(
            //       primary: Colors.white,
            //       backgroundColor: Colors.blue,
            //       padding:
            //           const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
            //       textStyle: const TextStyle(
            //           fontSize: 20, fontWeight: FontWeight.bold),
            //     ),
            //     onPressed: () {
            //       Navigator.pushNamed(context, '/join');
            //     },
            //     child: const Text('Join'),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(
                left: 5,
                top: 2,
                right: 5,
                bottom: 2,
              ),
              child: ElevatedButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/host');
                },
                child: const Text('Start'),
              ),
            ),
          ],
        ),
      ),
      const Text(
        'Account',
        style: optionStyle,
      ),
    ];

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   elevation: 0,
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.account_circle),
      //       label: 'Account',
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.blue,
      //   onTap: _onItemTapped,
      // ),
    );
  }
}
