// ignore_for_file: use_build_context_synchronously, must_be_immutable, file_names

import 'package:box_estoque/components/InputTexts.dart';
import 'package:box_estoque/components/buttom.dart';
import 'package:box_estoque/components/topbar.dart';
import 'package:box_estoque/components/viewImage.dart';
import 'package:box_estoque/model/EstoqueDatabase.dart';
import 'package:box_estoque/model/UserModel.dart';
import 'package:box_estoque/pages/message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageEditarUser extends StatefulWidget {
  PageEditarUser({super.key});

  @override
  State<PageEditarUser> createState() => _PageEditarUserState();
}

class _PageEditarUserState extends State<PageEditarUser> {
  final UserModel instance = Get.put(UserModel());
  @override
  void initState() {
    super.initState();
    // Inicializar os controladores com os valores de userModel.nome
    controllerNome.text = instance.nome;
  }

  //
  //      controladores dos Inputs
  TextEditingController controllerNome = TextEditingController();
  //
  //      Seters de errosMensages dos Inputs
  String errMensageNome = '';
  //
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
                titulo: 'Editar dados\nusuario',
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
                  ViewImage(),
                  // =======================================================================================
                  //                            ENTRADA DE TEXTO - nome
                  InputTextEditing(
                    fnOnChanged: () {
                      setState(() {
                        errMensageNome =
                            controllerNome.text.isNotEmpty ? '' : 'Campo vazio';
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
                  //                            BTN - 'alterar dados'
                  buttomForms(
                      titulo: 'alterar dados',
                      fn: () async {
                        //================================================
                        //  seta a mensagem de erro - '' : 'Campo vazio'
                        setState(() {
                          errMensageNome = controllerNome.text.isNotEmpty
                              ? ''
                              : 'Campo vazio';
                        });
                        if (errMensageNome.isEmpty) {
                          //=============================================
                          //        Navega ate a rota principal e
                          //        deleta a pilha d enavegação
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PageMessage(err: false)));
                          // =======================================
                          //      Executa a função de update da
                          //      class EstoqueDatabase
                          await estoqueDB.atualizarUsuario(
                              nome: controllerNome.text, nomeID: instance.nome);
                          // =======================================
                          //      seta o valor da variavel de class
                          //      singleton 'nome' para o valor
                          //      atualizado

                          instance.nome = controllerNome.text;
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
    ));
  }
}
