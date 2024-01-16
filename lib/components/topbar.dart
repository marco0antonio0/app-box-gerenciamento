import 'package:box_estoque/animations/Navigation.dart';
import 'package:box_estoque/model/UserModel.dart';
import 'package:box_estoque/model/decorateUI.dart';
import 'package:box_estoque/pages/config.dart';
import 'package:box_estoque/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: non_constant_identifier_names
final DecorateUI temp = Get.put(DecorateUI());
// Setters colors in the page
final personColor = temp.colorSelect;

// ignore: must_be_immutable
class TopBar extends StatelessWidget {
  final UserModel instance = Get.put(UserModel());
  String titulo = '';
  String tituloButtom = '';
  bool initPage = false;
  bool home = false;
  bool config = false;
  Function fnButtom = () {};
  TopBar(
      {super.key,
      this.home = false,
      this.config = false,
      this.titulo = '',
      this.tituloButtom = '',
      required this.fnButtom,
      this.initPage = false});

  @override
  Widget build(BuildContext context) {
    const margem = 30.0;
    const altura = 190.0;
    double larguraTela = MediaQuery.of(context).size.width;
    double larguraRelativa = larguraTela < 700 ? larguraTela : 700;
    return Column(
      children: [
        Container(
          height: altura,
          width: larguraTela,
          color: Color(personColor),
          alignment: Alignment.center,
          child: Container(
              color: Color(personColor),
              height: altura,
              width: larguraRelativa,
              padding:
                  const EdgeInsets.symmetric(horizontal: margem, vertical: 0),
              margin: const EdgeInsets.all(0),
              child: Column(children: [
                // ===================================================
                //                    Margem
                const Spacer(flex: 20),
                // ===================================================
                //           Home - text_nome_user - Config
                // verifica se o parametro initPage esta ativo caso
                // caso esteja desativa este trecho
                !initPage
                    ? Obx(() => component1(
                        config: config,
                        home: home,
                        user: instance.nome,
                        fnHome: () {
                          !home
                              ? Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => const PageHome()),
                                  (route) =>
                                      false, // Remove todas as rotas anteriores
                                )
                              : null;
                        },
                        fnConfig: () {
                          !config
                              ? navigateToPageWithReverseSlideAnimation(
                                  context, const PageConfig())
                              : null;
                        }))
                    : Container(),
                // ===================================================
                //                    Margem
                const Spacer(flex: 2),
                // ===================================================
                component2(titulo = titulo),
                // ===================================================
                //                    Margem
                const Spacer(flex: 2),
                // ===================================================
                //                    Margem
                component3(),
                // ===================================================
              ])),
        ),
        // ===================================================
        //    BTN - adicionar_produto : voltar
        // verifica se o parametro tituloButtom contem algo
        // caso contrario ele desativa este trecho
        tituloButtom.isNotEmpty
            ? component4(margem,
                fn: fnButtom, txt: tituloButtom, largura: larguraRelativa)
            : Container()
        // ===================================================
      ],
    );
  }
}

//===========================================
// Linha 1 -- BTN Home - BTN Settings
Widget component1(
    {fnHome,
    fnConfig,
    String user = '',
    bool home = false,
    bool config = false}) {
  return Expanded(
      flex: 100,
      child: Row(
        children: [
          //=======================================================
          //                  BTN - 'HOME'
          InkWell(
              onTap: () {
                fnHome();
              },
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, 4),
                        blurRadius: 8,
                        spreadRadius: 0,
                      ),
                    ],
                    shape: BoxShape.circle,
                    border: Border.all(
                        width: 2.0,
                        color: home
                            ? Colors.white.withOpacity(0.5)
                            : Colors.white)),
                child: Icon(Icons.home,
                    size: 60 / 2,
                    color: home ? Colors.white.withOpacity(0.6) : Colors.white),
              )),
          //=======================================================
          //                      Margem
          const Spacer(flex: 10),
          //=======================================================
          //           Text de identificação do 'user'
          Text(
            user,
            style: const TextStyle(color: Colors.white, fontSize: 25),
          ),
          //=======================================================
          //                      Margem
          const Spacer(flex: 100),
          //=======================================================
          //                  BTN - 'CONFIG'
          InkWell(
              onTap: () {
                fnConfig();
              },
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, 4),
                        blurRadius: 8,
                        spreadRadius: 0,
                      ),
                    ],
                    shape: BoxShape.circle,
                    border: Border.all(
                        width: 2.0,
                        color: config
                            ? Colors.white.withOpacity(0.5)
                            : Colors.white)),
                child: Icon(Icons.settings,
                    size: 60 / 2,
                    color:
                        config ? Colors.white.withOpacity(0.5) : Colors.white),
              )),
        ],
      ));
}

//===========================================
// Linha 2 - Text Apresentação da tela 'Ola seja bem vindo'
Widget component2(titulo) {
  return Expanded(
      flex: 110,
      child: Container(
        // color: Colors.green,
        alignment: Alignment.centerLeft,
        child: Text(
          titulo,
          style: const TextStyle(
              fontSize: 30, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ));
}

//=======================================================
//            Linha 3 - Margem vertical
Widget component3() {
  return Expanded(
    flex: 20,
    child: Container(
        decoration: BoxDecoration(color: Color(personColor), boxShadow: [])),
  );
}

//=================================================================
//   Linha 4 - alinhamento estetico do BTN  - 'adicionar prods'
Widget component4(double margem, {required fn, txt, largura}) {
  return SizedBox(
      height: 70,
      width: double.infinity,
      child: Stack(
        children: [
          Column(children: [
            Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        color: Color(personColor), boxShadow: []))),
            Expanded(child: Container(color: Colors.white))
          ]),
          Align(
            alignment: Alignment.center,
            child: Container(
              // color: Colors.green,
              width: largura,
              alignment: Alignment.centerLeft,
              child: Container(
                  margin: EdgeInsets.only(left: margem, top: 5),
                  child: butomAdicionarProds(fn: fn, txt: txt)),
            ),
          )
        ],
      ));
}

//=======================================================
//      widget BTN 'adicionar novo produto'
Widget butomAdicionarProds({required fn, txt = ''}) {
  return InkWell(
      onTap: () {
        fn();
      },
      child: Container(
          alignment: Alignment.center,
          height: 70,
          width: 200,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0, 4),
                  blurRadius: 8,
                  spreadRadius: 0,
                ),
              ],
              color: const Color(0xffFBFBFB),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(width: 1.0, color: const Color(0xffD6D6D6))),
          child: Text(txt,
              style:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.w500))));
}
