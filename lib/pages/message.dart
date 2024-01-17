// ignore_for_file: must_be_immutable

import 'package:box_estoque/components/Paragraph.dart';
import 'package:box_estoque/components/buttom.dart';
import 'package:box_estoque/components/topbar.dart';
import 'package:box_estoque/components/viewImage.dart';
import 'package:box_estoque/pages/home.dart';
import 'package:flutter/material.dart';

class PageMessage extends StatefulWidget {
  bool err = false;
  PageMessage({super.key, this.err = false});

  @override
  State<PageMessage> createState() => _PageMessageState();
}

class _PageMessageState extends State<PageMessage> {
  @override
  Widget build(BuildContext context) {
    double larguraTela = MediaQuery.of(context).size.width;
    double larguraRelativa = larguraTela < 700 ? larguraTela : 700;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const PageHome()),
          (route) => false, // Remove todas as rotas anteriores
        );
      },
      child: SafeArea(
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
                    ViewImage(
                        ico: !widget.err ? Icons.check : Icons.error,
                        icon: true),
                    // =======================================================================================
                    //                                  Margem
                    const SizedBox(height: 5),
                    // =======================================================================================
                    //                           Widget - Text estilizado
                    ParagraphType2(
                        titulo: !widget.err
                            ? 'Salvo com sucesso'
                            : "erro na operação"),
                    // =======================================================================================
                    //                                  Margem
                    const SizedBox(height: 95),
                    // =======================================================================================
                    //                            BTN - 'Ir para Inicio'
                    buttomForms(
                        titulo: 'Ir para Inicio',
                        fn: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const PageHome()),
                            (route) =>
                                false, // Remove todas as rotas anteriores
                          );
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
      )),
    );
  }
}
