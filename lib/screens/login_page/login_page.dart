import 'package:flutter/material.dart';
import 'package:orientacao/const/global_const.dart';
import 'package:orientacao/screens/login_page/register.dart';
import 'package:orientacao/screens/register_page.dart';
import 'package:orientacao/screens/register_user_page.dart';
import 'package:orientacao/widgets/custom_text.dart';

import '../home_page/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}
bool _obsecure = false;

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  late String _email;
  late String _password;
  late String _displayName;


  void _loginUser(){
    _email = _emailController.text;
    _password = _passwordController.text;
    _emailController.clear();
    _passwordController.clear();
  }

  void _homepage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DialogInitial(),
        ));
  }




  @override
  Widget build(BuildContext context) {
    Widget logo() {
      Size sizeDevice = MediaQuery.of(context).size;
      return Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 95),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: sizeDevice.height/8,
                ),
                // Image.asset('assets/images/fundo.jpg'),
                Image(image: new AssetImage('assets/images/icons_1.png')),
               Text(
                 "Orientação Profissional", textAlign: TextAlign.center,
                 style: TextStyle(fontSize: 20, color: primaryColor, fontWeight: FontWeight.w900 ),
               )
              ],
            ),
          ),
        ],
      );
    }

    return Scaffold(
      body: Theme(
        data: Theme.of(context).copyWith(
            inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                )
            )
        ),
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  white,
                  white,
                ],)
              ),
              child: Column(
                children: [
                  Align(
                    child: logo(),
                  )
                ],
              ),
            ),
        Padding(
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(0.0)),
                    child: Container(
                      child: ListView(
                        children: [
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                              Padding(padding: EdgeInsets.only(bottom: 10,top: 0),
                              child: Text(
                                "Iniciar Sessão", style: TextStyle(fontSize: 20, color: black, fontWeight: FontWeight.w900),
                              ),),

                                Padding(
                                  padding: EdgeInsets.only(bottom: 10, top: 20, left: 20, right: 20),
                                  /*child: _input(Icon(Icons.email), "EMAIL",
                                      _emailController, false),*/
                                  child: TextFormField(
                                    autocorrect: false,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      return value!.contains('')
                                          ? 'Validação que retorna falsa no valor inicial.'
                                          : null;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                        labelText: 'Email',
                                        prefixIcon: Icon(Icons.email)
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 20,left: 20, right: 20),
                                  /*child: _input(Icon(Icons.vpn_key), "PASSWORD",
                                      _passwordController, true),*/
                                  child: TextFormField(

                                    obscureText: obsecure,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if(value == null || value.isNotEmpty){
                                        return 'campo obrigátorio';
                                      }
                                    },
                                    decoration: InputDecoration(
                                        labelText: 'Palavra Passe',
                                        prefixIcon: Icon(Icons.lock),
                                    ),
                                  )
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 32),
                                    child: FlatButton(
                                      child: CustomText(
                                        text: "Forgot Password ?",
                                        color: black,
                                        weight: FontWeight.bold,
                                        size: 15,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: Container(
                                    child: _button(
                                        "ENTRAR",
                                        Colors.white,
                                        primaryColor,
                                        primaryColor,
                                        Colors.white,
                                        _homepage),
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                FlatButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => RegisterForm(),
                                        ));
                                  },
                                  child: CustomText(
                                    text: "Criar Conta",
                                    size: 20,
                                    color: black,
                                    weight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      height: MediaQuery.of(context).size.height / 1.1,
                      width: MediaQuery.of(context).size.width,
                      color: white,
                    ),
                  ),
                ),
                padding: EdgeInsets.only(top: 260)
            )
          ],
        ),
      ),
    );
  }
}



Widget _input(
  Icon icon, String hint, TextEditingController controller, bool obsecure) {
  return Container(
    padding: EdgeInsets.only(left: 20, right: 20),
    child: TextField(
      controller: controller,
      obscureText: obsecure,
      style: TextStyle(
        fontSize: 20
      ),
      decoration: InputDecoration(
        hintStyle: TextStyle(fontWeight:  FontWeight.bold, fontSize: 20),
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: primaryColor,
            width: 2,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: primaryColor,
            width: 3
          )
        ),
        prefixIcon: Padding(
          child: IconTheme(data: IconThemeData(color: primaryColor), child: icon,),
          padding: EdgeInsets.only(left: 30, right: 10),
        )
      ),
    ),
  );
}


Widget _button(String text, Color splashColor, Color highligthColor,
Color fillColor, Color textColor, void function()){
  return RaisedButton(
    highlightElevation: 0.0,
      splashColor: splashColor,
      highlightColor: highligthColor,
      elevation: 0.0,
      color: fillColor,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
      ),
      child: CustomText(
        text: text,
        color: textColor,
        weight: FontWeight.bold,
        size: 20,
      ),
      onPressed: () {
        function();
      }
  );
}


class DialogInitial extends StatefulWidget {
  const DialogInitial({Key? key}) : super(key: key);

  @override
  State<DialogInitial> createState() => _DialogInitialState();
}

class _DialogInitialState extends State<DialogInitial>
        with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> scaleAnimation;

  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(
        milliseconds: 1000,
      ),
      vsync: this,
      value: 0.1,
    );
    scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceIn,
    );
    _controller.forward();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ScaleTransition(
        scale: scaleAnimation,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.check, size: 100, color: Colors.green,),
            const SizedBox(height: 10),
            const Text(
              'Sucesso',
              style: TextStyle(fontSize: 54, color: Colors.black,decoration: TextDecoration.none),
              textAlign: TextAlign.center,

            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const HomePage())),
              icon: const Icon(Icons.replay),
              label: const Text('FINALIZAR'),
            ),
          ],
        ),
    ),
    );
  }
}
