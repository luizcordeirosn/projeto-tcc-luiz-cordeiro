import 'package:flutter/material.dart';
import 'package:frontend_liga_master/app/modules/widgets/custom_dropdown_button_white.dart';
import 'package:frontend_liga_master/app/shared/controller/match_controller.dart';
import 'package:frontend_liga_master/app/shared/controller/round_controller.dart';
import 'package:frontend_liga_master/app/shared/controller/tornament_controller.dart';

class MatchPage extends StatefulWidget {
  const MatchPage({super.key});

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

  Future<void> _getData() async {
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
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Liga Master"),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
          automaticallyImplyLeading: false,
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
                const SizedBox(height: 16),
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
                          Future.delayed(Duration(milliseconds: 500), () {
                            _getData();
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
                                'Nenhuma Tabela encontrada para este Campeonato',
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
                      fontSize: 19
                    ),
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
