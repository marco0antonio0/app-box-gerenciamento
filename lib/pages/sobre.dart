import 'package:box_estoque/components/Paragraph.dart';
import 'package:box_estoque/components/buttom.dart';
import 'package:box_estoque/components/topbar.dart';
import 'package:box_estoque/components/viewImage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PageSobre extends StatefulWidget {
  const PageSobre({super.key});

  @override
  State<PageSobre> createState() => _PageSobreState();
}

class _PageSobreState extends State<PageSobre> {
  @override
  Widget build(BuildContext context) {
    void abrirUrl() async {
      const url = 'https://github.com/marco0antonio0/app-box-gerenciamento';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    }

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
                titulo: 'Sobre\nApp',
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
                  const SizedBox(height: 10),
                  // =======================================================================================
                  //                           Widget - Text estilizado
                  ParagraphType2(titulo: 'App\nBox Gerenciamento'),
                  // =======================================================================================
                  //                                  Margem
                  const SizedBox(height: 5),
                  // =======================================================================================
                  ViewImage(),
                  // =======================================================================================
                  //                           Widget - Text estilizado
                  ParagraphType2(text: t),
                  // =======================================================================================
                  ViewImage(),
                  // =======================================================================================
                  //                           Widget - Text estilizado
                  ParagraphType2(text: t + t),
                  // =======================================================================================
                  //                                  Margem
                  const SizedBox(height: 30),
                  // =======================================================================================
                  //                           Acessar pagina do projeto
                  buttomForms(
                      titulo: 'Acessar pagina do projeto',
                      fn: () {
                        abrirUrl();
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

const t = '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras non dictum velit. Integer elit nulla, dapibus vel dolor vitae, tincidunt molestie ligula. Maecenas at enim
''';
