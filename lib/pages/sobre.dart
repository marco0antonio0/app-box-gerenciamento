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
                  ParagraphType2(
                      text:
                          'Box gerencimento é um aplicativo desenvolvido em Flutter para facilitar o gerenciamento de estoque de produtos. Com funcionalidades intuitivas e uma interface amigável, o aplicativo oferece uma solução completa para o controle de produtos, desde a adição até a alteração e exclusão.'),
                  // =======================================================================================
                  ViewImage(),
                  // =======================================================================================
                  //                           Widget - Text estilizado
                  ParagraphType2(
                      text:
                          'O projeto utiliza diversas dependências para aprimorar a experiência do usuário e garantir funcionalidades avançadas\n\n- auto_size_text: Usada para garantir a responsividade de elementos de texto.\n\n- device_preview: Utilizada para testes unitários manuais e identificação de erros relacionados à estética do UI.\n\n- sqflite: Responsável pela persistência de dados no SQLite\n\n- url_launcher: Utilizada para navegação para rotas no navegador.\n\n- get: Utilizada para o controle de estado do aplicativo.\n\n- image_picker: Implementa a funcionalidade de câmera e gerencia permissões relacionadas.\n\n- flutter_launcher_icons: Utilizada para implementar o design de ícones do aplicativo.'),
                  // =======================================================================================
                  ParagraphType2(
                      text:
                          'Para mais detalhes visite nossa pagina do projeto'),
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
