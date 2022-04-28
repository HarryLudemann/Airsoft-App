import 'package:flutter/material.dart';
import 'package:Nguha/util/languages.dart';
import 'package:provider/provider.dart';
import 'package:Nguha/util/preference_model.dart';

class SndHelpPage extends StatelessWidget {
  const SndHelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = const Color.fromARGB(255, 32, 32, 32);

    return Consumer<PreferenceModel>(
        builder: (context, PreferenceModel themeNotifier, child) {
      return Scaffold(
        backgroundColor: backgroundColor,
        body: CustomScrollView(
          primary: false,
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Text(
                      translate('Search n Destroy', themeNotifier.language),
                      style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
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
                          primary: Theme.of(context).primaryColor,
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
