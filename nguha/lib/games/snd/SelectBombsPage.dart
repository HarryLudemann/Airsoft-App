import 'dart:async';
import 'package:Nguha/util/firebase/change_user_team.dart';
import 'package:Nguha/util/firebase/randomize_team.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Nguha/util/settings/preference_model.dart';
import 'package:Nguha/util/languages.dart';
import 'package:Nguha/util/firebase/listener.dart';

class SndSelectPage extends StatefulWidget {
  String code;
  String userCode = "";
  SndSelectPage({Key? key, required this.code, required this.userCode})
      : super(key: key) {
    this.code = code;
  }

  @override
  State<SndSelectPage> createState() => _SndSelectPageState();
}

class _SndSelectPageState extends State<SndSelectPage> {
  bool bombOneSet = true;
  // StreamSubscription? _onUsersChanged;

  // // dropdown options list
  final List<DropdownMenuItem<String>> _options = <String>[
    '#1 Bomb',
    '#2 Bomb',
    'Red',
    'Blue',
  ].map((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value, style: const TextStyle(color: Colors.white)),
    );
  }).toList();

  Widget _buildPlayerRow(String name, String team, String _userCode) {
    // Inline list tile
    return Container(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
      height: 60,
      child: Card(
        // color blue if team blue, else if red set red else must be bomb
        color: team == 'Blue'
            ? Colors.blue
            : team == 'Red'
                ? Colors.red
                : Colors.orange,
        elevation: 2,
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: team == "Blue" ? Colors.blue : Colors.red, width: 0.5),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                name,
                style: TextStyle(
                    color: _userCode == widget.userCode
                        ? Colors.white
                        : Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Theme(
                data: Theme.of(context).copyWith(
                    canvasColor: team == 'Blue'
                        ? Colors.blue
                        : team == 'Red'
                            ? Colors.red
                            : Colors.orange),
                child: DropdownButton<String>(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: _userCode == widget.userCode
                        ? Colors.black
                        : Colors.white,
                  ),
                  underline: Container(),
                  value: team,
                  items: _options,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      // if team is "#1 Bomb" set bombOneSet to false
                      if (team == '#1 Bomb') {
                        setState(() {
                          bombOneSet = false;
                        });
                      } else if (newValue == '#1 Bomb') {
                        setState(() {
                          bombOneSet = true;
                        });
                      }
                      setUserTeam(_userCode, widget.code, newValue);
                      // if not available does nothin - could set this and unset other?
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferenceModel>(
        builder: (context, PreferenceModel themeNotifier, child) {
      return Scaffold(
        backgroundColor: themeNotifier.backgroundColor,
        body: CustomScrollView(
          primary: false,
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Text(
                      translate('Select Teams/Bombs', themeNotifier.language),
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: themeNotifier.fontcolor),
                    ),
                  ],
                ),
              ),
            ),
            // firebase animated list within silver

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SizedBox(
                      height: (MediaQuery.of(context).size.height * 0.8) - 160,
                      child: FirebaseAnimatedList(
                        query: FirebaseDatabase.instance
                            .ref()
                            .child("games")
                            .child(widget.code)
                            .child("users")
                            .orderByChild("team"),
                        itemBuilder: (BuildContext context,
                            DataSnapshot snapshot,
                            Animation<double> animation,
                            int index) {
                          return _buildPlayerRow(
                              snapshot.child('name').value.toString(),
                              snapshot.child('team').value.toString(),
                              snapshot.key.toString());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SizedBox(
                        height: 80,
                        child: Center(
                          child: IconButton(
                            iconSize: 46,
                            icon: Icon(Icons.refresh,
                                color: themeNotifier.fontcolor),
                            onPressed: () {
                              randomize_team(widget.code);
                            },
                          ),
                        )),
                  ],
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SizedBox(
                      height: 80,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                        ),
                        child: Text(
                          translate('Back', themeNotifier.language),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          if (bombOneSet) {
                            Navigator.of(context).pop();
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      translate('Bomb One Must Be Set',
                                          themeNotifier.language),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text(
                                          translate(
                                              'OK', themeNotifier.language),
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
