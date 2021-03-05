import 'package:cloud_firestore/cloud_firestore.dart';

class Patient {
  final String name;
  final String pwd;
  final String username;
  final String prenom;
  final DocumentReference reference;

  Patient.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['nom'] != null),
        assert(map['pwd'] != null),
        assert(map['username'] != null),
        assert(map['prenom'] != null),
        name = map['nom'],
        pwd = map['pwd'],
        username = map['username'],
        prenom = map['prenom'];

  Patient.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$pwd>";
}
