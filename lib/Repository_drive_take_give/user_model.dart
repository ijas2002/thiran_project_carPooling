import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final int id;
  final String source;
  final String destination;
  final int appAmount;
  final int vacancySeat;
  final String documentName;

  const UserModel({
    required this.name,
    required this.id,
    required this.source,
    required this.destination,
    required this.appAmount,
    required this.vacancySeat, required this.documentName

  });

  toJson() {
    return {
      "name": name,
      "id": id,
      "source": source,
      "destination": destination,
      "apxAmount": appAmount,
      "vacancySeat":vacancySeat,


    };
  }
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>>document){
    final data=document.data()!;
    return UserModel(
      documentName: document.id,
      name:data["name"],
      id:data["id"],
      source: data["source"],
      destination: data["destination"],
      appAmount: data["apxAmount"],
        vacancySeat:data["vacancySeat"]
    );
  }

}

