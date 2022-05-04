import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Nguha/util/languages.dart';
import 'package:Nguha/util/settings/preference_model.dart';

class HostGameHelpPage extends StatelessWidget {
  const HostGameHelpPage({Key? key}) : super(key: key);

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
                      translate('How to Host Game', themeNotifier.language),
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: themeNotifier.fontcolor),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                              "To host a game, select the game and settings, share game code and press start to begin.",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: themeNotifier.fontcolor)),
                        ),
                        Container(
                          height: 250,
                          width: 150,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/Host.jpg'),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    // elevated button min height 70, takes full width
                    Container(
                      height: 80,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: themeNotifier.primaryColor,
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
                          Navigator.pop(context);
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
