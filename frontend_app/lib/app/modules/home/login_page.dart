import 'package:flutter/material.dart';
import 'package:frontend_liga_master/app/modules/dashboard/user_premium_dashboard_page.dart';
import 'package:frontend_liga_master/app/modules/home/registro_page.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../shared/controller/login_controller.dart';
import '../dashboard/user_dashboard_page.dart';

class LoginStateful extends StatefulWidget {
  const LoginStateful({super.key});

  @override
  State<LoginStateful> createState() => _LoginStatefulState();
}

class _LoginStatefulState extends State<LoginStateful> {
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  LoginController loginController = LoginController();
  List usuarioLogado = [];

  bool _mostrarSenha = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liga Master"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/stadium2.jpg"),
                  fit: BoxFit.fitHeight,
                  opacity: 0.60),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "BEM VINDO ",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      Icon(Icons.waving_hand)
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: Text(
                      "Insira as suas informações que você digitou durante o cadastro.",
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 100),),
                  SizedBox(
                    width: 230,
                    child: TextFormField(
                      controller: emailController,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black54),
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  SizedBox(
                    width: 230,
                    child: TextFormField(
                      controller: senhaController,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black54),
                      decoration: InputDecoration(
                        hintText: "Senha",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.black54,
                        ),
                        suffixIcon: GestureDetector(
                          child: Icon(
                            _mostrarSenha == false
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.black54,
                          ),
                          onTap: () {
                            setState(() {
                              _mostrarSenha = !_mostrarSenha;
                            });
                          },
                        ),
                      ),
                      obscureText: _mostrarSenha == false ? true : false,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  OutlinedButton(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(40, 12, 40, 12),
                      child: Text(
                        "ENTRAR",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.lime[700],
                      shape: StadiumBorder(),
                    ),
                    onPressed: () {
                      loginController.login(
                          emailController.text, senhaController.text);
                      Future.delayed(Duration(milliseconds: 1000), () {
                        usuarioLogado = loginController.usuarioLogado;
                        if (usuarioLogado.length > 0) {
                          if(usuarioLogado.elementAt(6)){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserPremiumDashboard(
                                        usuarioLogado: usuarioLogado,
                                      )));
                          }else{
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserDashboard(
                                        usuarioLogado: usuarioLogado,
                                      )));
                          }
                        } else {
                          Alert(
                                  context: context,
                                  title: "ERRO",
                                  desc:
                                      "Usuário não encontrado. Digite novamente seu email ou senha. ")
                              .show();
                        }
                      });
                    },
                  ),
                  Padding(padding: EdgeInsets.only(top: 100),),
                  Text(
                    "Não tem uma conta? ",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3),
                  ),
                  OutlinedButton(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(40, 12, 40, 12),
                      child: Text(
                        "REGISTRE-SE AQUI",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.lime[700],
                      shape: StadiumBorder(),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegistroStateful()));
                    },
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          child: Container(
        decoration: BoxDecoration(color: Colors.blueAccent),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "@copyright",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
            Padding(
              padding: EdgeInsets.all(12),
            )
          ],
        ),
      )),
    );
  }
}
