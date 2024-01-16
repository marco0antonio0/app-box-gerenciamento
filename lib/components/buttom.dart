import 'package:auto_size_text/auto_size_text.dart';
import 'package:box_estoque/model/decorateUI.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: non_constant_identifier_names
final DecorateUI temp = Get.put(DecorateUI());
// Setters colors in the page
final personColor = temp.colorSelect;

Widget buttomForms({titulo = 'adicionar', fn, color, resize = false}) {
  return InkWell(
    onTap: () {
      fn();
    },
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(horizontal: !resize ? 30 : 0),
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        color: color != null ? color : Color(personColor),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 4),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Center(
        child: AutoSizeText(
          titulo,
          maxLines: 1,
          style: const TextStyle(fontSize: 17, color: Colors.white),
        ),
      ),
    ),
  );
}
