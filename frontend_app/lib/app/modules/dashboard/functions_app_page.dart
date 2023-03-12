import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:frontend_liga_master/app/modules/dashboard/profile_page.dart';
import 'package:frontend_liga_master/app/modules/dashboard/user_premium_dashboard_page.dart';
import 'package:frontend_liga_master/app/modules/home/login_page.dart';

class FunctionsAppPage extends StatefulWidget {
  final List usuarioLogado;
  const FunctionsAppPage({super.key, required this.usuarioLogado});

  @override
  State<FunctionsAppPage> createState() => _FunctionsAppPageState();
}

class _FunctionsAppPageState extends State<FunctionsAppPage> {
  String popupItemValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sobre o App"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        automaticallyImplyLeading: false,
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
            decoration: const BoxDecoration(color: Colors.black26),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(" "),
                  const Text(
                    "FUNCIONALIDES DO APLICATIVO",
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 25)),
                  Container(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Column(
                      children: [
                        Text(
                          "   Nesta tela será mostrado todas as funcionalidades presentes em cada um dos botões "
                          "encontrados em seu dashboard, ${widget.usuarioLogado.elementAt(1)}.",
                          style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        const Padding(padding: EdgeInsets.only(top: 25)),
                        Row(
                          children: [
                            const Image(
                              image: AssetImage("images/icons-tournament.png"),
                              height: 35,
                              width: 35,
                            ),
                            const Text(
                              " Escalação do Campeonato: ",
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        const Text(
                          " - Irá mostrar a classificação de todos os times do campeonato "
                          "selecionado, como também os últimos 5 resultados de cada um deles.",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              fontStyle: FontStyle.italic),
                          textAlign: TextAlign.justify,
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        Row(
                          children: [
                            const Image(
                              image: AssetImage("images/icons-score-board.png"),
                              height: 35,
                              width: 35,
                            ),
                            const Text(
                              " Confrontos da Rodada: ",
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        const Text(
                          " - Irá mostrar todos os confrontos da rodada em questão, dependendo do "
                          "campeonato selecionado.",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              fontStyle: FontStyle.italic),
                          textAlign: TextAlign.justify,
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        Row(
                          children: [
                            const Image(
                              image: AssetImage("images/icons-board-strategy.png"),
                              height: 35,
                              width: 35,
                            ),
                            const Text(
                              " Relatorio de Gols: ",
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        const Text(
                          " - Irá mostrar o relatório de gols (Bola Parada, Pênalti e Gols tomados pelo "
                          "meio e pontas) das 5 últimas rodadas do time como mandante e visitante.",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              fontStyle: FontStyle.italic),
                          textAlign: TextAlign.justify,
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        Row(
                          children: [
                            const Image(
                              image: AssetImage("images/icons-football-player.png"),
                              height: 35,
                              width: 35,
                            ),
                            const Text(
                              " Info Jogadores: ",
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        const Text(
                          " - Irá mostrar informações de todos os jogadores pelo clube selecionado.",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              fontStyle: FontStyle.italic),
                          textAlign: TextAlign.justify,
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        Row(
                          children: [
                            const Image(
                              image: AssetImage("images/icons-penalty.png"),
                              height: 35,
                              width: 35,
                            ),
                            const Text(
                              " Estatísticas de Pênalti: ",
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        const Text(
                          " - Irá mostrar as estatísticas de pênalti (Cometidos ou A Favor) de todos os "
                          "times do campeonato selecionado.",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              fontStyle: FontStyle.italic),
                          textAlign: TextAlign.justify,
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        Row(
                          children: [
                            const Image(
                              image: AssetImage("images/icons-kick-ball.png"),
                              height: 35,
                              width: 35,
                            ),
                            const Text(
                              " Bola Parada: ",
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        const Text(
                          " - Irá mostrar quem são os batedores de bola parada (Falta, Escanteio e Pênalti) de cada um "
                          "dos times, em um determinado campeonato.",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              fontStyle: FontStyle.italic),
                          textAlign: TextAlign.justify,
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        Row(
                          children: [
                            const Image(
                              image: AssetImage("images/icons-soccer-equipment.png"),
                              height: 35,
                              width: 35,
                            ),
                            const Text(
                              " Melhores Opções: ",
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        const Text(
                          " - Irá mostrar as melhores opções bem como também as chances de boa pontuação "
                          " de jogadores para você poder escalar na rodada do campeonato em questão.",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              fontStyle: FontStyle.italic),
                          textAlign: TextAlign.justify,
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        Row(
                          children: [
                            const Image(
                              image: AssetImage("images/icons-formation.png"),
                              height: 35,
                              width: 35,
                            ),
                            const Text(
                              " Escalacao da Rodada: ",
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        const Text(
                          " - Irá mostrar a escalação do time Pay2Lose FC para a rodada do campeonato "
                          "selecionado.",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              fontStyle: FontStyle.italic),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
