import 'package:flutter/material.dart';
import 'package:Nguha/home/HomeWidget.dart';
import 'package:Nguha/home/HelpWidget.dart';
import 'package:Nguha/home/SettingWidget.dart';
// for SettingsHome widget
import 'package:provider/provider.dart';
import 'package:Nguha/util/settings/preference_model.dart';
import 'package:Nguha/util/settings/language_preference.dart';
import 'package:flutter/services.dart';
import 'package:Nguha/util/languages.dart';

// create stateless widget
class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  double mediumFontSize = 36.0;
  int _selectedIndex = 0;
  int _selectedSettingIndex = 0;

  // moves display widget to the given index widget
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // List of the widget pages
    final List<Widget> _widgetOptions = <Widget>[
      // first page - home page
      HomeWidget(context),
      // second page help page
      HelpWidget(context),
      // Setting Home
      SettingWidget(context),
    ];

    return Scaffold(
      //appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      bottomNavigationBar: BottomNavigationBar(
        // type: BottomNavigationBarType.fixed,
        // use bottom navigation theme data from theme
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: '',
            backgroundColor: Theme.of(context).primaryColor,
            // backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.help),
            label: '',
            backgroundColor: Theme.of(context).primaryColor,
            // backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: '',
            backgroundColor: Theme.of(context).primaryColor,
            // backgroundColor: Colors.pink,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor:
            Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        unselectedItemColor:
            Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        selectedIconTheme: const IconThemeData(size: 30),
        unselectedIconTheme: const IconThemeData(size: 30),
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
