// ignore_for_file: file_names, unnecessary_getters_setters

import 'dart:io';

import 'package:get/get.dart';

class ImageModel extends GetxController {
  final _imagePath = [null].obs;
  get imagePath => this._imagePath;
  set imagePath(value) => this._imagePath.value = value;
}
