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
import 'package:box_estoque/pages/messageConfirm.dart';
import 'package:flutter/material.dart';
import 'package:camera_camera/camera_camera.dart';

// ignore: must_be_immutable
class PageEditar extends StatefulWidget {
  Map<String, dynamic> data = {};

  PageEditar({super.key, required this.data});

  @override
  State<PageEditar> createState() => _PageEditarState();
}

class _PageEditarState extends State<PageEditar> {
  @override
  void initState() {
    super.initState();
    // Inicializar os controladores com os valores de data
    controllerNome.text = widget.data['nomeProd'];
    controllerDesc.text = widget.data['descProd'];
    controllerValor.text = widget.data['valorProd'];
    controllerQtds.text = widget.data['qtdsProd'];

    try {
      if (widget.data['pathImage'].length > 0) {
        setState(() {
          imageFile = File(widget.data['pathImage']);
        });
      }
    } catch (e) {}
  }

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
  // Instancia database
  EstoqueDatabase estoqueDB = EstoqueDatabase.instance;
  // =============================================================
  // inciar o objeto imagem
  File? imageFile;
  // inciar o caminho do path objeto imagem
  String imageFilePath = '';

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
                titulo: 'Editar\nproduto',
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
                                        //======================================
                                        // remover imagem
                                        if (imageFile != null) {
                                          setState(() {
                                            imageFile = null;
                                            imageFilePath = '';
                                          });
                                        } else {
                                          //======================================
                                          // adiciona imagem
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
                                        }
                                        // Buscar imagem da galeria
                                      }),
                                ),
                              ]),
                        )
                      : Container(),
                  // =======================================================================================
                  //                                  Margem
                  const SizedBox(height: 10),
                  // =======================================================================================
                  // =======================================================================================
                  //                            ENTRADA DE TEXTO - nome
                  InputTextEditing(
                    fnOnChanged: () {
                      setState(() {
                        errMensageNome =
                            controllerNome.text.isNotEmpty ? '' : 'Campo vazio';
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
                      setState(() {
                        errMensageDesc =
                            controllerDesc.text.isNotEmpty ? '' : 'Campo vazio';
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
                    fnOnChanged: () {
                      setState(() {
                        errMensageValor = controllerValor.text.isNotEmpty
                            ? ''
                            : 'Campo vazio';
                      });
                    },
                    prefix: '\$',
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
                    fnOnChanged: () {
                      setState(() {
                        errMensageQtds =
                            controllerQtds.text.isNotEmpty ? '' : 'Campo vazio';
                      });
                    },
                    prefix: 'x',
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
                  //                            BTN - 'salvar'
                  buttomForms(
                      color: Colors.green[300],
                      titulo: 'salvar',
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
                          errMensageValor = controllerValor.text.isNotEmpty
                              ? ''
                              : 'Campo vazio';
                          errMensageQtds = controllerQtds.text.isNotEmpty
                              ? ''
                              : 'Campo vazio';
                        });
                        //========================================
                        //      caso NÃO exista algum erro
                        if (errMensageNome.isEmpty &&
                            errMensageDesc.isEmpty &&
                            errMensageValor.isEmpty &&
                            errMensageQtds.isEmpty) {
                          estoqueDB.updateProduct(
                              id: widget.data['id'],
                              nomeProd: controllerNome.text,
                              pathImage: imageFilePath,
                              descProd: controllerDesc.text,
                              valorProd: controllerValor.text,
                              qtdsProd: controllerQtds.text,
                              dataAlteracao:
                                  '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}');

                          //=============================================
                          //        Navega ate a rota principal e
                          //        deleta a pilha d enavegação
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const PageHome()),
                            (route) =>
                                false, // Remove todas as rotas anteriores
                          );
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
                  //                          BTN - 'deletar dado'
                  buttomForms(
                      color: Colors.red[300],
                      titulo: 'deletar',
                      fn: () async {
                        //=============================================
                        //        Navega ate a rota principal e
                        //        deleta a pilha d enavegação
                        navigateToPageWithReverseSlideAnimation(context,
                            PageMessageConfirm(
                          fn: () async {
                            try {
                              await estoqueDB.deleteProduct(widget.data['id']);
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
                  const SizedBox(height: 20),
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
