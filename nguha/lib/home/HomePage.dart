import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Nguha/home/HomeWidget.dart';
import 'package:Nguha/home/HelpWidget.dart';
import 'package:Nguha/home/SettingWidget.dart';

// create stateless widget
class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  double mediumFontSize = 36.0;

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    // List of the widget pages
    final List<Widget> _widgetOptions = <Widget>[
      // first page - home page
      HomeWidget(context),
      // second page help page
      HelpWidget(context),
      // fourth page
      SettingWidget(context),
    ];

    // moves display widget to the given index widget
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      //appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      bottomNavigationBar: BottomNavigationBar(
        // use bottom navigation theme data from theme
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            // backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: '',
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            // backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '',
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            // backgroundColor: Colors.pink,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor:
            Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        unselectedItemColor:
            Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        selectedIconTheme: const IconThemeData(size: 30),
        onTap: _onItemTapped,
      ),
      // set background to use theme color
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
    );
  }
}
