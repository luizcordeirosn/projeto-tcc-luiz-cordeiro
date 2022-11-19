import 'package:flutter/material.dart';
import 'package:frontend_liga_master/app/modules/home/registro_page.dart';
import 'package:frontend_liga_master/app/shared/repository/login_repository.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginStateful extends StatefulWidget {
  const LoginStateful({super.key});

  @override
  State<LoginStateful> createState() => _LoginStatefulState();
}

class _LoginStatefulState extends State<LoginStateful> {

  TextEditingController emailController =  TextEditingController();
  TextEditingController senhaController =  TextEditingController();

  LoginRepository loginRepository = LoginRepository();

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
                      controller: emailController,
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        hintText: "Email",
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
                      controller: senhaController,
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        hintText: "Senha",
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
                      loginRepository.login(emailController.text, senhaController.text);
                      Future.delayed(Duration(milliseconds: 1000),(){
                        List usuarioLogado = loginRepository.usuarioLogado;
                        if(usuarioLogado.length>0){
                          print(usuarioLogado);
                        }else{
                          Alert(
                            context: context, 
                            title: "ERRO", 
                            desc: "Usuário não encontrado. Digite novamente seu email ou senha. " 
                            ).show();
                        }
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Não tem uma conta? ",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 10
                        ),
                      ),
                      FloatingActionButton(
                        child: Icon(Icons.save_as),
                        backgroundColor: Colors.blueGrey,  
                        foregroundColor: Colors.white,  
                        onPressed: () {
                          print("Registrar");
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RegistroStateful())
                            );
                        }, 
                      ),
                    ],
                  )
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

