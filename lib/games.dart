import 'dart:ffi';
import 'package:flutter/material.dart';
import 'snd.dart';
import 'dart:developer';

class HostPageWidget extends StatefulWidget {
  HostPageWidget({Key? key}) : super(key: key);

  @override
  State<HostPageWidget> createState() => _HostPageWidgetState();
}

class _HostPageWidgetState extends State<HostPageWidget> {
  String dropdownValue = 'Search and Destroy';

  double cardsRemember = 5;

  double passcodeAttempts = 3;

  double bombExplosionSec = 45;
  bool soundOn = true;
  bool soundBombCountdownOn = true;

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
          // const SizedBox(height: 40),
          // // Select Game Text
          // const Text(
          //   'Select Game:',
          //   style: TextStyle(
          //     fontSize: 20,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          // // Games Dropdown
          // // add padding 5 to each side
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 10),
          //   child: DropdownButtonFormField<String>(
          //     decoration:
          //         const InputDecoration(enabledBorder: InputBorder.none),
          //     value: dropdownValue,
          //     elevation: 0,
          //     style: const TextStyle(
          //       color: Colors.blue,
          //       fontSize: 18.0,
          //     ),
          //     onChanged: (String? newValue) {
          //       dropdownValue = newValue!;
          //     },
          //     items: <String>['Search and Destroy']
          //         .map<DropdownMenuItem<String>>((String value) {
          //       return DropdownMenuItem<String>(
          //         value: value,
          //         child: Text(value),
          //       );
          //     }).toList(),
          //   ),
          // ),

          const SizedBox(height: 40),
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
                  '${bombExplosionSec.toInt()}s',
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
                  min: 10,
                  max: 300,
                  divisions: 58,
                  activeColor: Colors.blue,
                  label: '${bombExplosionSec.round()}s',
                  onChanged: (double newValue) {
                    setState(() {
                      bombExplosionSec = newValue;
                    });
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
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

          const SizedBox(height: 20),
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

          const SizedBox(height: 20),
          const Text(
            'Sound:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),
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
                    });
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),
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
                    });
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                minimumSize: const Size.fromHeight(50),
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                textStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                log('Cards to Remember ' + passcodeAttempts.toString());
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PlaySnD(bombExplosionSec, soundOn,
                      soundBombCountdownOn, cardsRemember, passcodeAttempts),
                ));
              },
              child: const Text('Start'),
            ),
          ),
        ],
      ),
    );
  }
}

class JoinPageWidget extends StatelessWidget {
  const JoinPageWidget({Key? key}) : super(key: key);

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
      // add text field to center page and button to bottom
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  hintText: 'Enter game code',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 5,
                top: 2,
                right: 5,
                bottom: 2,
              ),
              child: ElevatedButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onPressed: () {},
                child: const Text('Join'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
