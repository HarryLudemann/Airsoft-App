import 'package:flutter/material.dart';
import 'package:Nguha/host/SettingPage.dart';

class HostPage extends StatefulWidget {
  String name = "";
  HostPage({Key? key, required String name}) : super(key: key) {
    this.name = name;
  }

  @override
  State<HostPage> createState() => _HostPageState();
}

class _HostPageState extends State<HostPage> {
  String selected_game = "snd";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SettingPage(name: widget.name),
    );
  }
}
