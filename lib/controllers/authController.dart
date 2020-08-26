import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ejemplos/controllers/userController.dart';
import 'package:firebase_ejemplos/models/user.dart';
import 'package:firebase_ejemplos/services/database.dart';

import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User> _firebaseUser = Rx<User>();

  User get user => _firebaseUser.value;

  @override
  void onInit() {
    _firebaseUser.bindStream(_auth.authStateChanges());
  }

  void createUser(String name,String email, String password) async {
    try {
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password);
      //creando usuario en firestore
      UserModel _user = UserModel(
          id: _authResult.user.uid,
          name: name,
          email: email
        );
      if (await Database().createNewUser(_user)) {
        //se creo con exito
        Get.find<UserController>().user = _user;
        Get.back();
      }
      
    } catch (e) {
      Get.snackbar('Error al crear tu cuenta', e.message, snackPosition: SnackPosition.BOTTOM);
    }
  }

  void login(String email, String password) async {
    try {
      UserCredential _authResult = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password);
      Get.find<UserController>().user = await Database().getUser(_authResult.user.uid);
    } catch (e) {
      Get.snackbar('Error al iniciar sesión', e.message, snackPosition: SnackPosition.BOTTOM);
    }
  }

  void signOut() async {
    try {
      await _auth.signOut();      
      Get.find<UserController>().clear();
    } catch (e) {
      Get.snackbar('Error al cerrar sesión', e.message, snackPosition: SnackPosition.BOTTOM);
    }
  }
}