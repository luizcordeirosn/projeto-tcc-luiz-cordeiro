import 'package:flutter/material.dart';
import 'package:frontend_liga_master/app/modules/dashboard/profile_page.dart';
import 'package:frontend_liga_master/app/modules/home/login_page.dart';
import 'package:frontend_liga_master/app/modules/soccer/classification_page.dart';
import 'package:frontend_liga_master/app/modules/soccer/match_page.dart';
import 'package:frontend_liga_master/app/modules/widgets/alternative_home_button_widget.dart';

class UserPremiumDashboard extends StatefulWidget {
  final List usuarioLogado;
  const UserPremiumDashboard({super.key, required this.usuarioLogado});

  @override
  State<UserPremiumDashboard> createState() => _UserPremiumDashboardState();
}

class _UserPremiumDashboardState extends State<UserPremiumDashboard> {
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
                            builder: (context) => UserPremiumDashboard(
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
            decoration: BoxDecoration(color: Colors.black26),
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
          Container(
            padding: EdgeInsets.fromLTRB(10, 45, 10, 0),
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.97),
              children: [
                AlternativeHomeButtonWidget(
                    buttonName: "Classificação",
                    image: 'images/icons-score-board.png',
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ClassificationPage(usuarioLogado: widget.usuarioLogado,)))),
                AlternativeHomeButtonWidget(
                    buttonName: "Confrontos da Rodada",
                    image: 'images/icons-stadium.png',
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MatchPage(usuarioLogado: widget.usuarioLogado,)))),
                AlternativeHomeButtonWidget(
                    buttonName: "Info Jogadores",
                    image: 'images/icons-football-player.png',
                    onPressed: () {
                      print("Info Jogadores");
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
