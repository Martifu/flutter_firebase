import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ejemplos/models/negocio.dart';
import 'package:firebase_ejemplos/models/todo.dart';
import 'package:firebase_ejemplos/models/user.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> createNewUser(UserModel user) async {
    try {
        await _firestore.collection("users").doc(user.id).set({
          "name": user.name,
          "email": user.email
        });
        return true;
    } catch (e) {
      print(e);
      return false; 
    }
  }

  Future<UserModel> getUser(String uid) async {
    try {
      DocumentSnapshot doc = 
        await _firestore.collection("users").doc(uid).get();
        return UserModel.fromDocumentSnapshot(doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> addTodo(String content, String uid) async {
    try {
      await _firestore
          .collection("users")
          .doc(uid)
          .collection("todos")
          .add({
        'dateCreated': Timestamp.now(),
        'content': content,
        'done': false,
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Stream<List<TodoModel>> todoStream(String uid) {
    return _firestore
        .collection("users")
        .doc(uid)
        .collection("todos")
        .orderBy("dateCreated", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<TodoModel> retVal = List();
      query.docs.forEach((element) {
        retVal.add(TodoModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  Stream<List<NegocioModel>> negocioStream() {
    return _firestore
        .collection("negocios")
        .snapshots()
        .map((QuerySnapshot query) {
      List<NegocioModel> retVal = List();
      query.docs.forEach((element) {
        retVal.add(NegocioModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  Future<void> updateTodo(bool newValue, String uid, String todoId) async {
    try {
      _firestore
          .collection("users")
          .doc(uid)
          .collection("todos")
          .doc(todoId)
          .update({"done": newValue});
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> deleteTodo( String uid, String todoId) async {
    try {
      _firestore
          .collection("users")
          .doc(uid)
          .collection("todos")
          .doc(todoId)
          .delete();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  
}