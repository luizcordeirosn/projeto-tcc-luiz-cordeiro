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
  bool hasRound = false;

  late int idCompeticao;

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
          title: Text("Confrontos da Rodada"),
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
                    _getRodada(value!);
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
                    } else if (confrontoController.confrontos.isEmpty) {
                      return const CustomExpandedWidget(texto: "Nenhum Confronto encontrado para este "
                          "Campeonato ou Rodada");
                    } else {
                      return Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.fromLTRB(16, 16, 24, 80),
                          shrinkWrap: true,
                          separatorBuilder: (context, index) =>
                              const Divider(thickness: 1, height: 20),
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
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(padding: EdgeInsets.only(bottom: 5)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox.square(
              dimension: 75,
              child: Image.asset('${result['timeMandante']['escudo']}'),
            ),
            Padding(padding: EdgeInsets.only(left: 20)),
            result['resultado'] != null
                ? Text(
                    '${result['resultado']}',
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 19),
                  )
                : Text(
                    'x',
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 19),
                  ),
            Padding(padding: EdgeInsets.only(right: 20)),
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
