// ignore_for_file: file_names, unnecessary_getters_setters

import 'package:get/get.dart';

class DecorateUI extends GetxController {
  // 0xff2D2B25
  // 0xff234145
  final _colorSelect = 0xff2D2B25.obs;
  get colorSelect => this._colorSelect.value;
  set colorSelect(value) => this._colorSelect.value = value;
}
