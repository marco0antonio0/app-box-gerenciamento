// ignore_for_file: file_names, unnecessary_getters_setters

import 'package:get/get.dart';

class UserModel extends GetxController {
  final _nome = "".obs;
  get nome => this._nome.value;
  set nome(value) => this._nome.value = value;
}
