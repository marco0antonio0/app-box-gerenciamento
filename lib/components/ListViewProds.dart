// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:box_estoque/animations/Navigation.dart';
import 'package:box_estoque/model/EstoqueDatabase.dart';
import 'package:box_estoque/model/decorateUI.dart';
import 'package:box_estoque/pages/produto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final DecorateUI temp = Get.put(DecorateUI());
// Setters colors in the page
final personColor = temp.colorSelect;

class ListViewProds extends StatefulWidget {
  const ListViewProds({super.key});

  @override
  State<ListViewProds> createState() => _ListViewProdsState();
}

class _ListViewProdsState extends State<ListViewProds> {
  EstoqueDatabase estoqueDB = EstoqueDatabase.instance;

  @override
  Widget build(BuildContext context) {
    double larguraTela = MediaQuery.of(context).size.width;

    const margem = 30.0;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: margem),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 25, bottom: 10),
            child: const Text(
              'Produtos',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 200,
            ),
            child: FutureBuilder(
                future: estoqueDB.getAllProducts(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // =========================================================
                    //      verifica o estado de conexão => em carregamento
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    // =========================================================
                    //      verifica o estado de conexão => em error
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 40),
                      child: const Text(
                        'Erro ao conectar ao banco de dados',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  } else {
                    // =========================================================
                    //      verifica o estado de conexão => em carregado
                    //
                    // verifica  se não esta vazio então execute:
                    return snapshot.data.length > 0
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: ((context, index) {
                              return Item(
                                  largura: larguraTela,
                                  data: snapshot.data[index],
                                  fn: () {
                                    navigateToPageWithReverseSlideAnimation(
                                        context,
                                        PageProduto(
                                            data: snapshot.data[index]));
                                  });
                            }))
                        : Container(
                            // =========================================================
                            //  caso esteja vazio o snapchot.data execute :
                            margin: const EdgeInsets.symmetric(vertical: 40),
                            child: const Text(
                              'Nenhum produto cadastrado',
                              style: TextStyle(fontSize: 18),
                            ),
                          );
                  }
                }),
          ),
        ],
      ),
    );
  }
}

Widget Item({data, fn, largura}) {
  File? imageFile;
  try {
    if (data['pathImage'].length > 0) {
      imageFile = File(data['pathImage']);
    }
  } catch (e) {}

  return InkWell(
    onTap: () {
      fn();
    },
    child: Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 130,
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border:
                Border.all(width: 2.0, color: Colors.black.withOpacity(0.15))),
        child: Row(
          children: [
            //=================================================================================================
            //                                          Image
            Expanded(
                flex: largura < 550 ? 70 : 30,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: data['pathImage'].length > 0
                      ? BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                              image: FileImage(imageFile!),
                              fit: largura < 550
                                  ? BoxFit.fitWidth
                                  : BoxFit.fitHeight),
                          borderRadius: BorderRadius.circular(15))
                      : BoxDecoration(
                          color: Color(personColor),
                          borderRadius: BorderRadius.circular(15)),
                  child: data['pathImage'].length > 0
                      ? Container()
                      : Center(child: Image.asset('images/iconBox.png')),
                )),
            //=================================================================================================
            //                                          Margem - horizontal
            const Spacer(flex: 5),
            //=================================================================================================
            //         sessão de textos -- TITULO - DESC - QTDS E VALOR UNITARIO
            Expanded(
                flex: 100,
                child: Column(
                  children: [
                    //=======================================
                    //        Margem - horizontal
                    const Spacer(flex: 10),
                    //=======================================
                    Expanded(
                        flex: 60,
                        // ==================================================
                        //                    TITULO
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: AutoSizeText(
                            data['nomeProd'],
                            maxLines: 1,
                            minFontSize: 20,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        )),
                    //=======================================
                    //        Margem - vertical
                    const Spacer(flex: 5),
                    //=======================================
                    Expanded(
                        flex: 120,
                        // ==================================================
                        //                    DESC
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: AutoSizeText(
                            data['descProd'],
                            maxLines: 3,
                            minFontSize: 13,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                    //=======================================
                    //        Margem - vertical
                    const Spacer(flex: 2),
                    // ==================================================
                    //               QTDS E VALOR UNITARIO
                    Expanded(
                        flex: 50,
                        child: Container(
                          // color: Colors.green,
                          alignment: Alignment.topLeft,
                          child: Text(
                              'Qtds: ${data['qtdsProd']} | valor:\$ ${data['valorProd']}'),
                        )),
                    //        Margem - horizontal
                    //=======================================
                    //        Margem - vertical
                    const Spacer(flex: 5),
                  ],
                )),
            //=================================================================================================
            //                                          Margem - horizontal
            const Spacer(flex: 6),
          ],
        ),
      ),
    ),
  );
}
