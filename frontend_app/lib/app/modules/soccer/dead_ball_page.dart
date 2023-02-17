import 'package:flutter/material.dart';
import 'package:frontend_liga_master/app/modules/dashboard/profile_page.dart';
import 'package:frontend_liga_master/app/modules/dashboard/user_premium_dashboard_page.dart';
import 'package:frontend_liga_master/app/modules/home/login_page.dart';
import 'package:frontend_liga_master/app/modules/widgets/custom_dropdown_button_white.dart';
import 'package:frontend_liga_master/app/modules/widgets/custom_expanded_widget.dart';
import 'package:frontend_liga_master/app/shared/controller/dead_ball_controller.dart';
import 'package:frontend_liga_master/app/shared/controller/soccer_player_controller.dart';
import 'package:frontend_liga_master/app/shared/controller/soccer_team_controller.dart';
import 'package:frontend_liga_master/app/shared/controller/tornament_controller.dart';

class DeadBallPage extends StatefulWidget {
  final List usuarioLogado;
  const DeadBallPage({super.key, required this.usuarioLogado});

  @override
  State<DeadBallPage> createState() => _DeadBallPageState();
}

class _DeadBallPageState extends State<DeadBallPage> {
  TornamentController competicaoController = TornamentController();
  SoccerTeamController timeFutebolController = SoccerTeamController();
  SoccerPlayerController jogadorFutebolController = SoccerPlayerController();
  DeadBallController bolaParadaController = DeadBallController();

  int? _selectedTornament;
  int? _selectedSoccerTeam;
  int? _selectedDeadBall;

  bool isLoading = false;
  bool hasSoccerTeam = false;
  bool hasSoccerPlayer = false;

  late int idCompeticao;
  late int idTime;
  int idTipoBolaParada = 0;

  Future<void> _getCompeticao() async {
    setState(() => isLoading = true);
    try {
      await competicaoController.getCompeticoes();
      await bolaParadaController.getTiposBolaParada();
    } catch (error) {
      debugPrint(error.toString());

      // CustomAlerts.showDefaultDialog(context, 'Atenção!',
      //     'Não foi possível consultar os veículos, tente novamente mais tarde.');
    }
    setState(() => isLoading = false);
  }

  Future<void> _getTimeFutebol(int id) async {
    setState(() => isLoading = true);
    try {
      dynamic result = await timeFutebolController.getTimes(id);
      setState(() {
        if (result != null && timeFutebolController.times.isNotEmpty) {
          hasSoccerTeam = true;
        } else {
          jogadorFutebolController.getJogadores(0, 0);
          hasSoccerTeam = false;
          hasSoccerPlayer = false;
        }
        idCompeticao = id;
      });
    } catch (error) {
      debugPrint(error.toString());

      // CustomAlerts.showDefaultDialog(context, 'Atenção!',
      //     'Não foi possível consultar os veículos, tente novamente mais tarde.');
    }
    setState(() => isLoading = false);
  }

  Future<void> _getTipoBolaParadaPorTime(int time, int competicao) async {
    setState(() => isLoading = true);
    try {
      dynamic result =
          await jogadorFutebolController.getJogadores(time, competicao);
      setState(() {
        if (result != null && jogadorFutebolController.jogadores.isNotEmpty) {
          hasSoccerPlayer = true;
        } else {
          hasSoccerPlayer = false;
        }
        idTipoBolaParada = 0;
        idTime = time;
      });
    } catch (error) {
      debugPrint(error.toString());

      // CustomAlerts.showDefaultDialog(context, 'Atenção!',
      //     'Não foi possível consultar os veículos, tente novamente mais tarde.');
    }
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    _getCompeticao();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String popupItemValue = "";

    return Scaffold(
        appBar: AppBar(
          title: Text("Bola Parada"),
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
        body: Stack(children: [
          Container(
            decoration: BoxDecoration(color: Colors.black26),
          ),
          SafeArea(
            child: Column(
              children: [
                CustomDropButton(
                  hintText: 'Competicao',
                  value: _selectedTornament,
                  items: competicaoController.competicoes
                      .map((element) => DropdownMenuItem<int>(
                            value: element['id'],
                            child: Text(element['titulo']),
                          ))
                      .toList(),
                  onChanged: (value) {
                    idTipoBolaParada = 0;
                    _getTimeFutebol(value!);
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Campo obrigatório';
                    } else {
                      return null;
                    }
                  },
                ),
                const Padding(padding: EdgeInsets.only(bottom: 7)),
                hasSoccerTeam
                    ? CustomDropButton(
                        hintText: 'Times',
                        value: _selectedSoccerTeam,
                        items: timeFutebolController.times
                            .map((element) => DropdownMenuItem<int>(
                                  value: element['id'],
                                  child: Text(element['titulo']),
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (idTipoBolaParada != 0) {
                            if (idTipoBolaParada == 1) {
                              bolaParadaController.getBatedoresFalta(
                                  value!, idCompeticao);
                            } else if (idTipoBolaParada == 2) {
                              bolaParadaController.getBatedoresEscanteio(
                                  value!, idCompeticao);
                            } else if (idTipoBolaParada == 3) {
                              bolaParadaController.getBatedoresPenalti(
                                  value!, idCompeticao);
                            }
                            Future.delayed(Duration(milliseconds: 750), () {
                              _getCompeticao();
                            });

                            idTime = value!;
                          } else {
                            _getTipoBolaParadaPorTime(value!, idCompeticao);
                          }
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Campo obrigatório';
                          } else {
                            return null;
                          }
                        },
                      )
                    : Container(),
                const Padding(padding: EdgeInsets.only(bottom: 7)),
                hasSoccerPlayer
                    ? CustomDropButton(
                        hintText: 'Bola Parada',
                        value: _selectedDeadBall,
                        items: bolaParadaController.tiposBolaParada
                            .map((element) => DropdownMenuItem<int>(
                                  value: element['valor'],
                                  child: Text(element['descricao']),
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (value == 1) {
                            bolaParadaController.getBatedoresFalta(
                                idTime, idCompeticao);
                          } else if (value == 2) {
                            bolaParadaController.getBatedoresEscanteio(
                                idTime, idCompeticao);
                          } else if (value == 3) {
                            bolaParadaController.getBatedoresPenalti(
                                idTime, idCompeticao);
                          }
                          idTipoBolaParada = value!;
                          Future.delayed(Duration(milliseconds: 750), () {
                            _getCompeticao();
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Campo obrigatório';
                          } else {
                            return null;
                          }
                        },
                      )
                    : Container(),
                Builder(
                  builder: (context) {
                    if (isLoading) {
                      return const Expanded(
                          child: Center(child: CircularProgressIndicator()));
                    } else if (jogadorFutebolController.jogadores.isEmpty) {
                      return const CustomExpandedWidget(
                          texto:
                              "Não foi possível encontrar nenhum Time, Jogador e/ou Batedor de bola parada "
                                  "para os dados solicitados");
                    } else {
                      if (idTipoBolaParada == 1 &&
                          bolaParadaController.batedoresFalta.isNotEmpty) {
                        return Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.fromLTRB(16, 16, 24, 80),
                            shrinkWrap: true,
                            separatorBuilder: (context, index) =>
                                const Divider(thickness: 1, height: 20),
                            itemCount:
                                bolaParadaController.batedoresFalta.length,
                            itemBuilder: (_, index) {
                              var result =
                                  bolaParadaController.batedoresFalta[index];
                              return batedoresBolaParadaTime(result);
                            },
                          ),
                        );
                      } else if (idTipoBolaParada == 2 &&
                          bolaParadaController.batedoresEscanteio.isNotEmpty) {
                        return Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.fromLTRB(16, 16, 24, 80),
                            shrinkWrap: true,
                            separatorBuilder: (context, index) =>
                                const Divider(thickness: 1, height: 20),
                            itemCount:
                                bolaParadaController.batedoresEscanteio.length,
                            itemBuilder: (_, index) {
                              var result = bolaParadaController
                                  .batedoresEscanteio[index];
                              return batedoresBolaParadaTime(result);
                            },
                          ),
                        );
                      } else if (idTipoBolaParada == 3 &&
                          bolaParadaController.batedoresPenalti.isNotEmpty) {
                        return Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.fromLTRB(16, 16, 24, 80),
                            shrinkWrap: true,
                            separatorBuilder: (context, index) =>
                                const Divider(thickness: 1, height: 20),
                            itemCount:
                                bolaParadaController.batedoresPenalti.length,
                            itemBuilder: (_, index) {
                              var result =
                                  bolaParadaController.batedoresPenalti[index];
                              return batedoresBolaParadaTime(result);
                            },
                          ),
                        );
                      } else {
                        return const CustomExpandedWidget(
                            texto:
                                "Não foi possível encontrar nenhum Time, Jogador e/ou Batedor de bola "
                                    "parada para os dados solicitados");
                      }
                    }
                  },
                ),
              ],
            ),
          )
        ]));
  }

  Widget batedoresBolaParadaTime(dynamic result) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox.square(
              dimension: 75,
              child: Image.asset('${result['jogador']['imagem']}'),
            ),
          ],
        ),
        //Padding(padding: EdgeInsets.only(left: 20)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nome: ${result['jogador']['nome']}',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Posicao: ${result['jogador']['posicao']}',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Gols: ${result['jogador']['gols']} e Ass: ${result['jogador']['assistencias']}',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
