import 'package:cloud_firestore/cloud_firestore.dart';

class NegocioModel {
  String nombre;
  String foto;
  String descripcion;
  List<String> fotos;
  String negocioId;

  NegocioModel({
        this.nombre,
        this.foto,
        this.fotos,
        this.descripcion,
        this.negocioId
    });

  NegocioModel.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    negocioId = documentSnapshot.id;
    nombre = documentSnapshot.data()["nombre"];
    descripcion = documentSnapshot.data()["descripcion"];
    foto = documentSnapshot.data()["foto"];
    fotos = List<String>.from(documentSnapshot.data()["fotos"].map((x) => x)) ;
  }
}