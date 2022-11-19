import 'package:flutter/material.dart';
import 'package:frontend_liga_master/app/modules/home/login_page.dart';
import 'package:frontend_liga_master/app/shared/model/usuario.dart';
import 'package:frontend_liga_master/app/shared/repository/registro_repository.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RegistroStateful extends StatefulWidget {
  const RegistroStateful({super.key});

  @override
  State<RegistroStateful> createState() => _RegistroStatefulState();
}

class _RegistroStatefulState extends State<RegistroStateful> {

  TextEditingController nomeController =  TextEditingController();
  TextEditingController cpfController =  TextEditingController();
  TextEditingController telefoneController = TextEditingController();
  TextEditingController emailController =  TextEditingController();
  TextEditingController senhaController =  TextEditingController();

  RegistroRepository registroRepository = RegistroRepository();
  Usuario usuarioCadastro = Usuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liga Master"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/stadium.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 200,
                    child: TextField(
                      controller: nomeController,
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        hintText: "Nome*",
                      ),
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 10
                  )
                ),
                    SizedBox(
                    width: 200,
                    child: TextField(
                      controller: cpfController,
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        hintText: "Cpf*",
                      ),
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 10
                  )
                ),
                SizedBox(
                    width: 200,
                    child: TextField(
                      controller: telefoneController,
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        hintText: "Telefone",
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: emailController,
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        hintText: "Email*",
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: senhaController,
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        hintText: "Senha*",
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10
                    ),
                  ),
                  FloatingActionButton(
                        child: Icon(Icons.send_rounded),
                        backgroundColor: Colors.blueGrey,  
                        foregroundColor: Colors.white,  
                        onPressed: () {
                          if(nomeController.text.isNotEmpty){
                            if(cpfController.text.isNotEmpty){
                              if(emailController.text.isNotEmpty){
                                if(senhaController.text.isNotEmpty){

                                  usuarioCadastro.setNome(nomeController.text);
                                  usuarioCadastro.setCpf(cpfController.text);
                                  usuarioCadastro.setTelefone(telefoneController.text);
                                  usuarioCadastro.setEmail(emailController.text);
                                  usuarioCadastro.setSenha(senhaController.text);
                                  registroRepository.registro(usuarioCadastro);
                                  
                                  Future.delayed(Duration(milliseconds: 1000),(){
                                    Alert(
                                      context: context, 
                                      title: "PARABÉNS", 
                                      desc: "O usuário ${usuarioCadastro.getNome()} foi cadastrado com sucesso. " 
                                      ).show();
                                  });
                                
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const LoginStateful())
                                    );
                                }
                              }
                            }
                          }
                        }, 
                      ),
              ],
            )
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blueAccent
          ),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "@copyright",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
            )
          ],
        ),
        )
      ),
    );
  }
}