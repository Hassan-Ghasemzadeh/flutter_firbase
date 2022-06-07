import 'package:flutter/material.dart';
import 'package:flutter_firbase/models/user.dart';
import 'package:flutter_firbase/services/database.dart';
import 'package:flutter_firbase/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugers = <String>["0", "1", "2", "3", "4", "5"];

  String? _currentName = 'Suarez';
  String? _currentSugers = '0';
  int? _currentStrength = 100;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    return StreamBuilder<Userdata>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        Userdata userData = snapshot.data ??
            Userdata(
              name: '',
              sugars: '0',
              strength: 100,
            );
        return Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                'Update your brew settings',
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: userData.name,
                decoration: inputDecoration.copyWith(hintText: _currentName),
                validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
                onChanged: (val) => setState(() => _currentName = val),
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButtonFormField(
                decoration: inputDecoration,
                value: _currentSugers ?? userData.sugars,
                items: sugers.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text('$e sugars'),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() => _currentSugers = value!);
                },
              ),
              Slider(
                min: 100.0,
                max: 900.0,
                divisions: 8,
                activeColor: Colors.brown,
                inactiveColor: Colors.brown[100],
                value: _currentStrength!.toDouble(),
                onChanged: (double value) {
                  setState(
                    () => _currentStrength = value.round(),
                  );
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await DatabaseService(uid: user.uid).updateUserData(
                      _currentSugers ?? userData.sugars,
                      _currentName ?? userData.name,
                      _currentStrength ?? userData.strength,
                    );
                    Navigator.pop(_formKey.currentContext!);
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.pink),
                ),
                child: const Text('Update'),
              ),
            ],
          ),
        );
      },
    );
  }
}
