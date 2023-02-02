import 'package:flutter/material.dart';
import 'package:frontend_liga_master/app/modules/dashboard/user_dashboard_page.dart';
import 'package:frontend_liga_master/app/modules/widgets/custom_alert_dialog/custom_alert_dialog_password.dart';
import 'package:frontend_liga_master/app/modules/home/login_page.dart';
import 'package:frontend_liga_master/app/modules/widgets/custom_alert_dialog/custom_alert_dialog_email.dart';
import 'package:frontend_liga_master/app/modules/widgets/custom_alert_dialog/custom_alert_dialog_phone_number.dart';
import 'package:frontend_liga_master/app/shared/controller/profile_controller.dart';
import 'package:frontend_liga_master/app/shared/model/usuario.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
          SingleChildScrollView(
            child: Column(
              children: [
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
                  padding: EdgeInsets.only(left: 25, top: 40, right: 25),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            ],
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                          IconButton(
                              onPressed: () {
                                _editarCpf();
                              },
                              icon: Icon(
                                Icons.edit,
                                size: 25,
                              ))
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                          IconButton(
                              onPressed: () {
                                _editarTelefone();
                              },
                              icon: Icon(
                                Icons.edit,
                                size: 25,
                              ))
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                          IconButton(
                              onPressed: () {
                                _editarEmail();
                              },
                              icon: Icon(
                                Icons.edit,
                                size: 25,
                              ))
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 15)),
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
                      ),
                      Padding(padding: EdgeInsets.only(top: 30)),
                      Text(
                        "Deseja alterar sua senha? ",
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 3),
                      ),
                      OutlinedButton(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(40, 12, 40, 12),
                          child: Text(
                            "CLIQUE AQUI ",
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
                          _editarSenha();
                        },
                      ),
                    ],
                  ),
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

  Future<void> _editarCpf() async {
    TextEditingController cpfController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey,
          title: const Text(
            'EDITAR CPF',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  controller: cpfController,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black54),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Cpf ",
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
                    if (cpfController.text.isNotEmpty) {
                      usuarioAtualizarCadastro
                          .setNome(usuarioAtualizado.elementAt(1));
                      usuarioAtualizarCadastro.setCpf(cpfController.text);
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
                              desc: "Campo CPF em branco")
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

  Future<void> _editarTelefone() async {

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CustomAlertDialogPhoneNumber(usuarioLogado: usuarioAtualizado);
      },
    );
  }

  Future<void> _editarEmail() async {

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CustomAlertDialogEmail(usuarioLogado: usuarioAtualizado);
      },
    );
  }

  Future<void> _editarSenha() async {

    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CustomAlertDialogPassword(usuarioLogado: usuarioAtualizado);
      },
    );
  }
}
