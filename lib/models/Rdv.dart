import 'package:cloud_firestore/cloud_firestore.dart';

class Rdv {
  final String IdD;
  final String IdP;
  final String rdv;
  final DocumentReference reference;

  Rdv.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['IdD'] != null),
        assert(map['IdP'] != null),
        assert(map['rdv'] != null),
        IdD = map['IdD'],
        IdP = map['IdP'],
        rdv = map['rdv'];

  Rdv.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Rdv<$IdD:$IdP>";
}
