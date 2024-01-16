// ignore_for_file: use_build_context_synchronously, file_names, deprecated_member_use

import 'dart:io';

import 'package:box_estoque/animations/Navigation.dart';
import 'package:box_estoque/components/InputTexts.dart';
import 'package:box_estoque/components/Paragraph.dart';
import 'package:box_estoque/components/buttom.dart';
import 'package:box_estoque/components/topbar.dart';
import 'package:box_estoque/components/viewImage.dart';
import 'package:box_estoque/model/EstoqueDatabase.dart';
import 'package:box_estoque/pages/home.dart';
import 'package:box_estoque/pages/messageConfirm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/UserModel.dart';

class PageCadastroUser extends StatefulWidget {
  const PageCadastroUser({super.key});

  @override
  State<PageCadastroUser> createState() => _PageCadastroUserState();
}

class _PageCadastroUserState extends State<PageCadastroUser> {
  //
  // controladores dos Inputs
  TextEditingController controllerNome = TextEditingController();
  //
  // Seters de errosMensages dos Inputs
  String errMensageNome = '';
  //
  // Instancia class UserModel
  final UserModel instance = Get.put(UserModel());
  //
  // Instancia database
  EstoqueDatabase estoqueDB = EstoqueDatabase.instance;

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [
              // =======================================================================================
              //                             Widget - menu superior e visual
              TopBar(
                  initPage: true,
                  titulo: 'Ola seja bem\nvindo',
                  fnButtom: () {
                    Navigator.of(context).pop();
                  },
                  tituloButtom: ''),
              // =======================================================================================
              //         Condicional de resposividade do Widget abaixo => larguraRelativa
              SizedBox(
                width: larguraRelativa,
                child: Column(
                  children: [
                    // =======================================================================================
                    //                                  Margem
                    const SizedBox(height: 10),
                    // =======================================================================================
                    ParagraphType2(titulo: 'Cadastrar\nnovo usuario'),
                    // =======================================================================================
                    //                                  Margem
                    const SizedBox(height: 10),
                    // =======================================================================================
                    //                                  Widget - image
                    ViewImage(),
                    // =======================================================================================
                    //                            ENTRADA DE TEXTO - nome
                    InputTextEditing(
                      fnOnChanged: () {
                        setState(() {
                          errMensageNome = controllerNome.text.isNotEmpty
                              ? ''
                              : 'Campo vazio';
                        });
                      },
                      titulo: 'nome',
                      maxHeigth: 17,
                      maxLines: 1,
                      controller: controllerNome,
                      errorMensage: errMensageNome,
                    ),

                    // =======================================================================================
                    //                                  Margem
                    const SizedBox(height: 10),
                    // =======================================================================================
                    //                            BTN - 'Iniciar app'
                    buttomForms(
                        titulo: 'Iniciar app',
                        fn: () async {
                          setState(() {
                            errMensageNome = controllerNome.text.isNotEmpty
                                ? ''
                                : 'Campo vazio';
                          });
                          if (errMensageNome.isEmpty) {
                            // >>>>>>>>>>>>>>>>>>>>
                            //=============================================
                            //        Navega ate a rota principal e
                            //        deleta a pilha d enavegação
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const PageHome()),
                              (route) =>
                                  false, // Remove todas as rotas anteriores
                            );
                            // =======================================
                            //      seta o valor da variavel de class
                            //      singleton 'nome' para o valor
                            //      atualizado
                            instance.nome = controllerNome.text;
                            await estoqueDB
                                .cadastrarUsuario(controllerNome.text);
                          } else {
                            //========================================
                            //      caso campo vazio
                            //
                          }
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
