import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Nguha/util/languages.dart';

import 'package:provider/provider.dart';
import 'package:Nguha/util/preference_model.dart';

// Create home widget given context
Widget HomeWidget(context) {
  return Consumer<PreferenceModel>(
      builder: (context, PreferenceModel themeNotifier, child) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
              minimumSize: const Size.fromHeight(80), // NEW
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/JoinGame');
            },
            child: Text(
              translate('Join', themeNotifier.language),
              style: const TextStyle(fontSize: 24),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
              minimumSize: const Size.fromHeight(80), // NEW
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/HostGame');
            },
            child: Text(
              translate('Host', themeNotifier.language),
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  });
}
