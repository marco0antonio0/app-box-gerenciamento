// ignore_for_file: empty_catches, deprecated_member_use

import 'dart:io';

import 'package:box_estoque/animations/Navigation.dart';
import 'package:box_estoque/components/ListViewProds.dart';
import 'package:box_estoque/components/topbar.dart';
import 'package:box_estoque/components/viewValues.dart';
import 'package:box_estoque/model/EstoqueDatabase.dart';
import 'package:box_estoque/pages/cadastro.dart';
import 'package:box_estoque/pages/messageConfirm.dart';
import 'package:flutter/material.dart';

class PageHome extends StatefulWidget {
  const PageHome({super.key});

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  @override
  Widget build(BuildContext context) {
    EstoqueDatabase estoqueDB = EstoqueDatabase.instance;
    double larguraTela = MediaQuery.of(context).size.width;
    double larguraRelativa = larguraTela < 700 ? larguraTela : 700;
    return WillPopScope(
      onWillPop: () async {
        // =============================================
        //        redireciona a ação de 'back'
        //        para acionar o trecho abaixo
        navigateToPageWithReverseSlideAnimation(
            context,
            PageMessageConfirm(
              message: 'Voce deseja sair\ndo app?',
              fn: () {
                try {
                  exit(0);
                } catch (e) {}
              },
            ));
        return false;
      },
      child: SafeArea(
          child: Scaffold(
        // =====================================
        //       Principal-scroll da tela
        body: SingleChildScrollView(
          child: Column(children: [
            // =======================================================================================
            //                             Widget - menu superior e visual
            TopBar(
                home: true,
                titulo: 'Ola seja bem\nvindo',
                fnButtom: () {
                  navigateToPageWithReverseSlideAnimation(
                      context, const PageCadastro());
                },
                tituloButtom: 'Adicionar produto'),

            Align(
              alignment: Alignment.topCenter,
              // =======================================================================================
              //         Condicional de resposividade do Widget abaixo => larguraRelativa
              child: SizedBox(
                width: larguraRelativa,
                child: Column(
                  children: [
                    // =======================================================================================
                    //                                  Margem
                    const SizedBox(height: 5),
                    // =======================================================================================
                    //                Carregamento tardio de dados do database
                    FutureBuilder(
                        future: estoqueDB.countProducts(),
                        builder: (context, AsyncSnapshot snapshot) {
                          // =========================================================
                          //      verifica o estado de conexão => em carregamento
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            // =========================================================
                            //      verifica o estado de conexão => em error
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 40),
                              child: const Text(
                                'erro ao carregar',
                                style: TextStyle(fontSize: 18),
                              ),
                            );
                          } else {
                            // =========================================================
                            //      verifica o estado de conexão => em carregado
                            //
                            //      Widgets - Containers estilizados
                            //      para apresentar infos
                            return ViewVizualize(
                                titulo: 'Quatidade\ntotal resgistrado',
                                valor: 'x${snapshot.data}');
                          }
                        }),
                    // =======================================================================================
                    //                                  Margem
                    const SizedBox(height: 5),
                    // =======================================================================================
                    const ListViewProds()
                  ],
                ),
              ),
            )
          ]),
        ),
      )),
    );
  }
}
