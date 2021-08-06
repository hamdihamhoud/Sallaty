import 'package:flutter/material.dart';

enum Languages {
  English,
  Arabic,
}

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var language = Languages.English;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        child: Column(
          children: [
            Container(
              height: 50,
              child: Row(
                children: [
                  Text(
                    'Language',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Spacer(),
                  DropdownButton(
                    value: language,
                    items: Languages.values
                        .map(
                          (e) => DropdownMenuItem(
                            child: Text(
                              e.toString().split('.').last,
                            ),
                            value: e,
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        language = value;
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
