import 'package:firebase_ejemplos/controllers/authController.dart';
import 'package:firebase_ejemplos/models/todo.dart';
import 'package:firebase_ejemplos/services/database.dart';
import 'package:get/get.dart';

class TodoController extends GetxController {
  Rx<List<TodoModel>> todoList = Rx<List<TodoModel>>();

  List<TodoModel> get todos => todoList.value;

  @override
  void onInit() {
    String uid = Get.find<AuthController>().user.uid;
    todoList
        .bindStream(Database().todoStream(uid)); //stream hacia firebase
        print('strei');
  }

  @override
  void onClose() {
    print('Closed');
    super.onClose();
  }
  
  
}