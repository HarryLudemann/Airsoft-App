import 'package:Airsoft/games/snd/SettingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChooseGamePage extends StatefulWidget {
  ChooseGamePage({Key? key}) : super(key: key);

  @override
  State<ChooseGamePage> createState() => _ChooseGamePageState();
}

class _ChooseGamePageState extends State<ChooseGamePage> {
  Color backgroundColor = const Color.fromRGBO(196, 196, 196, 100);
  Color cardColor = const Color.fromRGBO(138, 138, 138, 100);
  Color whiteColor = const Color.fromRGBO(255, 255, 255, 100);
  double mediumFontSize = 36.0;
  double smallFontSize = 18.0;

  String dropdownValue = 'Medium';
  double cardsRemember = 5;
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: whiteColor,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Text(
              'Choose Games',
              style: TextStyle(
                  fontSize: mediumFontSize,
                  fontWeight: FontWeight.bold,
                  color: whiteColor),
            ),
            // add 10
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ExpansionPanelList(
                animationDuration: Duration(milliseconds: 1000),
                children: [
                  ExpansionPanel(
                    // shows as error, modified ExpansionPanel adding hasicon
                    // hide error for vscode
                    hasIcon: false,
                    backgroundColor: backgroundColor,
                    headerBuilder: (context, isExpanded) {
                      return Container(
                        height: 100,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Chimp Test',
                              style: TextStyle(
                                  fontSize: smallFontSize,
                                  fontWeight: FontWeight.bold,
                                  color: whiteColor),
                            ),
                            Wrap(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Icon(
                                    Icons.help_outline_sharp,
                                    color: whiteColor,
                                    size: 40,
                                  ),
                                ),
                                Icon(
                                  isExpanded
                                      ? Icons.check_box_outlined
                                      : Icons.check_box_outline_blank,
                                  color: whiteColor,
                                  size: 40,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                      // set border radius for header
                      // return ListTile(
                      //   title: Text(
                      //     'Chimp Test',
                      //     style: TextStyle(
                      //         color: whiteColor, fontWeight: FontWeight.bold),
                      //   ),
                      // );
                    },
                    body: Column(children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Difficulty:',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: whiteColor,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: cardColor,
                              border: Border.all(
                                color: cardColor,
                                width: 1,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 3),
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                    // backgroundColor: cardColor,
                                    // canvasColor: cardColor,
                                    // primaryColor: cardColor,
                                    ),
                                child: DropdownButton<String>(
                                  // remove opacity
                                  elevation: 0,
                                  dropdownColor: cardColor,
                                  value: dropdownValue,
                                  // set background color
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: whiteColor,
                                  ),
                                  style: TextStyle(
                                      color: whiteColor, fontSize: 20),
                                  underline: Container(
                                    height: 0,
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownValue = newValue!;
                                      if (newValue == 'Easy') {
                                        cardsRemember = 5;
                                      } else if (newValue == 'Medium') {
                                        cardsRemember = 8;
                                      } else if (newValue == 'Hard') {
                                        cardsRemember = 12;
                                      }
                                    });
                                  },
                                  items: <String>['Easy', 'Medium', 'Hard']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,
                                          style: TextStyle(
                                              color: whiteColor,
                                              fontSize: smallFontSize)),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // add divider of 10
                      Container(
                        height: 10,
                      ),
                      Text(
                        'Cards to Remember:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: whiteColor,
                        ),
                      ),
                      // Number of cards Slider
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              '${cardsRemember.toStringAsFixed(0)}',
                              style: TextStyle(
                                color: whiteColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          // set slider width to fill row
                          Expanded(
                            // add padding
                            child: Slider(
                              value: cardsRemember,
                              min: 2,
                              max: 12,
                              divisions: 10,
                              activeColor: backgroundColor,
                              label: '${cardsRemember.round()}',
                              onChanged: (double newValue) {
                                setState(() {
                                  cardsRemember = newValue;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ]),
                    isExpanded: _expanded,
                    canTapOnHeader: true,
                  ),
                ],
                dividerColor: cardColor,
                expansionCallback: (panelIndex, isExpanded) {
                  _expanded = !_expanded;
                  setState(() {});
                },
              ),
            ),

            Spacer(),
            Container(
              width: double.infinity,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RaisedButton(
                color: backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                  'Start',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: whiteColor,
                  ),
                ),
                onPressed: () {
                  // goto settings page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
