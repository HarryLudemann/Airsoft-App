import 'package:flutter/material.dart';

// create stateless widget for help page
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Instructions:',
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'BebasNeue'),
            ),
            // const Padding(
            //   padding: EdgeInsets.all(20),
            //   child: Text(
            //     'Click the squares in order according to their numbers',
            //     // align text center
            //     textAlign: TextAlign.center,
            //     style: TextStyle(fontSize: 30, fontFamily: 'BebasNeue'),
            //   ),
            // ),
            // game instuctions
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                '1. Plant/Defuse bomb by completing keycode.',
                // align text center
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                '2. Finish keycode by selecting numbers in ascending order.',
                // align text center
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                '3. Numbers disappear after first tile is selected.',
                // align text center
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              child: const Text('Start'),
            ),
          ],
        ),
      ),
    );
  }
}

// class Homepage extends StatefulWidget {
//   @override
//   State<Homepage> createState() => _MyStatefulWidgetState();
// }

// class _MyStatefulWidgetState extends State<Homepage> {
//   int _selectedIndex = 0;
//   static const TextStyle optionStyle =
//       TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

//   @override
//   Widget build(BuildContext context) {
//     final List<Widget> _widgetOptions = <Widget>[
//       Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             // Padding(
//             //   padding: const EdgeInsets.only(
//             //     left: 5,
//             //     top: 2,
//             //     right: 5,
//             //     bottom: 2,
//             //   ),
//             //   child: ElevatedButton(
//             //     style: TextButton.styleFrom(
//             //       primary: Colors.white,
//             //       backgroundColor: Colors.blue,
//             //       padding:
//             //           const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
//             //       textStyle: const TextStyle(
//             //           fontSize: 20, fontWeight: FontWeight.bold),
//             //     ),
//             //     onPressed: () {
//             //       Navigator.pushNamed(context, '/join');
//             //     },
//             //     child: const Text('Join'),
//             //   ),
//             // ),
//             Padding(
//               padding: const EdgeInsets.only(
//                 left: 5,
//                 top: 2,
//                 right: 5,
//                 bottom: 2,
//               ),
//               child: ElevatedButton(
//                 style: TextButton.styleFrom(
//                   primary: Colors.white,
//                   backgroundColor: Colors.blue,
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
//                   textStyle: const TextStyle(
//                       fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 onPressed: () {
//                   Navigator.pushNamed(context, '/help');
//                 },
//                 child: const Text('Start'),
//               ),
//             ),
//           ],
//         ),
//       ),
//       const Text(
//         'Account',
//         style: optionStyle,
//       ),
//     ];

//     void _onItemTapped(int index) {
//       setState(() {
//         _selectedIndex = index;
//       });
//     }

//     return Scaffold(
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       // bottomNavigationBar: BottomNavigationBar(
//       //   elevation: 0,
//       //   items: const <BottomNavigationBarItem>[
//       //     BottomNavigationBarItem(
//       //       icon: Icon(Icons.home),
//       //       label: 'Home',
//       //     ),
//       //     BottomNavigationBarItem(
//       //       icon: Icon(Icons.account_circle),
//       //       label: 'Account',
//       //     ),
//       //   ],
//       //   currentIndex: _selectedIndex,
//       //   selectedItemColor: Colors.blue,
//       //   onTap: _onItemTapped,
//       // ),
//     );
//   }
// }
