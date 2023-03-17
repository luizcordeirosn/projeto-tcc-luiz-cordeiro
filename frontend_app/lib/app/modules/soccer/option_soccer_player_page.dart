import 'package:flutter/material.dart';
import 'package:frontend_liga_master/app/modules/dashboard/profile_page.dart';
import 'package:frontend_liga_master/app/modules/dashboard/user_premium_dashboard_page.dart';
import 'package:frontend_liga_master/app/modules/home/login_page.dart';
import 'package:frontend_liga_master/app/modules/widgets/custom_dropdown_button_white.dart';
import 'package:frontend_liga_master/app/modules/widgets/custom_expanded_widget.dart';
import 'package:frontend_liga_master/app/shared/controller/option_soccer_player_controller.dart';
import 'package:frontend_liga_master/app/shared/controller/round_controller.dart';
import 'package:frontend_liga_master/app/shared/controller/tornament_controller.dart';

class OptionSoccerPlayerPage extends StatefulWidget {
  final List usuarioLogado;
  const OptionSoccerPlayerPage({super.key, required this.usuarioLogado});

  @override
  State<OptionSoccerPlayerPage> createState() => _OptionSoccerPlayerPageState();
}

class _OptionSoccerPlayerPageState extends State<OptionSoccerPlayerPage> {
  TornamentController competicaoController = TornamentController();
  RoundController rodadaController = RoundController();
  OptionSoccerPlayerController opcaoJogadorController =
      OptionSoccerPlayerController();

  int? _selectedTornament;
  int? _selectedRound;
  int? _selectedOptionPlayer;

  bool isLoading = false;
  bool hasTornament = false;
  bool hasRound = false;
  bool hasOptionPlayer = false;

  int idCompeticao = 0;
  late int idRodada;
  int idTipoPosicao = 0;

  String nomeCompeticao = "";

  Future<void> _getCompeticao() async {
    setState(() => isLoading = true);
    try {
      await competicaoController.getCompeticoes();
      await opcaoJogadorController.getTiposPosicao();
    } catch (error) {
      debugPrint(error.toString());

      // CustomAlerts.showDefaultDialog(context, 'Atenção!',
      //     'Não foi possível consultar os veículos, tente novamente mais tarde.');
    }
    setState(() => isLoading = false);
  }

  Future<void> _getRodada(int id) async {
    setState(() => isLoading = true);
    try {
      dynamic result = await rodadaController.getRodadas(id);
      setState(() {
        if (result != null && rodadaController.rodadas.isNotEmpty) {
          hasRound = true;
          hasTornament = true;
          for (int i = 0; i < competicaoController.competicoes.length; i++) {
            if (competicaoController.competicoes[i]['id'] == id) {
              nomeCompeticao = competicaoController.competicoes[i]['titulo'];
            }
          }
        } else {
          hasRound = false;
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

  Future<void> _getTipoPosicao(int rodada, int competicao) async {
    setState(() => isLoading = true);
    try {
      dynamic result =
          await opcaoJogadorController.getOpcoesJogador(rodada, competicao);
      setState(() {
        if (result != null && opcaoJogadorController.opcoesJogador.isNotEmpty) {
          hasOptionPlayer = true;
        } else {
          hasOptionPlayer = false;
        }
        idTipoPosicao = 0;
        idRodada = rodada;
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
          title: Image.asset(
            "images/logo-liga-master.png",
            height: 175,
            width: 175,
          ),
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
        body: Stack(children: [
          Container(
            decoration: const BoxDecoration(color: Colors.black26),
          ),
          SafeArea(
            child: Column(
              children: [
                !hasTornament
                    ? CustomDropButton(
                        hintText: 'Competicao',
                        value: _selectedTornament,
                        items: competicaoController.competicoes
                            .map((element) => DropdownMenuItem<int>(
                                  value: element['id'],
                                  child: Text(element['titulo']),
                                ))
                            .toList(),
                        onChanged: (value) {
                          idTipoPosicao = 0;
                          _getRodada(value!);
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Campo obrigatório';
                          } else {
                            return null;
                          }
                        },
                      )
                    : Container(
                        padding:
                            const EdgeInsets.only(top: 7, left: 3, right: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              nomeCompeticao,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            OutlinedButton(
                              child: Container(
                                //padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                                child: const Text(
                                  "LIMPAR FILTRO",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    //fontSize: 17,
                                  ),
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.red[700],
                                shape: const StadiumBorder(),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            OptionSoccerPlayerPage(
                                              usuarioLogado:
                                                  widget.usuarioLogado,
                                            )));
                              },
                            ),
                          ],
                        ),
                      ),
                const Padding(padding: EdgeInsets.only(bottom: 7)),
                hasRound
                    ? CustomDropButton(
                        hintText: 'Rodada',
                        value: _selectedRound,
                        items: rodadaController.rodadas
                            .map((element) => DropdownMenuItem<int>(
                                  value: element['id'],
                                  child: Text(element['titulo']),
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (idTipoPosicao != 0) {
                            if (idTipoPosicao == 1) {
                              opcaoJogadorController.getOpcoesJogadorPosicao(
                                  value!, idCompeticao, "Goleiro");
                            } else if (idTipoPosicao == 2) {
                              opcaoJogadorController.getOpcoesJogadorPosicao(
                                  value!, idCompeticao, "Lateral");
                            } else if (idTipoPosicao == 3) {
                              opcaoJogadorController.getOpcoesJogadorPosicao(
                                  value!, idCompeticao, "Zagueiro");
                            } else if (idTipoPosicao == 4) {
                              opcaoJogadorController.getOpcoesJogadorPosicao(
                                  value!, idCompeticao, "Meio Campo");
                            } else if (idTipoPosicao == 5) {
                              opcaoJogadorController.getOpcoesJogadorPosicao(
                                  value!, idCompeticao, "Atacante");
                            }
                            Future.delayed(const Duration(milliseconds: 750),
                                () {
                              _getCompeticao();
                            });

                            idRodada = value!;
                          } else {
                            _getTipoPosicao(value!, idCompeticao);
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
                hasOptionPlayer
                    ? CustomDropButton(
                        hintText: 'Posição',
                        value: _selectedOptionPlayer,
                        items: opcaoJogadorController.tiposPosicao
                            .map((element) => DropdownMenuItem<int>(
                                  value: element['valor'],
                                  child: Text(element['descricao']),
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (value == 1) {
                            opcaoJogadorController.getOpcoesJogadorPosicao(
                                idRodada, idCompeticao, "Goleiro");
                          } else if (value == 2) {
                            opcaoJogadorController.getOpcoesJogadorPosicao(
                                idRodada, idCompeticao, "Lateral");
                          } else if (value == 3) {
                            opcaoJogadorController.getOpcoesJogadorPosicao(
                                idRodada, idCompeticao, "Zagueiro");
                          } else if (value == 4) {
                            opcaoJogadorController.getOpcoesJogadorPosicao(
                                idRodada, idCompeticao, "Meio Campo");
                          } else if (value == 5) {
                            opcaoJogadorController.getOpcoesJogadorPosicao(
                                idRodada, idCompeticao, "Atacante");
                          }
                          idTipoPosicao = value!;
                          Future.delayed(const Duration(milliseconds: 750), () {
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
                    } else if (opcaoJogadorController.opcoesJogador.isEmpty) {
                      return const CustomExpandedWidget(
                          texto:
                              "Não foi possível encontrar Dados para a sua Fitragem");
                    } else {
                      if (opcaoJogadorController
                          .opcoesJogadorPosicao.isNotEmpty) {
                        return Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.fromLTRB(16, 16, 24, 80),
                            shrinkWrap: true,
                            separatorBuilder: (context, index) => const Divider(
                              thickness: 1,
                              height: 20,
                            ),
                            itemCount: opcaoJogadorController
                                .opcoesJogadorPosicao.length,
                            itemBuilder: (_, index) {
                              var result = opcaoJogadorController
                                  .opcoesJogadorPosicao[index];
                              return melhorOpcaoJogador(result);
                            },
                          ),
                        );
                      } else {
                        return const CustomExpandedWidget(
                            texto:
                                "Não foi possível encontrar Dados para a sua Fitragem");
                      }
                    }
                  },
                ),
                const Divider(
                  thickness: 1,
                  height: 20,
                  color: Colors.black54,
                ),
                Column(
                  children: [
                    OutlinedButton(
                      child: Container(
                        //padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                        child: const Text(
                          "VOLTAR PARA TELA INICIAL",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            //fontSize: 17,
                          ),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.blueGrey[700],
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserPremiumDashboard(
                                      usuarioLogado: widget.usuarioLogado,
                                    )));
                      },
                    ),
                  ],
                )
              ],
            ),
          )
        ]));
  }

  Widget melhorOpcaoJogador(dynamic result) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox.square(
                  dimension: 75,
                  child: Image.asset('${result['jogador']['time']['escudo']}'),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox.square(
                  dimension: 75,
                  child: Image.asset('${result['jogador']['imagem']}'),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${result['jogador']['nome']}',
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 7)),
                Text(
                  '${result['posicao']}',
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      'Chance de pontuar: ',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${result['boaPontuacao']}%',
                      style: TextStyle(
                          color: Colors.green[900],
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
