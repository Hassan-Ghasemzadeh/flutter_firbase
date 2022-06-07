// ignore_for_file: public_member_api_docs, sort_constructors_first
class FirebaseUser {
  final String uid;
  FirebaseUser({
    required this.uid,
  });
}

class Userdata {
  final String sugars;
  final String name;
  final int strength;

  Userdata({this.sugars = '', this.name = '', this.strength = 0});
}
