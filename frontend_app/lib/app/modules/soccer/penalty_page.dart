import 'package:flutter/material.dart';
import 'package:frontend_liga_master/app/modules/dashboard/profile_page.dart';
import 'package:frontend_liga_master/app/modules/dashboard/user_premium_dashboard_page.dart';
import 'package:frontend_liga_master/app/modules/home/login_page.dart';
import 'package:frontend_liga_master/app/modules/widgets/custom_dropdown_button_white.dart';
import 'package:frontend_liga_master/app/shared/controller/penalty_controller.dart';
import 'package:frontend_liga_master/app/shared/controller/tornament_controller.dart';

class PenaltyPage extends StatefulWidget {
  final List usuarioLogado;
  const PenaltyPage({super.key, required this.usuarioLogado});

  @override
  State<PenaltyPage> createState() => _PenaltyPageState();
}

class _PenaltyPageState extends State<PenaltyPage> {
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  TornamentController competicaoController = TornamentController();
  PenaltyController penaltiController = PenaltyController();

  int? _selectedTornament;
  int? _selectedPenalty;

  bool isLoading = false;
  bool hasPenalty = false;

  late int idCompeticao;

  Future<void> _getCompeticao() async {
    setState(() => isLoading = true);
    try {
      await competicaoController.getCompeticoes();
      await penaltiController.isCometido();
    } catch (error) {
      debugPrint(error.toString());

      // CustomAlerts.showDefaultDialog(context, 'Atenção!',
      //     'Não foi possível consultar os veículos, tente novamente mais tarde.');
    }
    setState(() => isLoading = false);
  }

  Future<void> _getPenalti(int id) async {
    setState(() => isLoading = true);
    try {
      dynamic result = await penaltiController.getPenaltis(id);
      setState(() {
        if (result != null && penaltiController.penaltis.isNotEmpty) {
          hasPenalty = true;
        } else {
          penaltiController.getPenaltisCometidosAFavor(0, 0);
          hasPenalty = false;
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
                    _getPenalti(value!);
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
                hasPenalty
                    ? CustomDropButton(
                        hintText: 'Rodada',
                        value: _selectedPenalty,
                        items: penaltiController.cometido
                            .map((element) => DropdownMenuItem<int>(
                                  value: element['valor'],
                                  child: Text(element['descricao']),
                                ))
                            .toList(),
                        onChanged: (value) {
                          penaltiController.getPenaltisCometidosAFavor(
                              value!, idCompeticao);
                          Future.delayed(Duration(milliseconds: 500), () {
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
                    } else if (penaltiController.penaltisCometidosAFavor.isEmpty) {
                      return Expanded(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.close,
                                color: Colors.red,
                                size: 64,
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                'Nenhum lance de Pênalti encontrado para este Campeonato',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.fromLTRB(16, 16, 24, 80),
                          shrinkWrap: true,
                          separatorBuilder: (context, index) =>
                              const Divider(thickness: 1, height: 20),
                          itemCount: penaltiController.penaltisCometidosAFavor.length,
                          itemBuilder: (_, index) {
                            var result = penaltiController.penaltisCometidosAFavor[index];
                            return penaltisCometidosAFavorPorCompeticao(result);
                          },
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          )
        ])
    );
  }

  Widget penaltisCometidosAFavorPorCompeticao(dynamic result) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox.square(
              dimension: 75,
              child: Image.asset('${result['time']['escudo']}'),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.only(left: 20)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Time: ${result['time']['sigla']}',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            result['cometido']
                ? Text(
                    'Penaltis cometidos: ${result['numPenaltis']}',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Text(
                    'Penaltis a favor: ${result['numPenaltis']}',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  )
          ],
        ),
      ],
    );
  }
}
