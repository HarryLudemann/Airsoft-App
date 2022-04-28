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
import 'package:Nguha/util/preference_model.dart';
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
    SystemChrome.setEnabledSystemUIOverlays([]); // hide ui elements
    return ChangeNotifierProvider(
      create: (_) => PreferenceModel(),
      child: Consumer<PreferenceModel>(
          builder: (context, PreferenceModel themeNotifier, child) {
        return MaterialApp(
          theme: ThemeData(
            backgroundColor: const Color.fromARGB(255, 32, 32, 32),
            primaryColor: themeNotifier.primaryColor,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: themeNotifier.primaryColor,
              elevation: 0,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white,
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
            '/HostGame': (context) => const HostPage(),
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
