 
import 'package:firebase_ejemplos/controllers/authController.dart';
import 'package:firebase_ejemplos/controllers/negocioController.dart';
import 'package:firebase_ejemplos/controllers/todoController.dart';
import 'package:firebase_ejemplos/controllers/userController.dart';
import 'package:firebase_ejemplos/services/database.dart';
import 'package:firebase_ejemplos/widgets/todo_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends GetWidget<AuthController>{

  final _todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GetX<UserController>(
          initState: (_)async{
            Get.find<UserController>().user =
              await Database().getUser(Get.find<AuthController>().user.uid);
          },
          builder: (_){
            if (_.user.name != null) {
              return Text('Bienvenido ${_.user.name}');
            } else {
              return Text('Cargando...');
            }
          },
        ),
        centerTitle: true, 
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              controller.signOut();
              Get.delete<TodoController>();
            },
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              if (Get.isDarkMode) {
                Get.changeTheme(ThemeData.light());
              } else {
                Get.changeTheme(ThemeData.dark());
              }
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Text(
            "Add Todo Here:",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Card(
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _todoController,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add_circle_outline),
                    onPressed: () {
                      if (_todoController.text != "") {
                        Database()
                            .addTodo(_todoController.text, controller.user.uid);
                        _todoController.clear();
                      } else {
                          Get.snackbar('Error!', 'Completa los campos', snackPosition: SnackPosition.BOTTOM);
                      }
                    },
                  )
                ],
              ),
            ),
          ),
          Text(
            "Your Todos",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          GetX<NegocioController>(
            init: Get.put<NegocioController>(NegocioController()),
            builder: (NegocioController negocioController) {
              if (negocioController != null && negocioController.negocios != null) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: negocioController.negocios.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        title: Text(negocioController.negocios[index].nombre),
                        subtitle: Text(negocioController.negocios[index].descripcion),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(negocioController.negocios[index].foto),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Text("loading...");
              }
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        onPressed: () {
          
        }),
    );
  }
}