// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';

Widget Paragraph({titulo = 'Lorem ipsum', text = ''}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 30),
    child: Column(children: [
      //======================================================================
      //                            titulo
      Align(
        alignment: Alignment.topLeft,
        child: Text(titulo,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
      ),
      //======================================================================
      //                          paragrafo
      Container(
        margin: const EdgeInsets.only(top: 10, bottom: 0),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(text.length > 0 ? text : t,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 18)),
        ),
      )
    ]),
  );
}

Widget ParagraphType2({titulo = '', text = ''}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 30),
    child: Column(children: [
      //======================================================================
      //                            titulo
      titulo.length > 0
          ? Align(
              alignment: Alignment.center,
              child: Text(
                titulo,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            )
          : Container(),
      //======================================================================
      //                          paragrafo
      text.length > 0
          ? Container(
              margin: const EdgeInsets.only(top: 10, bottom: 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(text.length > 0 ? text : t,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 18)),
              ),
            )
          : Container()
    ]),
  );
}

const t = '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras non dictum velit. Integer elit nulla, dapibus vel dolor vitae, tincidunt molestie ligula. Maecenas at enim
''';
