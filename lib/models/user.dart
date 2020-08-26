import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String email;
  String name;


  UserModel({this.id,this.email,this.name});

  UserModel.fromDocumentSnapshot(DocumentSnapshot doc){
    id = doc.id;
    name = doc.data()["name"];
    email = doc.data()["email"];
  }
}