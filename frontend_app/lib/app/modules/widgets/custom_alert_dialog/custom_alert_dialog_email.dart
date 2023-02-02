import 'package:flutter/material.dart';
import 'package:frontend_liga_master/app/modules/dashboard/profile_page.dart';
import 'package:frontend_liga_master/app/shared/controller/profile_controller.dart';
import 'package:frontend_liga_master/app/shared/model/usuario.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CustomAlertDialogEmail extends StatefulWidget {
  final List usuarioLogado;
  const CustomAlertDialogEmail({super.key, required this.usuarioLogado});

  @override
  State<CustomAlertDialogEmail> createState() =>
      _CustomAlertDialogEmailState();
}

class _CustomAlertDialogEmailState
    extends State<CustomAlertDialogEmail> {
  TextEditingController emailController = TextEditingController();

  ProfileController profileController = ProfileController();
  Usuario usuario = Usuario();

  List usuarioAtualizado = [];

  @override
  Widget build(BuildContext context) {
    usuarioAtualizado = widget.usuarioLogado;
    return AlertDialog(
      backgroundColor: Colors.blueGrey,
      title: const Text(
        'EDITAR EMAIL',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextFormField(
              controller: emailController,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
                hintText: "Email ",
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
                if (emailController.text.isNotEmpty) {
                  usuario.setNome(usuarioAtualizado.elementAt(1));
                  usuario.setCpf(usuarioAtualizado.elementAt(2));
                  usuario.setTelefone(usuarioAtualizado.elementAt(3));
                  usuario.setEmail(emailController.text);
                  usuario.setSenha(usuarioAtualizado.elementAt(5));

                  profileController.atualizarUsuario(
                      usuario, usuarioAtualizado.elementAt(0));

                  Future.delayed(Duration(milliseconds: 1000), () {
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
                          desc: "Campo TELEFONE em branco")
                      .show();
                }
              },
            ),
          ],
        )
      ],
    );
    ;
  }
}
