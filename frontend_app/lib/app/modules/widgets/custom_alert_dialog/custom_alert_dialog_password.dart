import 'package:flutter/material.dart';
import 'package:frontend_liga_master/app/modules/dashboard/profile_page.dart';
import 'package:frontend_liga_master/app/shared/controller/profile_controller.dart';
import 'package:frontend_liga_master/app/shared/model/usuario.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CustomAlertDialogPassword extends StatefulWidget {
  final List usuarioLogado;
  const CustomAlertDialogPassword({super.key, required this.usuarioLogado});

  @override
  State<CustomAlertDialogPassword> createState() =>
      _CustomAlertDialogPasswordState();
}

class _CustomAlertDialogPasswordState extends State<CustomAlertDialogPassword> {
  TextEditingController senhaAntigaController = TextEditingController();
  TextEditingController novaSenhaController = TextEditingController();
  TextEditingController novaSenhaNovamenteController = TextEditingController();

  ProfileController profileController = ProfileController();
  Usuario usuario = Usuario();

  List usuarioAtualizado = [];

  bool _mostrarSenha = false;

  @override
  Widget build(BuildContext context) {
    usuarioAtualizado = widget.usuarioLogado;
    return AlertDialog(
      backgroundColor: Colors.blueGrey,
      title: const Text(
        'EDITAR SENHA',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextFormField(
              controller: senhaAntigaController,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
                hintText: "Senha antiga ",
                hintStyle: TextStyle(color: Colors.black54),
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.black54,
                ),
                suffixIcon: GestureDetector(
                  child: Icon(
                    !_mostrarSenha ? Icons.visibility_off : Icons.visibility,
                    color: Colors.black54,
                  ),
                  onTap: () {
                    setState(() {
                      _mostrarSenha = !_mostrarSenha;
                      print(_mostrarSenha);
                    });
                  },
                ),
                contentPadding: EdgeInsets.all(10),
              ),
              obscureText: !_mostrarSenha,
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            TextFormField(
              controller: novaSenhaController,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
                hintText: "Nova senha ",
                hintStyle: TextStyle(color: Colors.black54),
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.black54,
                ),
                contentPadding: EdgeInsets.all(10),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            TextFormField(
              controller: novaSenhaNovamenteController,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
                hintText: "Nova senha, novamente ",
                hintStyle: TextStyle(color: Colors.black54),
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.black54,
                ),
                contentPadding: EdgeInsets.all(10),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Cancelar",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: StadiumBorder(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Padding(padding: EdgeInsets.only(right: 5)),
            OutlinedButton(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Confirmar",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: StadiumBorder(),
              ),
              onPressed: () {
                if (senhaAntigaController.text.isNotEmpty ||
                    novaSenhaController.text.isNotEmpty ||
                    novaSenhaNovamenteController.text.isNotEmpty) {
                  if (senhaAntigaController.text ==
                      usuarioAtualizado.elementAt(5)) {
                    if (novaSenhaController.text ==
                        novaSenhaNovamenteController.text) {
                      usuario.setNome(usuarioAtualizado.elementAt(1));
                      usuario.setCpf(usuarioAtualizado.elementAt(2));
                      usuario.setTelefone(usuarioAtualizado.elementAt(3));
                      usuario.setEmail(usuarioAtualizado.elementAt(4));
                      usuario.setSenha(novaSenhaController.text);

                      profileController.atualizarUsuario(
                          usuario, usuarioAtualizado.elementAt(0));

                      Future.delayed(Duration(milliseconds: 2000), () {
                        usuarioAtualizado = profileController.usuarioAtualizado;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Profile(
                                      usuarioLogado: usuarioAtualizado,
                                    )));
                      });
                    } else {
                      Alert(
                              context: context,
                              title: "ERRO",
                              desc: "Os campos de nova senha não coincidem")
                          .show();
                    }
                  } else {
                    Alert(
                            context: context,
                            title: "ERRO",
                            desc: "SENHA antiga errada")
                        .show();
                  }
                } else {
                  Alert(
                          context: context,
                          title: "ERRO",
                          desc: "Campos em branco")
                      .show();
                }
              },
            ),
          ],
        )
      ],
    );
  }
}
