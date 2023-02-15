import 'package:flutter/material.dart';
import 'package:frontend_liga_master/app/modules/widgets/custom_dropdown_button_white.dart';
import 'package:frontend_liga_master/app/shared/controller/classification_controller.dart';
import 'package:frontend_liga_master/app/shared/controller/tornament_controller.dart';

class ClassificationPage extends StatefulWidget {
  const ClassificationPage({super.key});

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

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liga Master"),
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
                  classificacaoController.getClassificacao(value!);
                  Future.delayed(Duration(milliseconds: 500), () {
                    print(classificacaoController.classificacao);
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
              ),
              Builder(
                builder: (context) {
                  if (isLoading) {
                    return const Expanded(
                        child: Center(child: CircularProgressIndicator()));
                  } else if (classificacaoController.classificacao.isEmpty) {
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
                              'Nenhum Campeonato encontrado',
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
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
            ],
          ),
        )
      ]),
    );
  }

  Widget classificacaoTime(dynamic result) {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.center,
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
        Padding(padding: EdgeInsets.only(right: 20)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Posição: ${result['posicao']}º',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Time: ${result['time']['sigla']}',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Pontos: ${result['pontos']}',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.only(right: 20)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'V: ${result['numVitorias']}',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'SG: ${result['saldoGol']}',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Recentes: ${result['resultadosRecentes']}',
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
