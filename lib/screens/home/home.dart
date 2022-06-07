import 'package:flutter/material.dart';
import 'package:flutter_firbase/models/brew.dart';
import 'package:flutter_firbase/screens/home/brew_list.dart';
import 'package:flutter_firbase/screens/home/setting_form.dart';
import 'package:flutter_firbase/services/auth.dart';
import 'package:flutter_firbase/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  void _showSettingPanel(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.grey[200],
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: const SettingsForm(),
        );
      },
    );
  }

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Brew>?>.value(
      initialData: null,
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text('Sign in to crew'),
          elevation: 0.0,
          backgroundColor: Colors.brown[400],
          actions: [
            Row(
              children: [
                const Icon(Icons.person),
                TextButton(
                  onPressed: () async {
                    await _auth.signOut();
                  },
                  child: const Text(
                    'Log out',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            TextButton.icon(
                onPressed: () => _showSettingPanel(context),
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                label: const Text(
                  'Settings',
                  style: TextStyle(color: Colors.black),
                )),
          ],
        ),
        body: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: const BrewList()),
      ),
    );
  }
}
