import 'package:flutter/material.dart';
import 'package:frontend_liga_master/app/modules/dashboard/profile_page.dart';
import 'package:frontend_liga_master/app/shared/controller/profile_controller.dart';
import 'package:frontend_liga_master/app/shared/model/user.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CustomAlertDialogName extends StatefulWidget {
  final List usuarioLogado;
  const CustomAlertDialogName({super.key, required this.usuarioLogado});

  @override
  State<CustomAlertDialogName> createState() => _CustomAlertDialogNameState();
}

class _CustomAlertDialogNameState extends State<CustomAlertDialogName> {
  TextEditingController nomeController = TextEditingController();

  ProfileController profileController = ProfileController();
  Usuario usuario = Usuario();

  List usuarioAtualizado = [];

  @override
  Widget build(BuildContext context) {
    usuarioAtualizado = widget.usuarioLogado;
    return AlertDialog(
      backgroundColor: Colors.blueGrey,
      title: const Text(
        'EDITAR NOME',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextFormField(
              controller: nomeController,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
                hintText: "Nome ",
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
                if (nomeController.text.isNotEmpty) {
                  usuario.setNome(nomeController.text);
                  usuario.setCpf(usuarioAtualizado.elementAt(2));
                  usuario.setTelefone(usuarioAtualizado.elementAt(3));
                  usuario.setEmail(usuarioAtualizado.elementAt(4));
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
                          desc: "Campo NOME em branco")
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
