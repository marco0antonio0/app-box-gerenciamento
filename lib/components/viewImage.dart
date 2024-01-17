// ignore_for_file: file_names, must_be_immutable
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
// final DecorateUI temp = Get.put(DecorateUI());
// Setters colors in the page
final personColor = 0xff2D2B25;

class ViewImage extends StatefulWidget {
  bool icon = false;
  IconData? ico;
  var path;
  ViewImage({super.key, this.ico, this.icon = false, this.path});

  @override
  State<ViewImage> createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {
  @override
  Widget build(BuildContext context) {
    double larguraTela = MediaQuery.of(context).size.width;
    double larguraRelativa = larguraTela < 700 ? larguraTela : 700;
    return Container(
      height: 180,
      width: larguraRelativa,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      color: widget.path != null ? null : Color(personColor),
      // =======================================
      //      verifica se existe algum path
      //      imagem passada como parametro
      child: widget.path != null
          ? Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2.0, color: Colors.black.withOpacity(0.1)),
                      shape: BoxShape.circle,
                      image: DecorationImage(image: widget.path))),
            )
          : Center(
              child: !widget.icon
                  ? const Image(image: AssetImage('images/iconBox.png'))
                  : Icon(
                      widget.ico,
                      color: Colors.white,
                      size: 100,
                    )),
    );
  }
}
