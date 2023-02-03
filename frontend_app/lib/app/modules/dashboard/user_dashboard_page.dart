import 'package:flutter/material.dart';
import 'package:frontend_liga_master/app/modules/dashboard/profile_page.dart';
import 'package:frontend_liga_master/app/modules/home/login_page.dart';

class UserDashboard extends StatefulWidget {
  final List usuarioLogado;
  const UserDashboard({super.key, required this.usuarioLogado});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  String popupItemValue = "";

  @override
  Widget build(BuildContext context) {
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
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Olá ${widget.usuarioLogado.elementAt(1)}  ",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                Icon(Icons.waving_hand)
              ],
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      Icon(
                        Icons.dangerous_outlined,
                        color: Colors.red,
                        size: 84,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 25, right: 25),
                        child: Column(
                          children: [
                            Text(
                              "   Percebemos que você ainda não tem um plano ativo para seu usuário. " +
                                  " Caso queira usufruir de todos as funcionalidades do aplicativo, por favor, " +
                                  " entre em contato via WhatsApp ou Email com os administradores.",
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Text(
                          "CONTATO: ",
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10, left: 25),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.call),
                            Text(
                              " +5587996544511",
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10, left: 25),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.email),
                            Text(
                              " luizcsneto@outlook.com",
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
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
            ),
          ),
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
}
