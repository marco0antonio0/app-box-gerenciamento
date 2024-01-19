// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:box_estoque/animations/Navigation.dart';
import 'package:box_estoque/components/InputTexts.dart';
import 'package:box_estoque/components/buttom.dart';
import 'package:box_estoque/components/topbar.dart';
import 'package:box_estoque/components/viewImage.dart';
import 'package:box_estoque/main.dart';
import 'package:box_estoque/model/EstoqueDatabase.dart';
import 'package:box_estoque/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:camera_camera/camera_camera.dart';

class PageCadastro extends StatefulWidget {
  const PageCadastro({super.key});

  @override
  State<PageCadastro> createState() => _PageCadastroState();
}

class _PageCadastroState extends State<PageCadastro> {
  //
  // controladores dos Inputs
  TextEditingController controllerNome = TextEditingController();
  TextEditingController controllerDesc = TextEditingController();
  TextEditingController controllerValor = TextEditingController();
  TextEditingController controllerQtds = TextEditingController();
  //
  // mensagem de erros
  String errMensageNome = '';
  String errMensageDesc = '';
  String errMensageValor = '';
  String errMensageQtds = '';
  //
  //  Instancia database
  EstoqueDatabase estoqueDB = EstoqueDatabase.instance;
  // =============================================================
  // inciar o objeto imagem
  File? imageFile;
  // inciar o caminho do path objeto imagem
  String imageFilePath = '';

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
                titulo: 'Cadastra novo\nproduto',
                fnButtom: () {
                  setState(() {
                    imageFile = null;
                    imageFilePath = '';
                  });
                  Navigator.of(context).pop();
                },
                tituloButtom: 'voltar'),
            Align(
              alignment: Alignment.topCenter,
              // =======================================================================================
              //         Condicional de resposividade do Widget abaixo => larguraRelativa
              child: SizedBox(
                width: larguraRelativa,
                child: Column(
                  children: [
                    // =======================================================================================
                    //                                  Widget - image
                    ViewImage(
                      path: imageFile != null ? FileImage(imageFile!) : null,
                    ),
                    // =======================================================================================
                    //            BTNS - alterar imagem:adiciona imagem  -- remover imagem
                    //
                    //            enable:disable <== feature camera
                    FetueareCamera
                        ? Container(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: (larguraRelativa / 2) - 35,
                                    child: buttomForms(
                                        color: imageFile != null
                                            ? Colors.red[300]?.withOpacity(0.7)
                                            : null,
                                        resize: true,
                                        titulo: imageFile != null
                                            ? 'remover imagem'
                                            : 'adiciona imagem',
                                        fn: () {
                                          //
                                          //======================================
                                          //          remover imagem
                                          //
                                          if (imageFile != null) {
                                            setState(() {
                                              imageFile = null;
                                              imageFilePath = '';
                                            });
                                          } else {
                                            //
                                            //======================================
                                            //          adiciona imagem
                                            //
                                            navigateToPageWithReverseSlideAnimation(
                                                context,
                                                CameraCamera(
                                                    onFile: (file) => {
                                                          setState(() {
                                                            imageFile = file;
                                                          }),
                                                          if (imageFile != null)
                                                            {
                                                              setState(() {
                                                                imageFilePath =
                                                                    file.path;
                                                              }),
                                                              Navigator.pop(
                                                                  context)
                                                            }
                                                        }));
                                            //======================================
                                          }
                                        }),
                                  ),
                                ]),
                          )
                        : Container(),
                    // =======================================================================================
                    //                                  Margem
                    const SizedBox(height: 10),
                    // =======================================================================================
                    //                            ENTRADA DE TEXTO - nome
                    InputTextEditing(
                      fnOnChanged: () {
                        // =======================================================
                        //    caso o campo esteja vazio set a mensagem de erro
                        //    caso contrario campo erro vazio
                        setState(() {
                          errMensageNome = controllerNome.text.isNotEmpty
                              ? ''
                              : 'Campo vazio';
                        });
                      },
                      titulo: 'nome - produto',
                      maxHeigth: 17,
                      maxLines: 1,
                      controller: controllerNome,
                      errorMensage: errMensageNome,
                    ),
                    // =======================================================================================
                    //                            ENTRADA DE TEXTO - detalhes
                    InputTextEditing(
                      fnOnChanged: () {
                        // =======================================================
                        //    caso o campo esteja vazio set a mensagem de erro
                        //    caso contrario campo erro vazio
                        setState(() {
                          errMensageDesc = controllerDesc.text.isNotEmpty
                              ? ''
                              : 'Campo vazio';
                        });
                      },
                      titulo: 'detalhes - produto',
                      maxHeigth: 300,
                      maxLines: 6,
                      controller: controllerDesc,
                      errorMensage: errMensageDesc,
                    ),
                    // =======================================================================================
                    //                            ENTRADA DE TEXTO - valor unitario
                    InputTextEditing(
                      prefix: '\$',
                      fnOnChanged: () {
                        // ==========================================================
                        //                  verifica se campo vazio
                        //
                        if (controllerValor.text.isNotEmpty) {
                          // ====================================
                          // valida se o valor double se valido
                          try {
                            double.parse(controllerValor.text) * 1.0;
                            setState(() {
                              errMensageValor = '';
                            });
                          } catch (e) {
                            // ==================================
                            // caso tenha algum erro no valor double
                            // set o erro mensagem
                            setState(() {
                              errMensageValor = 'Campo invalido';
                            });
                          }
                          //
                        } else {
                          // ==================================
                          // caso o campo esteja vazio set o erro
                          setState(() {
                            errMensageValor = 'Campo vazio';
                          });
                        }
                      },
                      titulo: 'valor unitario - produto',
                      maxLines: 1,
                      maxHeigth: 4,
                      keyboardTypeNumber: true,
                      controller: controllerValor,
                      errorMensage: errMensageValor,
                    ),
                    // =======================================================================================
                    //                            ENTRADA DE TEXTO - quantidade
                    InputTextEditing(
                      prefix: 'x',
                      fnOnChanged: () {
                        // ==========================================================
                        //                  verifica se campo vazio
                        //
                        if (controllerQtds.text.isNotEmpty) {
                          // ====================================
                          // valida se o valor double se valido
                          try {
                            double.parse(controllerQtds.text) * 1.0;
                            setState(() {
                              errMensageQtds = '';
                            });
                          } catch (e) {
                            // ==================================
                            // caso tenha algum erro no valor double
                            // set o erro mensagem
                            setState(() {
                              errMensageQtds = 'Campo invalido';
                            });
                          }
                          //
                        } else {
                          // ==================================
                          // caso o campo esteja vazio set o erro
                          setState(() {
                            errMensageQtds = 'Campo vazio';
                          });
                        }
                      },
                      titulo: 'quatidade - produto',
                      maxLines: 1,
                      maxHeigth: 4,
                      keyboardTypeNumber: true,
                      controller: controllerQtds,
                      errorMensage: errMensageQtds,
                    ),
                    // =======================================================================================
                    //                                  Margem
                    const SizedBox(height: 10),
                    // =======================================================================================
                    //                           BTN - 'adicionar'
                    buttomForms(
                        titulo: 'adicionar',
                        fn: () async {
                          // ==============================================================================================
                          //  faz a verificção se todos os campos estão preenchidos caso contrario seta a mensagem de erro
                          setState(() {
                            errMensageNome = controllerNome.text.isNotEmpty
                                ? ''
                                : 'Campo vazio';
                            errMensageDesc = controllerDesc.text.isNotEmpty
                                ? ''
                                : 'Campo vazio';
                            // errMensageValor = controllerValor.text.isNotEmpty
                            //     ? ''
                            //     : 'Campo vazio';
                            // errMensageQtds = controllerQtds.text.isNotEmpty
                            //     ? ''
                            //     : 'Campo vazio';
                          });
                          // ================================================
                          // ================================================
                          //      validação para o campo double Valor
                          if (controllerValor.text.isNotEmpty) {
                            // ====================================
                            // valida se o valor double se valido
                            try {
                              double.parse(controllerValor.text) * 1.0;
                              setState(() {
                                errMensageValor = '';
                              });
                            } catch (e) {
                              // ==================================
                              // caso tenha algum erro no valor double
                              // set o erro mensagem
                              setState(() {
                                errMensageValor = 'Campo invalido';
                              });
                            }
                            //
                          } else {
                            // ==================================
                            // caso o campo esteja vazio set o erro
                            setState(() {
                              errMensageValor = 'Campo vazio';
                            });
                          }
                          // ================================================
                          // ================================================
                          //      validação para o campo double Qtds
                          if (controllerQtds.text.isNotEmpty) {
                            // ====================================
                            // valida se o valor double se valido
                            try {
                              double.parse(controllerQtds.text) * 1.0;
                              setState(() {
                                errMensageQtds = '';
                              });
                            } catch (e) {
                              // ==================================
                              // caso tenha algum erro no valor double
                              // set o erro mensagem
                              setState(() {
                                errMensageQtds = 'Campo invalido';
                              });
                            }
                            //
                          } else {
                            // ==================================
                            // caso o campo esteja vazio set o erro
                            setState(() {
                              errMensageQtds = 'Campo vazio';
                            });
                          }
                          // =======================================================
                          if (errMensageNome.isEmpty &&
                              errMensageDesc.isEmpty &&
                              errMensageValor.isEmpty &&
                              errMensageQtds.isEmpty) {
                            //=============================================
                            //        Navega ate a rota principal e
                            //        deleta a pilha de navegação
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const PageHome()),
                              (route) =>
                                  false, // Remove todas as rotas anteriores
                            );
                            await estoqueDB.insertProduct(
                                nomeProd: controllerNome.text,
                                pathImage: imageFilePath,
                                descProd: controllerDesc.text,
                                qtdsProd: controllerQtds.text,
                                valorProd: controllerValor.text,
                                dataAlteracao:
                                    '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                                dataCriacao:
                                    '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}');
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
              ),
            )
          ],
        ),
      ),
    ));
  }
}
