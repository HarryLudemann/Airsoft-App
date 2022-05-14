import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Nguha/join/Joined.dart';
import 'package:Nguha/util/languages.dart';
import 'package:Nguha/util/settings/preference_model.dart';

class JoinPage extends StatefulWidget {
  const JoinPage({Key? key}) : super(key: key);

  @override
  State<JoinPage> createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  String code = "";

  void _addToCode(String text) {
    if (code.length < 6) {
      setState(() {
        code += text;
      });
    }
  }

  void _backspaceCode() {
    if (code.isNotEmpty) {
      setState(() {
        code = code.substring(0, code.length - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // return number keypad and enter button
    return Consumer<PreferenceModel>(
        builder: (context, PreferenceModel themeNotifier, child) {
      return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: Container(
            child: Column(
              children: [
                const SizedBox(height: 50),
                Text(
                  code == ""
                      ? translate("Enter code", themeNotifier.language)
                      : code,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: themeNotifier.fontcolor,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.625,
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    children: <Widget>[
                      for (int i = 0; i < 9; i++)
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                          ),
                          child: Text(i.toString(),
                              style: const TextStyle(fontSize: 36)),
                          onPressed: () {
                            _addToCode(i.toString());
                          },
                        ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                        ),
                        child: const Text("#", style: TextStyle(fontSize: 36)),
                        onPressed: () {},
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                        ),
                        child: const Text("9", style: TextStyle(fontSize: 36)),
                        onPressed: () {
                          _addToCode("9");
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                        ),
                        child: const Icon(Icons.backspace,
                            color: Colors.white, size: 36),
                        onPressed: () {
                          _backspaceCode();
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      minimumSize: const Size.fromHeight(80),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JoinedPage(
                              code: code,
                              key: Key(code),
                              name: themeNotifier.username,
                              themeNotifier: themeNotifier),
                        ),
                      );
                    },
                    child: Text(
                      translate('Join', themeNotifier.language),
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 60, 60, 60),
                      minimumSize: const Size.fromHeight(80),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      translate('Back', themeNotifier.language),
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ));
    });
  }
}
