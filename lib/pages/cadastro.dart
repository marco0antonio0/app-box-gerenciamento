// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:box_estoque/components/InputTexts.dart';
import 'package:box_estoque/components/buttom.dart';
import 'package:box_estoque/components/topbar.dart';
import 'package:box_estoque/components/viewImage.dart';
import 'package:box_estoque/model/EstoqueDatabase.dart';
import 'package:box_estoque/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  // instancia da funcionalidade
  final imagePicker = ImagePicker();
  // inciar o objeto imagem
  File? imageFile;
  // inciar o caminho do path objeto imagem
  String imageFilePath = '';

  pick(ImageSource source) async {
    // executa a operação de abrir camera
    final pickedFile = await imagePicker.pickImage(source: source);

    // se o retorno da operação acima for valido
    // então sete os valores adequados resolvidos
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        imageFilePath = pickedFile.path;
        print('esse é o caminho');
        print(imageFilePath);
      });
    }
  }
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
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: (larguraRelativa / 2) - 35,
                              child: buttomForms(
                                  resize: true,
                                  titulo: imageFile != null
                                      ? 'alterar imagem'
                                      : 'adiciona imagem',
                                  fn: () {
                                    // Navigator.of(context).pop();
                                    // Buscar imagem da galeria
                                    pick(ImageSource.camera);
                                  }),
                            ),
                            SizedBox(width: 10),
                            imageFile != null
                                ? SizedBox(
                                    width: (larguraRelativa / 2) - 35,
                                    child: buttomForms(
                                        color: Colors.red[300],
                                        resize: true,
                                        titulo: 'remover imagem',
                                        fn: () {
                                          // remove imagem da memoria
                                          setState(() {
                                            imageFile = null;
                                            imageFilePath = '';
                                          });
                                        }),
                                  )
                                : Container(),
                          ]),
                    ),
                    // =======================================================================================
                    //                                  Margem
                    const SizedBox(height: 10),
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
                        setState(() {
                          errMensageValor = controllerValor.text.isNotEmpty
                              ? ''
                              : 'Campo vazio';
                        });
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
                        setState(() {
                          errMensageQtds = controllerQtds.text.isNotEmpty
                              ? ''
                              : 'Campo vazio';
                        });
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
