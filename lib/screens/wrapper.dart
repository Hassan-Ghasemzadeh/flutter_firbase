import 'package:flutter/material.dart';
import 'package:flutter_firbase/models/user.dart';
import 'package:flutter_firbase/screens/authenticate/authenticate.dart';
import 'package:flutter_firbase/screens/home/home.dart';
import 'package:provider/provider.dart';

//return either home or authenticate widget
class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    // ignore: unnecessary_null_comparison
    if (user == null) {
      return Authenticate(
        key: key,
      );
    } else {
      return Home(
        key: key,
      );
    }
  }
}
