// ignore_for_file: public_member_api_docs, sort_constructors_first
class Brew {
  String name;
  String sugars;
  int strength;

  Brew({this.name = '', this.sugars = '', this.strength = 0});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Brew &&
        other.name == name &&
        other.sugars == sugars &&
        other.strength == strength;
  }

  @override
  int get hashCode => name.hashCode ^ sugars.hashCode ^ strength.hashCode;
}
