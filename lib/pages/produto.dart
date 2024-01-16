// ignore_for_file: prefer_interpolation_to_compose_strings, must_be_immutable

import 'dart:io';

import 'package:box_estoque/animations/Navigation.dart';
import 'package:box_estoque/components/Paragraph.dart';
import 'package:box_estoque/components/buttom.dart';
import 'package:box_estoque/components/topbar.dart';
import 'package:box_estoque/components/viewImage.dart';
import 'package:box_estoque/components/viewValues.dart';
import 'package:box_estoque/pages/editar.dart';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

class PageProduto extends StatefulWidget {
  Map<String, dynamic> data = {};
  PageProduto({super.key, required this.data});

  @override
  State<PageProduto> createState() => _PageProdutoState();
}

class _PageProdutoState extends State<PageProduto> {
  void initState() {
    super.initState();
    // Inicializar os controladores com os valores de data
    try {
      if (widget.data['pathImage'].length > 0) {
        setState(() {
          imageFile = File(widget.data['pathImage']);
        });
      }
    } catch (e) {}
  }

  // =============================================================
  // inciar o objeto imagem
  File? imageFile;

  // =============================================================
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
                titulo: 'Visualizar\nproduto',
                fnButtom: () {
                  Navigator.of(context).pop();
                },
                tituloButtom: 'voltar'),
            // =======================================================================================
            //         Condicional de resposividade do Widget abaixo => larguraRelativa
            SizedBox(
              width: larguraRelativa,
              child: Column(
                children: [
                  // =======================================================================================
                  //                                  Widget - image
                  ViewImage(
                    path: imageFile != null ? FileImage(imageFile!) : null,
                  ),
                  // =======================================================================================
                  //                           Widget - Text estilizado
                  Paragraph(
                      titulo: widget.data['nomeProd'],
                      text: widget.data['descProd'] +
                          '\n\nCriado em: ${widget.data['dataCriacao']} \nAtualizado em: ${widget.data['dataAlteracao']}'),
                  // =======================================================================================
                  //                              Widgets - Containers estilizados
                  //                              para apresentar infos
                  ViewVizualize(
                      titulo: 'Quantidade\nregistrada',
                      valor: 'x' + widget.data['qtdsProd']),
                  ViewVizualize(
                      titulo: 'Valor por\nunidade',
                      valor: '\$' + widget.data['valorProd']),
                  ViewVizualize(
                      titulo: 'Valor total\ndo estoque',
                      valor:
                          "\$${double.parse(widget.data['valorProd']) * double.parse(widget.data['qtdsProd'])}"),
                  // =======================================================================================
                  //                                  Margem
                  const SizedBox(height: 30),
                  // =======================================================================================
                  //                            BTN - 'fazer alteração'
                  buttomForms(
                      titulo: 'fazer alteração',
                      fn: () {
                        navigateToPageWithReverseSlideAnimation(
                            context, PageEditar(data: widget.data));
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
