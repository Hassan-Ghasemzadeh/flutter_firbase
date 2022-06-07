import 'package:flutter/material.dart';
import 'package:flutter_firbase/services/auth.dart';
import 'package:flutter_firbase/shared/loading.dart';

import '../../shared/constants.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  Register({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email = '';
  String password = '';
  String error = '';

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.grey,
            appBar: AppBar(
              title: const Text('Sign up to crew'),
              elevation: 0.0,
              backgroundColor: Colors.brown[400],
              actions: [
                TextButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: const Icon(Icons.person),
                    label: const Text('Sign In')),
              ],
            ),
            body: Center(
              child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 50.0),
                  child: Form(
                      key: widget._formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            decoration:
                                inputDecoration.copyWith(hintText: 'Email'),
                            validator: (value) =>
                                value!.isEmpty ? 'Enter an email' : null,
                            onChanged: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            decoration:
                                inputDecoration.copyWith(hintText: 'Password'),
                            obscureText: true,
                            validator: (value) => value!.length < 6
                                ? 'Enter a password 6+ chars long'
                                : null,
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (widget._formKey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result = await widget._auth
                                    .registerWithEmailAndPassword(
                                        email, password);

                                if (result == null) {
                                  setState(() {
                                    error =
                                        'Please supply a valid email&password';
                                    loading = false;
                                  });
                                }
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.pink),
                            ),
                            child: const Text('Register'),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          Text(
                            error,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 12.0),
                          )
                        ],
                      ))),
            ),
          );
  }
}
