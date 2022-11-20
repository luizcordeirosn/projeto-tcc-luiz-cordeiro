import 'package:flutter/material.dart';
import 'package:frontend_liga_master/app/modules/home/login_page.dart';
import 'package:frontend_liga_master/app/shared/model/usuario.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../shared/controller/registro_controller.dart';

class RegistroStateful extends StatefulWidget {
  const RegistroStateful({super.key});

  @override
  State<RegistroStateful> createState() => _RegistroStatefulState();
}

class _RegistroStatefulState extends State<RegistroStateful> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  RegistroController registroController = RegistroController();
  Usuario usuarioCadastro = Usuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liga Master"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/stadium.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(children: [
              Padding(padding: EdgeInsets.only(top: 55)),
              Text(
                "REGISTRE-SE",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              Text(
                "Crie sua conta. É de graça.",
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ]),
          ),
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 230,
                height: 40,
                child: TextFormField(
                  controller: nomeController,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    hintText: "Nome *",
                    hintStyle: TextStyle(color: Colors.black54),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.black54,
                    ),
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              SizedBox(
                width: 230,
                height: 40,
                child: TextFormField(
                  controller: cpfController,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    hintText: "Cpf *",
                    hintStyle: TextStyle(color: Colors.black54),
                    prefixIcon: Icon(
                      Icons.info,
                      color: Colors.black54,
                    ),
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              SizedBox(
                width: 230,
                height: 40,
                child: TextFormField(
                  controller: telefoneController,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    hintText: "Telefone",
                    hintStyle: TextStyle(color: Colors.black54),
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Colors.black54,
                    ),
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              SizedBox(
                width: 230,
                height: 40,
                child: TextFormField(
                  controller: emailController,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    hintText: "Email *",
                    hintStyle: TextStyle(color: Colors.black54),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.black54,
                    ),
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              SizedBox(
                width: 230,
                height: 40,
                child: TextFormField(
                  controller: senhaController,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    hintText: "Senha *",
                    hintStyle: TextStyle(color: Colors.black54),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.black54,
                    ),
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              OutlinedButton(
                child: Container(
                  padding: EdgeInsets.fromLTRB(40, 12, 40, 12),
                  child: Text(
                    "REGISTRAR",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  shape: StadiumBorder(),
                ),
                onPressed: () {
                  verificarDadosCadastro();
                },
              )
            ],
          ))
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          child: Container(
        decoration: BoxDecoration(color: Colors.blueAccent),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "@copyright",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
            Padding(
              padding: EdgeInsets.all(12),
            )
          ],
        ),
      )),
    );
  }

  void verificarDadosCadastro() {
    List dadosFaltantes = [];
    String aux = "";

    if (nomeController.text.isNotEmpty &&
        cpfController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        senhaController.text.isNotEmpty) {
      usuarioCadastro.setNome(nomeController.text);
      usuarioCadastro.setCpf(cpfController.text);
      usuarioCadastro.setTelefone(telefoneController.text);
      usuarioCadastro.setEmail(emailController.text);
      usuarioCadastro.setSenha(senhaController.text);

      registroController.registro(usuarioCadastro);

      Future.delayed(Duration(milliseconds: 1000), () {
        Alert(
                context: context,
                title: "PARABÉNS",
                desc:
                    "O usuário ${usuarioCadastro.getNome()} foi cadastrado com sucesso. ")
            .show();
      });

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginStateful()));
    } else {
      dadosFaltantes.clear();

      if (nomeController.text.isEmpty) {
        dadosFaltantes.add("Nome");
      }
      if (cpfController.text.isEmpty) {
        dadosFaltantes.add("Cpf");
      }
      if (emailController.text.isEmpty) {
        dadosFaltantes.add("Email");
      }
      if (senhaController.text.isEmpty) {
        dadosFaltantes.add("Senha");
      }

      aux = "";

      for (var i = 0; i < dadosFaltantes.length; i++) {
        if (i == dadosFaltantes.length - 2) {
          aux = aux + dadosFaltantes[i] + " e ";
        } else if (i == dadosFaltantes.length - 1) {
          aux = aux + dadosFaltantes[i] + ".";
        } else {
          aux = aux + dadosFaltantes[i] + ", ";
        }
      }

      Alert(
              context: context,
              title: "ERRO",
              desc: "Preencha os seguintes campos: ${aux}")
          .show();
    }
  }
}
