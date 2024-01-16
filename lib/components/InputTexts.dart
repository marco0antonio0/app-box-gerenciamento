// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: non_constant_identifier_names
Widget InputTextEditing(
    {required TextEditingController? controller,
    required String? titulo,
    required int? maxHeigth,
    required int? maxLines,
    fnOnChanged,
    errorMensage = '',
    prefix = '',
    bool keyboardTypeNumber = false}) {
  return Container(
    margin: const EdgeInsets.only(top: 0),
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: Column(children: [
      Align(
          alignment: const Alignment(-0.95, -1),
          child: Text(titulo!,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.w500))),
      Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.only(top: 5),
          width: keyboardTypeNumber ? 150 : double.infinity,
          child: TextField(
              keyboardType: keyboardTypeNumber
                  ? TextInputType.number
                  : TextInputType.text,
              controller: controller,
              maxLength: maxHeigth,
              maxLines: maxLines,
              inputFormatters: keyboardTypeNumber
                  ? [FilteringTextInputFormatter.allow(RegExp('[0-9.]'))]
                  : [],
              onChanged: (value) {
                fnOnChanged();
              },
              decoration: InputDecoration(
                  error: errorMensage.length > 0
                      ? Text(
                          errorMensage,
                          style: const TextStyle(color: Colors.red),
                        )
                      : null,
                  prefix: Text(prefix),
                  hintText: 'digite . . .',
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
                  fillColor: const Color(0xffF4F5EE),
                  enabled: true,
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.black.withOpacity(0.1)),
                      borderRadius: BorderRadius.circular(15)))),
        ),
      )
    ]),
  );
}
