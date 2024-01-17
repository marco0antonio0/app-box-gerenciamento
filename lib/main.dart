// ignore_for_file: prefer_const_constructors, use_build_context_synchronously
import 'package:box_estoque/model/EstoqueDatabase.dart';
import 'package:box_estoque/model/UserModel.dart';
import 'package:box_estoque/pages/cadastroUser.dart';
import 'package:box_estoque/pages/home.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//=======================================
//           Função nova
//      camera acessos a fotos
final FetueareCamera = false;
//=======================================
// debugMode:
// refere-se a adaptação da tela em
// diversos cenarios
final debugMode = false;
//
//
//=======================================
void main() {
  runApp(
    debugMode
        ? DevicePreview(
            builder: (_) => MyApp(),
          )
        : MaterialApp(
            home: Redirect(),
          ),
  );
}

// ===========================================
//        Mode Debug
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),
      home: Redirect(),
    );
  }
}

class Redirect extends StatefulWidget {
  Redirect({Key? key}) : super(key: key);

  @override
  State<Redirect> createState() => _RedirectState();
}

class _RedirectState extends State<Redirect> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _redirect();
  }

  void _redirect() async {
    final UserModel instance = Get.put(UserModel());
    EstoqueDatabase estoqueDB = EstoqueDatabase.instance;

    try {
      // Verificar se o widget ainda está montado antes de continuar
      if (!mounted) return;

      List<Map<String, dynamic>> usuarios = await estoqueDB.getAllUsuarios();
      await Future.delayed(Duration(seconds: 4));

      // Verificar novamente se o widget ainda está montado
      if (!mounted) return;

      if (usuarios.isNotEmpty) {
        instance.nome = usuarios[0]['nome'];
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => PageHome()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => PageCadastroUser()),
        );
      }
    } catch (e) {
      // Tratar erros, se necessário
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: telaCarregamento(),
      ),
    );
  }
}

Widget telaCarregamento() {
  return Container(
    width: double.infinity,
    color: Color(0xff2D2B25),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text('Box',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 50)),
        SizedBox(height: 0),
        Text('Gerenciamento',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 30)),
        SizedBox(height: 10),
        Image(image: AssetImage('images/iconBox.png')),
        SizedBox(height: 30),
        CircularProgressIndicator(
          color: Colors.white,
        ),
      ],
    ),
  );
}
