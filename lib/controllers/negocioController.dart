import 'package:firebase_ejemplos/models/negocio.dart';
import 'package:firebase_ejemplos/services/database.dart';
import 'package:get/get.dart';

class NegocioController extends GetxController {
  Rx<List<NegocioModel>> negocioList = Rx<List<NegocioModel>>();

  List<NegocioModel> get negocios => negocioList.value;

  @override
  void onInit() {
    negocioList
        .bindStream(Database().negocioStream()); //stream hacia firebase
  }

  @override
  void onClose() {
    print('Closed');
    super.onClose();
  }


}