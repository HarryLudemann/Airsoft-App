import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Nguha/util/languages.dart';
import 'package:Nguha/util/settings/preference_model.dart';

class SndHelpPage extends StatelessWidget {
  const SndHelpPage({Key? key}) : super(key: key);

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
              padding: const EdgeInsets.fromLTRB(16, 40, 16, 26),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Text(
                      translate('Search n Destroy', themeNotifier.language),
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
              padding: const EdgeInsets.fromLTRB(16, 0, 8, 26),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Text(
                      translate('Two teams one defending and one attacking.',
                          themeNotifier.language),
                      style: TextStyle(
                          fontSize: 18,
                          // fontWeight: FontWeight.bold,
                          color: themeNotifier.fontcolor),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 8, 26),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Text(
                      translate(
                          'Attacking teams goal is to plant the bomb and defend while it explodes.',
                          themeNotifier.language),
                      style: TextStyle(
                          fontSize: 18,
                          // fontWeight: FontWeight.bold,
                          color: themeNotifier.fontcolor),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 8, 26),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Text(
                      translate(
                          'Defending team to protect bomb, if planted to defuse before time runs out',
                          themeNotifier.language),
                      style: TextStyle(
                          fontSize: 18,
                          // fontWeight: FontWeight.bold,
                          color: themeNotifier.fontcolor),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 8, 26),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Text(
                      translate(
                          'To plant or defuse the bomb the team must input all numbers in ascending order.',
                          themeNotifier.language),
                      style: TextStyle(
                          fontSize: 18,
                          // fontWeight: FontWeight.bold,
                          color: themeNotifier.fontcolor),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 8, 26),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Text(
                      translate(
                          'All numbers are shown on screen, after first number being 1 is pressed all others disappear.',
                          themeNotifier.language),
                      style: TextStyle(
                          fontSize: 18,
                          // fontWeight: FontWeight.bold,
                          color: themeNotifier.fontcolor),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 26),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          child: Text("Game starts with first code displayed",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: themeNotifier.fontcolor)),
                        ),
                        Container(
                          height: 250,
                          width: 150,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/Start.jpg'),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 26),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 250,
                          width: 150,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/Disapear.jpg'),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                              "After number 1 was pressed, all other numbers have disappeared.",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: themeNotifier.fontcolor)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 26),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                              "After attack has completed code correctly the bomb is now planted",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: themeNotifier.fontcolor)),
                        ),
                        Container(
                          height: 250,
                          width: 150,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/images/BombPlanted.jpg'),
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
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 26),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 250,
                          width: 150,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/images/BombDefused.jpg'),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                              "If the defending team manage to defuse the bomb in time, they defuse bomb and win the game.",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: themeNotifier.fontcolor)),
                        ),
                      ],
                    )
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
                              "If the defending does not defuse the bomb in time, the bomb explodes and the attackers win.",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: themeNotifier.fontcolor)),
                        ),
                        Container(
                          height: 250,
                          width: 150,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/Exploded.jpg'),
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
