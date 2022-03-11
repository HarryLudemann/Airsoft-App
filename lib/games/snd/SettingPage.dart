import 'package:flutter/material.dart';
import 'GamePage.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  Color backgroundColor = const Color.fromRGBO(196, 196, 196, 100);
  Color cardColor = const Color.fromRGBO(138, 138, 138, 100);
  Color whiteColor = const Color.fromRGBO(255, 255, 255, 100);
  double mediumFontSize = 36.0;
  double smallFontSize = 18.0;

  late double spacing = 5.0;
  String dropdownValue = 'Medium';
  double cardsRemember = 5;
  double passcodeAttempts = 3;
  bool passcodeChanges = true;
  double bombExplosionSec = 300;
  bool soundOn = true;
  bool soundBombCountdownOn = true;
  double waitSeconds = 15; // game starts in

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
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Difficulty:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: whiteColor,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  // add padding to left right
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 3),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    dropdownColor: cardColor,
                    elevation: 0,
                    style: TextStyle(color: whiteColor, fontSize: 20),
                    underline: Container(
                      height: 0,
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
                          value: value, child: Text(value));
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
          // create simple expansion panel
          Container(
            child: Column(children: <Widget>[
              SizedBox(height: spacing),
              // Select Game Text
              Text(
                'Bomb Explosion:',
                style: TextStyle(
                  fontSize: 20,
                  color: whiteColor,
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
                      value: bombExplosionSec,
                      min: 60,
                      max: 900,
                      divisions: 14,
                      activeColor: whiteColor,
                      label: '${(bombExplosionSec / 60).toStringAsFixed(0)}m',
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
              Text(
                'Plant/Defuse Attempts:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: whiteColor,
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
                      value: passcodeAttempts,
                      min: 1,
                      max: 10,
                      divisions: 10,
                      activeColor: whiteColor,
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
              Text(
                'Wait Screen Time:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: whiteColor,
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
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: whiteColor,
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
                      activeColor: whiteColor,
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
                    Text(
                      'Passcode Changes',
                      style: TextStyle(
                        color: whiteColor,
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
              Text(
                'Sound:',
                style: TextStyle(
                  color: whiteColor,
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
                    Text(
                      'Sound',
                      style: TextStyle(
                        color: whiteColor,
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
                    Text(
                      'Bomb Countdown',
                      style: TextStyle(
                        color: whiteColor,
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
          ),

          const SizedBox(height: 20),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: backgroundColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                  textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: whiteColor),
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
