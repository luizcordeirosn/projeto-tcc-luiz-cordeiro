import 'package:flutter/material.dart';
import 'package:frontend_liga_master/app/modules/dashboard/profile_page.dart';
import 'package:frontend_liga_master/app/modules/dashboard/user_premium_dashboard_page.dart';
import 'package:frontend_liga_master/app/modules/home/login_page.dart';
import 'package:frontend_liga_master/app/modules/widgets/custom_dropdown_button_white.dart';
import 'package:frontend_liga_master/app/modules/widgets/custom_expanded_widget.dart';
import 'package:frontend_liga_master/app/shared/controller/match_controller.dart';
import 'package:frontend_liga_master/app/shared/controller/round_controller.dart';
import 'package:frontend_liga_master/app/shared/controller/tornament_controller.dart';

class MatchPage extends StatefulWidget {
  final List usuarioLogado;
  const MatchPage({super.key, required this.usuarioLogado});

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  TornamentController competicaoController = TornamentController();
  RoundController rodadaController = RoundController();
  MatchController confrontoController = MatchController();

  int? _selectedTornament;
  int? _selectedRound;

  bool isLoading = false;
  bool hasTornament = false;
  bool hasRound = false;

  late int idCompeticao;

  String nomeCompeticao = "";

  Future<void> _getCompeticao() async {
    setState(() => isLoading = true);
    try {
      await competicaoController.getCompeticoes();
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
          confrontoController.getConfrontos(0, 0);
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
                                        builder: (context) => MatchPage(
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
                          confrontoController.getConfrontos(
                              value!, idCompeticao);
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
                    } else if (confrontoController.confrontos.isEmpty) {
                      return const CustomExpandedWidget(
                          texto:
                              "Não foi possível encontrar Dados para a sua Fitragem");
                    } else {
                      return Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.fromLTRB(16, 16, 24, 80),
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => const Divider(
                            thickness: 1,
                            height: 20,
                          ),
                          itemCount: confrontoController.confrontos.length,
                          itemBuilder: (_, index) {
                            var result = confrontoController.confrontos[index];
                            return confrontosRodada(result);
                          },
                        ),
                      );
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

  Widget confrontosRodada(dynamic result) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Data e Horário: ${result['dataHora']}',
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 5)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox.square(
              dimension: 75,
              child: Image.asset('${result['timeMandante']['escudo']}'),
            ),
            const Padding(padding: EdgeInsets.only(left: 20)),
            result['resultado'] != null
                ? Text(
                    '${result['resultado']}',
                    style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 19),
                  )
                : const Text(
                    'x',
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 19),
                  ),
            const Padding(padding: EdgeInsets.only(right: 20)),
            SizedBox.square(
              dimension: 75,
              child: Image.asset('${result['timeVisitante']['escudo']}'),
            ),
          ],
        ),
      ],
    );
  }
}
