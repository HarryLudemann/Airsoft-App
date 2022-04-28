import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Nguha/util/languages.dart';
import 'package:provider/provider.dart';
import 'package:Nguha/util/preference_model.dart';

Widget HelpWidget(context) {
  return Consumer<PreferenceModel>(
      builder: (context, PreferenceModel themeNotifier, child) {
    return CustomScrollView(
      primary: false,
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              [
                Text(
                  translate('Games', themeNotifier.language),
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverGrid.count(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.topLeft,
                  primary: Theme.of(context).primaryColor, // NEW
                ),
                // padding: const EdgeInsets.all(8),
                onPressed: () {
                  Navigator.pushNamed(context, '/SndHelp');
                },
                child: Text(
                    translate("Search and Destroy", themeNotifier.language),
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                //color: Colors.green[100],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.topLeft,
                  primary: Theme.of(context).primaryColor, // NEW
                ),
                // padding: const EdgeInsets.all(8),
                onPressed: () {
                  Navigator.pushNamed(context, '/DomHelp');
                },
                child: Text(translate("Domination", themeNotifier.language),
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                //color: Colors.green[100],
              ),
            ],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              [
                Text(
                  translate('Help', themeNotifier.language),
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverGrid.count(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.topLeft,
                  primary: Theme.of(context).primaryColor, // NEW
                ),
                // padding: const EdgeInsets.all(8),
                onPressed: () {
                  Navigator.pushNamed(context, '/JoinGameHelp');
                },
                child: Text(
                    translate("How to Join a Game", themeNotifier.language),
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                //color: Colors.green[100],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.topLeft,
                  primary: Theme.of(context).primaryColor, // NEW
                ),
                // padding: const EdgeInsets.all(8),
                onPressed: () {
                  Navigator.pushNamed(context, '/HostGameHelp');
                },
                child: Text(
                    translate("How to Host a Game", themeNotifier.language),
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                //color: Colors.green[100],
              ),
            ],
          ),
        ),
      ],
    );
  });
}
