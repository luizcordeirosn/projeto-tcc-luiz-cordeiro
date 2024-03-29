import 'package:flutter/material.dart';
import 'package:frontend_liga_master/app/modules/dashboard/profile_page.dart';
import 'package:frontend_liga_master/app/modules/dashboard/user_premium_dashboard_page.dart';
import 'package:frontend_liga_master/app/modules/home/login_page.dart';
import 'package:frontend_liga_master/app/modules/widgets/custom_dropdown_button_white.dart';
import 'package:frontend_liga_master/app/modules/widgets/custom_expanded_widget.dart';
import 'package:frontend_liga_master/app/shared/controller/classification_controller.dart';
import 'package:frontend_liga_master/app/shared/controller/tornament_controller.dart';

class ClassificationPage extends StatefulWidget {
  final List usuarioLogado;
  const ClassificationPage({super.key, required this.usuarioLogado});

  @override
  State<ClassificationPage> createState() => _ClassificationPageState();
}

class _ClassificationPageState extends State<ClassificationPage> {
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  TornamentController competicaoController = TornamentController();
  ClassificationController classificacaoController = ClassificationController();

  int? _selectedTornament;

  bool isLoading = false;

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
                  classificacaoController.getClassificacao(value!);
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
              ),
              Builder(
                builder: (context) {
                  if (isLoading) {
                    return const Expanded(
                        child: Center(child: CircularProgressIndicator()));
                  } else if (classificacaoController.classificacao.isEmpty) {
                    return const CustomExpandedWidget(
                        texto:
                            "Não foi possível encontrar uma Classificação a partir do parâmetro passado "
                              "no filtro");
                  } else {
                    return Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 16, 24, 80),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => const Divider(
                          thickness: 1,
                          height: 20,
                        ),
                        itemCount: classificacaoController.classificacao.length,
                        itemBuilder: (_, index) {
                          var result =
                              classificacaoController.classificacao[index];
                          return classificacaoTime(result);
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
                    child: const Text(
                      "VOLTAR PARA TELA INICIAL",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        //fontSize: 17,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ]),
    );
  }

  Widget classificacaoTime(dynamic result) {
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
        const Padding(padding: EdgeInsets.only(left: 20)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Posição: ${result['posicao']}º',
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Time: ${result['time']['sigla']}',
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Pontos: ${result['pontos']}',
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const Padding(padding: EdgeInsets.only(right: 20)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'V: ${result['numVitorias']}',
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'SG: ${result['saldoGol']}',
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Recentes: ${result['resultadosRecentes']}',
              style: const TextStyle(
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
