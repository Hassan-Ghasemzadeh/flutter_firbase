import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firbase/models/brew.dart';
import 'package:flutter_firbase/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid = ''});
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  Userdata _userdataForSnapshot(DocumentSnapshot snapshot) {
    return Userdata(
      sugars: snapshot['sugars'] ?? '0',
      name: snapshot['name'] ?? '',
      strength: snapshot['strength'] ?? 0,
    );
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return Brew(
        name: e['name'],
        sugars: e['sugars'],
        strength: e['strength'],
      );
    }).toList();
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  Stream<Userdata> get userData {
    return brewCollection.doc(uid).snapshots().map(_userdataForSnapshot);
  }
}
