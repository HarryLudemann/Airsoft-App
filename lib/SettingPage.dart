import 'package:flutter/material.dart';
import 'GamePage.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late double spacing = 0;

  String dropdownValue = 'Easy';

  double cardsRemember = 5;

  double passcodeAttempts = 3;
  bool passcodeChanges = true;

  double bombExplosionSec = 300;
  bool soundOn = true;
  bool soundBombCountdownOn = true;
  double waitSeconds = 15; // game starts in

  bool _expanded = false;

  String secondsToMinutes(double seconds) {
    int sec = seconds.toInt();
    // if seconds is less then 60 return seconds
    if (seconds < 60) {
      return seconds.toStringAsFixed(0) + 's';
    } else {
      int min = sec ~/ 60;
      sec = sec % 60;
      // if sec if less then 10 add 0 to front
      if (sec < 10) {
        return "$min:0$sec";
      } else {
        return "$min:$sec";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Difficulty:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  // add padding to left right
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 3),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    elevation: 16,
                    style: const TextStyle(color: Colors.blue, fontSize: 20),
                    underline: Container(
                      height: 0,
                      color: Colors.transparent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                        if (newValue == 'Easy') {
                          cardsRemember = 5;
                          passcodeAttempts = 10;
                          bombExplosionSec = 900;
                          passcodeChanges = false;
                        } else if (newValue == 'Medium') {
                          cardsRemember = 8;
                          passcodeAttempts = 3;
                          bombExplosionSec = 600;
                          passcodeChanges = true;
                        } else if (newValue == 'Hard') {
                          cardsRemember = 12;
                          passcodeAttempts = 2;
                          bombExplosionSec = 300;
                          passcodeChanges = true;
                        }
                      });
                    },
                    items: <String>['Easy', 'Medium', 'Hard']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
          // create simple expansion panel
          Container(
            color: Colors.green,
            child: ExpansionPanelList(
              animationDuration: Duration(milliseconds: 2000),
              children: [
                ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return const ListTile(
                      title: Text(
                        'Customize Settings',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                  body: Column(children: <Widget>[
                    SizedBox(height: spacing),
                    // Select Game Text
                    const Text(
                      'Bomb Explosion:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Bomb Explosion Slider
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            '${(bombExplosionSec / 60).toStringAsFixed(0)}m',
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        // set slider width to fill row
                        Expanded(
                          // add padding
                          child: Slider(
                            value: bombExplosionSec,
                            min: 60,
                            max: 900,
                            divisions: 14,
                            activeColor: Colors.blue,
                            label:
                                '${(bombExplosionSec / 60).toStringAsFixed(0)}m',
                            onChanged: (double newValue) {
                              setState(() {
                                bombExplosionSec = newValue;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spacing),
                    const Text(
                      'Cards to Remember:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
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
                            style: const TextStyle(
                              color: Colors.blue,
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
                            activeColor: Colors.blue,
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

                    SizedBox(height: spacing),
                    const Text(
                      'Plant/Defuse Attempts:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Number of attempts Slider
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            '${passcodeAttempts.toStringAsFixed(0)}',
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        // set slider width to fill row
                        Expanded(
                          // add padding
                          child: Slider(
                            value: passcodeAttempts,
                            min: 1,
                            max: 10,
                            divisions: 10,
                            activeColor: Colors.blue,
                            label: '${passcodeAttempts.round()}',
                            onChanged: (double newValue) {
                              setState(() {
                                passcodeAttempts = newValue;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spacing),
                    const Text(
                      'Wait Screen Time:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Number of attempts Slider
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            '${secondsToMinutes(waitSeconds)}',
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        // set slider width to fill row
                        Expanded(
                          // add padding
                          child: Slider(
                            value: waitSeconds,
                            min: 0,
                            max: 300,
                            divisions: 20,
                            activeColor: Colors.blue,
                            label: '${secondsToMinutes(waitSeconds)}',
                            onChanged: (double newValue) {
                              setState(() {
                                waitSeconds = newValue;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spacing),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text(
                            'Passcode Changes',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Switch(
                            value: passcodeChanges,
                            onChanged: (bool newValue) {
                              setState(() {
                                passcodeChanges = newValue;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: spacing),
                    const Text(
                      'Sound:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: spacing),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text(
                            'Sound',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Switch(
                            value: soundOn,
                            onChanged: (bool newValue) {
                              setState(() {
                                soundOn = newValue;
                                if (!newValue) {
                                  soundBombCountdownOn = false;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: spacing),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text(
                            'Bomb Countdown',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Switch(
                            value: soundBombCountdownOn,
                            onChanged: (bool newValue) {
                              setState(() {
                                soundBombCountdownOn = newValue;
                                if (newValue) {
                                  soundOn = true;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ]),
                  isExpanded: _expanded,
                  canTapOnHeader: true,
                ),
              ],
              dividerColor: Colors.grey,
              expansionCallback: (panelIndex, isExpanded) {
                _expanded = !_expanded;
                setState(() {});
              },
            ),
          ),

          // add divider
          // const Padding(
          //   padding: EdgeInsets.only(left: 10, right: 10),
          //   child: Divider(
          //     color: Colors.black26,
          //     thickness: 1,
          //   ),
          // ),

          const SizedBox(height: 20),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => GamePage(
                        bombExplosionSec,
                        soundOn,
                        soundBombCountdownOn,
                        cardsRemember,
                        passcodeAttempts,
                        passcodeChanges,
                        waitSeconds),
                  ));
                },
                child: const Text('Start'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class JoinPageWidget extends StatelessWidget {
//   const JoinPageWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           color: Colors.black,
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       // add text field to center page and button to bottom
//       body: Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
//               child: TextField(
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.blue),
//                   ),
//                   hintText: 'Enter game code',
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(
//                 left: 5,
//                 top: 2,
//                 right: 5,
//                 bottom: 2,
//               ),
//               child: ElevatedButton(
//                 style: TextButton.styleFrom(
//                   primary: Colors.white,
//                   backgroundColor: Colors.blue,
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
//                   textStyle: const TextStyle(
//                       fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 onPressed: () {},
//                 child: const Text('Join'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
