import 'package:box_estoque/animations/Navigation.dart';
import 'package:box_estoque/components/buttom.dart';
import 'package:box_estoque/components/topbar.dart';
import 'package:box_estoque/model/EstoqueDatabase.dart';
import 'package:box_estoque/pages/editarUser.dart';
import 'package:box_estoque/pages/messageConfirm.dart';
import 'package:box_estoque/pages/sobre.dart';
import 'package:flutter/material.dart';

class PageConfig extends StatefulWidget {
  const PageConfig({super.key});

  @override
  State<PageConfig> createState() => _PageConfigState();
}

class _PageConfigState extends State<PageConfig> {
  //            Instancia database
  EstoqueDatabase estoqueDB = EstoqueDatabase.instance;
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
                config: true,
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
                  //                                  Margem
                  const SizedBox(height: 30),
                  // =======================================================================================
                  //                            BTN - 'alterar usuario'
                  buttomForms(
                      titulo: 'alterar dados',
                      fn: () {
                        navigateToPageWithReverseSlideAnimation(
                            context, PageEditarUser());
                      }),
                  // =======================================================================================
                  //                                  Margem
                  const SizedBox(height: 10),
                  // =======================================================================================
                  //                            BTN - 'sobre o app'
                  buttomForms(
                      titulo: 'sobre o app',
                      fn: () {
                        navigateToPageWithReverseSlideAnimation(
                            context, const PageSobre());
                      }),
                  // =======================================================================================
                  //                                  Margem
                  const SizedBox(height: 10),
                  // =======================================================================================
                  //                            BTN - 'apagar todos os produtos'
                  buttomForms(
                      titulo: 'apagar todos os produtos',
                      fn: () {
                        navigateToPageWithReverseSlideAnimation(context,
                            PageMessageConfirm(
                          fn: () {
                            try {
                              estoqueDB.deleteAllProducts();
                            } catch (e) {
                              //========================================
                              //      caso EXISTA algum erro
                              //
                            }
                          },
                        ));
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
