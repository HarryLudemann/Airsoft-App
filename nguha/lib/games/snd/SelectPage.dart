import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Nguha/util/settings/preference_model.dart';
import 'package:Nguha/util/languages.dart';
import 'package:Nguha/util/firebase/listener.dart';

class SndSelectPage extends StatefulWidget {
  String code = "";
  SndSelectPage({Key? key, required String code}) : super(key: key) {
    this.code = code;
  }

  @override
  State<SndSelectPage> createState() => _SndSelectPageState();
}

class _SndSelectPageState extends State<SndSelectPage> {
  StreamSubscription? _onUsersChanged;

  // dropdown options list
  final List<DropdownMenuItem<String>> _options = <String>[
    '-',
    '#1 Bomb',
    '#2 Bomb',
  ].map((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value, style: const TextStyle(color: Colors.white)),
    );
  }).toList();

  // return true if available and false if not
  bool checkAvailableTag(String tag) {
    for (String team in _players.values) {
      if (team == tag) {
        return false;
      }
    }
    return true;
  }

  // widget for each player given name, a list item with dropdown on right with two team colors and 1-3
  Widget _buildPlayerRow(String name, String index, String? nameCode) {
    // return container of row with name and dropdown with blue, red, 1, 2, 3
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Theme(
            data: Theme.of(context)
                .copyWith(canvasColor: Theme.of(context).primaryColor),
            child: DropdownButton<String>(
              underline: Container(),
              value: index,
              items: _options,
              onChanged: (newValue) {
                if (newValue != null) {
                  if (checkAvailableTag(newValue)) {
                    setState(() {
                      _updatePlayer(name, newValue, nameCode);
                    });
                  }
                  // if not available does nothin - could set this and unset other?
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Map<String, String> _playersKeys = {};

  Map<String, String> _players = {};

  void _updatePlayer(String name, String value, String? nameCode) {
    if (nameCode == null) {
      return;
    }

    DatabaseListener _teamListener =
        DatabaseListener("games/" + widget.code + "/users/" + nameCode);
    _teamListener.update({'team': value});
  }

  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  @override
  void deactivate() {
    _deactivateListeners();
    super.deactivate();
  }

  void _deactivateListeners() {
    super.deactivate();
    if (_onUsersChanged != null) {
      _onUsersChanged!.cancel();
      _onUsersChanged = null;
    }
  }

  void _activateListeners() {
    DatabaseListener usersListener =
        DatabaseListener("games/" + widget.code + "/users/");

    // Stream<DatabaseEvent> stream = databaseref.onValue;

    _onUsersChanged = usersListener.listenTwoChildList(
        (Map<String, String> map, Map<String, String> mapKeys) {
      // iterate over event.snapshot.children
      setState(() {
        _playersKeys = mapKeys;
        _players = map;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = const Color.fromARGB(255, 32, 32, 32);

    return Consumer<PreferenceModel>(
        builder: (context, PreferenceModel themeNotifier, child) {
      return Scaffold(
        backgroundColor: backgroundColor,
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
                      style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),

            // for each item in _players, build row
            ..._players.entries.map((entry) {
              return SliverList(
                delegate: SliverChildListDelegate(
                  [
                    _buildPlayerRow(
                      entry.key,
                      entry.value,
                      _playersKeys[entry.key],
                    ),
                  ],
                ),
              );
            }),

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    // elevated button min height 70, takes full width
                    SizedBox(
                      height: 80,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          // borderRadius: BorderRadius.circular(10),
                          // borderSide: BorderSide(color: Colors.white),
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
                          // if both bombs are available show dialog that atleast one bomb must be set
                          if (checkAvailableTag("#1 Bomb") &&
                              checkAvailableTag("#2 Bomb")) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    translate(
                                        'Select Bomb', themeNotifier.language),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  content: Text(
                                    translate('Atleast one bomb must be set',
                                        themeNotifier.language),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text(
                                        translate('Ok', themeNotifier.language),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            Navigator.of(context).pop();
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
