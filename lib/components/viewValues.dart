// ignore_for_file: must_be_immutable, file_names

import 'package:auto_size_text/auto_size_text.dart';
import 'package:box_estoque/model/decorateUI.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: non_constant_identifier_names
final DecorateUI temp = Get.put(DecorateUI());
// Setters colors in the page
final personColor = temp.colorSelect;

class ViewVizualize extends StatelessWidget {
  String titulo = '';
  String valor = '';
  ViewVizualize({super.key, this.titulo = '', this.valor = ''});

  @override
  Widget build(BuildContext context) {
    const altura = 100.0;
    const margem = 30.0;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: margem, vertical: 5),
      height: altura,
      width: double.infinity,
      color: Color(personColor),
      padding: const EdgeInsets.symmetric(vertical: altura * 0.2),
      child: Row(
        children: [
          const Spacer(flex: 10),
          //==========================================================================
          //                    Text - - titulo identificador
          Expanded(
              flex: 100,
              child: AutoSizeText(titulo,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white))),
          //==========================================================================
          //                                margem
          const Spacer(flex: 5),
          //==========================================================================
          //                    Text - - valor identificador

          Expanded(
              flex: 100,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 2.0, color: Colors.white)),
                child: Center(
                    child: AutoSizeText(
                        valor.substring(0, valor.length > 8 ? 8 : valor.length),
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white))),
              )),
          //==========================================================================
          //                                margem
          const Spacer(flex: 10),
        ],
      ),
    );
  }
}
