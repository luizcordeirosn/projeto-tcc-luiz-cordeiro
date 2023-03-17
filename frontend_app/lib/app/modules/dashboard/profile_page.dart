import 'package:flutter/material.dart';
import 'package:frontend_liga_master/app/modules/dashboard/user_dashboard_page.dart';
import 'package:frontend_liga_master/app/modules/dashboard/user_premium_dashboard_page.dart';
import 'package:frontend_liga_master/app/modules/widgets/custom_alert_dialog/custom_alert_dialog_cpf.dart';
import 'package:frontend_liga_master/app/modules/widgets/custom_alert_dialog/custom_alert_dialog_name.dart';
import 'package:frontend_liga_master/app/modules/widgets/custom_alert_dialog/custom_alert_dialog_password.dart';
import 'package:frontend_liga_master/app/modules/home/login_page.dart';
import 'package:frontend_liga_master/app/modules/widgets/custom_alert_dialog/custom_alert_dialog_email.dart';
import 'package:frontend_liga_master/app/modules/widgets/custom_alert_dialog/custom_alert_dialog_phone_number.dart';
import 'package:frontend_liga_master/app/shared/controller/profile_controller.dart';

class Profile extends StatefulWidget {
  final List usuarioLogado;
  const Profile({super.key, required this.usuarioLogado});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String popupItemValue = "";

  ProfileController profileController = ProfileController();

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
        title: Image.asset(
          "images/logo-liga-master.png",
          height: 175,
          width: 175,
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PopupMenuButton(
                color: Colors.blue,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                onSelected: (value) {
                  popupItemValue = value.toString();
                  if (popupItemValue == "dashboardValue") {
                    if (usuarioAtualizado.elementAt(6)) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserPremiumDashboard(
                                  usuarioLogado: usuarioAtualizado)));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserDashboard(
                                  usuarioLogado: usuarioAtualizado)));
                    }
                  } else if (popupItemValue == "profileValue") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Profile(
                                  usuarioLogado: usuarioAtualizado,
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
            decoration: const BoxDecoration(color: Colors.black26),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_pin_rounded,
                        color: Colors.blueGrey[700],
                        size: 84,
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 7, right: 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text(
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
                              style: const TextStyle(
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
                            icon: const Icon(
                              Icons.edit,
                              size: 25,
                            ))
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 7, right: 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text(
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
                              style: const TextStyle(
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
                            icon: const Icon(
                              Icons.edit,
                              size: 25,
                            ))
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 7, right: 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text(
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
                              style: const TextStyle(
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
                            icon: const Icon(
                              Icons.edit,
                              size: 25,
                            ))
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 7, right: 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text(
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
                              style: const TextStyle(
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
                            icon: const Icon(
                              Icons.edit,
                              size: 25,
                            ))
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 7, right: 7, top: 7),
                    child: Row(
                      children: [
                        const Text(
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
                          style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontSize: 19,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 45)),
                  const Text(
                    "Deseja alterar sua senha? ",
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 3),
                  ),
                  OutlinedButton(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(40, 12, 40, 12),
                      child: const Text(
                        "CLIQUE AQUI ",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.blueGrey[700],
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () {
                      _editarSenha();
                    },
                  ),
                ],
              ),
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
        return CustomAlertDialogName(usuarioLogado: usuarioAtualizado);
      },
    );
  }

  Future<void> _editarCpf() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CustomAlertDialogCpf(usuarioLogado: usuarioAtualizado);
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
