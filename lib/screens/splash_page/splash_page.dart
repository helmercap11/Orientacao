import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orientacao/const/global_const.dart';



import '../login_page/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void  initState(){
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    Future.delayed(Duration(seconds: 4)).then((_){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>LoginPage()));
    });
  }
  @override
  Widget build(BuildContext context) {
    Size sizeDevice = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 250),
                  Image.asset('assets/images/icons_1.png'),
                  SizedBox(height: 30,),
                  Center(

                    child: Text(
                      "Orientação Profissional", textAlign: TextAlign.center,
                      style: TextStyle(color: primaryColor, fontSize: 30, fontWeight: FontWeight.bold, ),
                    ) ,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
