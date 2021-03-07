import 'package:cloud_firestore/cloud_firestore.dart';

class Rdv {
  final String IdD;
  final String IdP;
  final String rdv;
  final String desc;
  final DocumentReference reference;

  Rdv.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['IdD'] != null),
        assert(map['IdP'] != null),
        assert(map['rdv'] != null),
        assert(map['Description'] != null),
        IdD = map['IdD'],
        IdP = map['IdP'],
        desc = map['Description'],
        rdv = map['rdv'];

  Rdv.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Rdv<$IdD:$IdP>";
}
