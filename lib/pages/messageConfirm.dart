// ignore_for_file: must_be_immutable, file_names

import 'package:box_estoque/components/Paragraph.dart';
import 'package:box_estoque/components/buttom.dart';
import 'package:box_estoque/components/topbar.dart';
import 'package:box_estoque/components/viewImage.dart';
import 'package:box_estoque/pages/home.dart';
import 'package:flutter/material.dart';

class PageMessageConfirm extends StatefulWidget {
  Function fn = () {};
  String message = '';
  PageMessageConfirm(
      {super.key,
      required this.fn,
      this.message = 'Voce tem certeza\ndessa operação'});

  @override
  State<PageMessageConfirm> createState() => _PageMessageConfirmState();
}

class _PageMessageConfirmState extends State<PageMessageConfirm> {
  @override
  Widget build(BuildContext context) {
    double larguraTela = MediaQuery.of(context).size.width;
    double larguraRelativa = larguraTela < 700 ? larguraTela : 700;
    return SafeArea(
        child: Scaffold(
      // =====================================
      //       Principal-scroll da tela
      body: SingleChildScrollView(
        child: Column(
          children: [
            // =======================================================================================
            //                             Widget - menu superior e visual
            TopBar(
                initPage: true,
                titulo: 'Mensagem\nsistema',
                fnButtom: () {},
                tituloButtom: ''),
            SizedBox(
              width: larguraRelativa,
              child: Column(
                children: [
                  // =======================================================================================
                  //                                  Widget - image
                  ViewImage(ico: Icons.error_outlined, icon: true),
                  // =======================================================================================
                  //                                  Margem
                  const SizedBox(height: 5),
                  // =======================================================================================
                  ParagraphType2(titulo: widget.message),
                  // =======================================================================================
                  //                                  Margem
                  const SizedBox(height: 95),
                  // =======================================================================================
                  //                            BTN - 'sim'
                  buttomForms(
                      titulo: 'sim',
                      fn: () {
                        widget.fn();
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const PageHome()),
                          (route) => false, // Remove todas as rotas anteriores
                        );
                      }),
                  // =======================================================================================
                  //                                  Margem
                  const SizedBox(height: 5),
                  // =======================================================================================
                  //                            BTN - 'não'
                  buttomForms(
                      titulo: 'não',
                      fn: () {
                        Navigator.of(context).pop();
                      }),
                  // =======================================================================================
                  //                                  Margem
                  const SizedBox(height: 10),
                  // =======================================================================================
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
