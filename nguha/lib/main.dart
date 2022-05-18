// inbuilt
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// public
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
// help pages
import 'package:Nguha/help/SndHelpPage.dart';
import 'package:Nguha/help/DomHelpPage.dart';
import 'package:Nguha/help/JoinGameHelpPage.dart';
import 'package:Nguha/help/HostGameHelpPage.dart';
// home page
import 'package:Nguha/home/HomePage.dart';
// import theme model and theme preferences
import 'package:Nguha/util/settings/preference_model.dart';
// import host/join game page
import 'package:Nguha/host/HostPage.dart';
import 'package:Nguha/join/JoinPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ));
    SystemChrome.setEnabledSystemUIOverlays([]); // hide ui elements
    return ChangeNotifierProvider(
      create: (_) => PreferenceModel(),
      child: Consumer<PreferenceModel>(
          builder: (context, PreferenceModel themeNotifier, child) {
        return MaterialApp(
          theme: ThemeData(
            cardColor: themeNotifier.fontcolor,
            backgroundColor: themeNotifier.backgroundColor,
            primaryColor: themeNotifier.primaryColor,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              elevation: 0,
              backgroundColor: themeNotifier.backgroundColor,
              selectedItemColor: themeNotifier.primaryColor,
              unselectedItemColor: const Color.fromARGB(255, 174, 174, 174),
            ),
          ),
          initialRoute: '/',
          routes: {
            '/': (context) {
              return FutureBuilder<FirebaseApp>(
                future: _fbApp,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Homepage();
                  } else {
                    return const Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              );
            },
            '/HostGame': (context) => HostPage(
                  themeNotifier: themeNotifier,
                ),
            '/JoinGame': (context) => const JoinPage(),
            '/SndHelp': (context) => const SndHelpPage(),
            '/DomHelp': (context) => const DomHelpPage(),
            '/JoinGameHelp': (context) => const JoinGameHelpPage(),
            '/HostGameHelp': (context) => const HostGameHelpPage(),
          },
        );
      }),
    );
  }
}
