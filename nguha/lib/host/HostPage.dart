import 'package:flutter/material.dart';
import 'package:Nguha/host/SettingPage.dart';
import 'package:Nguha/util/settings/preference_model.dart';

class HostPage extends StatefulWidget {
  PreferenceModel themeNotifier;
  HostPage({Key? key, required this.themeNotifier}) : super(key: key) {}

  @override
  State<HostPage> createState() => _HostPageState();
}

class _HostPageState extends State<HostPage> {
  String selected_game = "snd";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SettingPage(
          givenName: widget.themeNotifier.username,
          themeNotifier: widget.themeNotifier),
    );
  }
}
