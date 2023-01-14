import 'package:flutter/material.dart';
import 'package:frontend_liga_master/app/modules/dashboard/user_dashboard_page.dart';
import 'package:frontend_liga_master/app/shared/controller/profile_controller.dart';
import 'package:frontend_liga_master/app/shared/model/usuario.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../home/login_page.dart';

class Profile extends StatefulWidget {
  final List usuarioLogado;
  const Profile({super.key, required this.usuarioLogado});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String popupItemValue = "";

  ProfileController profileController = ProfileController();
  Usuario usuarioAtualizarCadastro = Usuario();

  List usuarioAtualizado = [];

  @override
  Widget build(BuildContext context) {
    usuarioAtualizado = widget.usuarioLogado;

    String _nome = usuarioAtualizado.elementAt(1);
    String _cpf = usuarioAtualizado.elementAt(2);
    String _telefone = usuarioAtualizado.elementAt(3);
    String _email = usuarioAtualizado.elementAt(4);
    bool _planoAtivo = usuarioAtualizado.elementAt(6);

    return Scaffold(
      appBar: AppBar(
        title: Text("Liga Master"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        automaticallyImplyLeading: false,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PopupMenuButton(
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                onSelected: (value) {
                  popupItemValue = value.toString();
                  if (popupItemValue == "dashboardValue") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserDashboard(
                                usuarioLogado: widget.usuarioLogado)));
                  } else if (popupItemValue == "profileValue") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Profile(
                                  usuarioLogado: widget.usuarioLogado,
                                )));
                  } else if (popupItemValue == "exitValue") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginStateful()));
                  }
                },
                itemBuilder: (BuildContext bc) {
                  return const [
                    PopupMenuItem(
                      child: Text(
                        "Dashboard",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      value: "dashboardValue",
                    ),
                    PopupMenuItem(
                      child: Text(
                        "Perfil",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      value: "profileValue",
                    ),
                    PopupMenuItem(
                      child: Text(
                        "Sair",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      value: "exitValue",
                    )
                  ];
                },
              )
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.grey),
          ),
          Center(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 25)),
                Icon(
                  Icons.person_pin_rounded,
                  color: Colors.blueGrey,
                  size: 84,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 25, top: 120),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "NOME: ",
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      "${_nome} ",
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 19,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    IconButton(
                        onPressed: () {
                          _editarNome();
                        },
                        icon: Icon(
                          Icons.edit,
                          size: 25,
                        ))
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 5)),
                Row(
                  children: [
                    Text(
                      "CPF: ",
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      "${_cpf}",
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 19,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 5)),
                Row(
                  children: [
                    Text(
                      "TELEFONE: ",
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      "${_telefone}",
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 19,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 5)),
                Row(
                  children: [
                    Text(
                      "EMAIL: ",
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      "${_email}",
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 19,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 5)),
                Row(
                  children: [
                    Text(
                      "PLANO ATIVO: ",
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      "${_planoAtivo} ",
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 19,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _editarNome() async {
    TextEditingController nomeController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
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
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black54),
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
                      usuarioAtualizarCadastro.setNome(nomeController.text);
                      usuarioAtualizarCadastro
                          .setCpf(usuarioAtualizado.elementAt(2));
                      usuarioAtualizarCadastro
                          .setTelefone(usuarioAtualizado.elementAt(3));
                      usuarioAtualizarCadastro
                          .setEmail(usuarioAtualizado.elementAt(4));
                      usuarioAtualizarCadastro
                          .setSenha(usuarioAtualizado.elementAt(5));

                      profileController.atualizarUsuario(
                          usuarioAtualizarCadastro,
                          usuarioAtualizado.elementAt(0));

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
      },
    );
  }
}
