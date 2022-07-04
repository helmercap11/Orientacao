import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:orientacao/screens/login_page/widgets/custom_dialog_sucess.dart';

import '../../const/global_const.dart';
import '../home_page/home_page.dart';



class RegisterUser extends StatelessWidget {
  const RegisterUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegisterForm(),
    );
  }
}

class RegisterFormBloc extends FormBloc<String, String> {
  final username = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );

  final email = TextFieldBloc<String>(
    validators: [
      FieldBlocValidators.required,
      FieldBlocValidators.email,
    ],
  );

  final password = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
      FieldBlocValidators.passwordMin6Chars,
    ],
  );

  final firstName = TextFieldBloc();

  final lastName = TextFieldBloc();

  final gender = SelectFieldBloc(
    items: ['Masculino', 'Femenino'],
  );

  final birthDate = InputFieldBloc<DateTime?, Object>(
    initialValue: null,
    validators: [FieldBlocValidators.required],
  );

  final phone = TextFieldBloc();

  final nacionality = TextFieldBloc();

  final academic = TextFieldBloc();

  RegisterFormBloc() {
    addFieldBlocs(
      step: 0,
      fieldBlocs: [username, email, password],
    );
    addFieldBlocs(
      step: 1,
      fieldBlocs: [firstName, lastName, gender, birthDate],
    );
    addFieldBlocs(
      step: 2,
      fieldBlocs: [phone, nacionality, academic],
    );
  }

  bool _showEmailTakenError = true;

  @override
  void onSubmitting() async {
    if (state.currentStep == 0) {
      await Future.delayed(const Duration(milliseconds: 500));

      if (_showEmailTakenError) {
        _showEmailTakenError = false;

        email.addFieldError('Esse e-mail já foi usado');

        emitFailure();
      } else {
        emitSuccess();
      }
    } else if (state.currentStep == 1) {
      emitSuccess();
    } else if (state.currentStep == 2) {
      await Future.delayed(const Duration(milliseconds: 500));

      emitSuccess();
    }
  }


}

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  var _type = StepperType.horizontal;



  void _toggleType() {
    setState(() {
      if (_type == StepperType.horizontal) {
        _type = StepperType.vertical;
      } else {
        _type = StepperType.horizontal;
      }
    });
  }
  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Técnico Médio"),value: "Técnico Médio"),
      DropdownMenuItem(child: Text("Licenciado"),value: "Licenciado"),
      DropdownMenuItem(child: Text("Mestre"),value: "Mestre"),
      DropdownMenuItem(child: Text("Outros"),value: "Outros"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownCountrs{
    List<DropdownMenuItem<String>> menuItems = [

      DropdownMenuItem(child: Text("Angola"),value: "Angola"),
      DropdownMenuItem(child: Text("Argentina"),value: "Argentina"),
      DropdownMenuItem(child: Text("Argelia"),value: "Argelia"),
      DropdownMenuItem(child: Text("Belgiga"),value: "Belgica"),
    ];
    return menuItems;
  }

  String selectedValue = "Técnico Médio";
  String selectedValueCountry = "Angola";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterFormBloc(),
      child: Builder(
        builder: (context) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              body: Theme(
                data: Theme.of(context).copyWith(
                    inputDecorationTheme: InputDecorationTheme(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                        )
                    )
                ),
                child: Container(
                  child:FormBlocListener<RegisterFormBloc, String, String>(
                    onSubmitting: (context, state) => LoadingDialog.show(context),
                    onSubmissionFailed: (context, state) => LoadingDialog.hide(context),
                    onSuccess: (context, state) {
                      LoadingDialog.hide(context);

                      if (state.stepCompleted == state.lastStep) {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => const DialogInitial()));
                      }
                    },
                    onFailure: (context, state) {
                      LoadingDialog.hide(context);
                    },
                    child: Container(
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  primaryColor,
                                  primaryColor
                                ])
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 25,right: 330),
                                    child: Column(
                                      children: [
                                        IconButton(onPressed: () =>Navigator.of(context).pop() ,
                                          icon: Icon(Icons.arrow_back,color: white,size: 30,),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(

                              padding: EdgeInsets.only(top: 100),

                              child: Container(
                                child:  ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(0.0),
                                    topLeft: Radius.circular(85.0),
                                  ),

                                  child: Container(
                                   child: StepperFormBlocBuilder<RegisterFormBloc>(

                                     formBloc: context.read<RegisterFormBloc>(),
                                     type: _type,

                                     physics: const ClampingScrollPhysics(),
                                     stepsBuilder: (formBloc) {

                                       return [
                                         _accountStep(formBloc!),
                                         _personalStep(formBloc),
                                         _socialStep(formBloc),
                                       ];
                                     },
                                   ),
                                    height: MediaQuery.of(context).size.height/1.1,
                                    width: MediaQuery.of(context).size.width,
                                    color: white,
                                  ),
                                ),
                              )
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          );
        },
      ),
    );
  }

  FormBlocStep _accountStep(RegisterFormBloc wizardFormBloc) {
    return FormBlocStep(
      title: const Text('Conta'),
      content: Column(
        children: <Widget>[
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.username,
            keyboardType: TextInputType.emailAddress,
            enableOnlyWhenFormBlocCanSubmit: true,
            decoration: const InputDecoration(
              labelText: 'Nome de Usuário',
              prefixIcon: Icon(Icons.person),
            ),
          ),
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.email,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
            ),
          ),
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.password,
            keyboardType: TextInputType.emailAddress,
            suffixButton: SuffixButton.obscureText,
            decoration: const InputDecoration(
              labelText: 'Palavra Passe',
              prefixIcon: Icon(Icons.lock),
            ),
          ),
          RaisedButton(
            padding: EdgeInsets.all(0.0),
            onPressed: (){  Navigator.push(context,
                MaterialPageRoute(builder: (context) => WellCome()));
              /*showDialog(
                  context: context,
                  builder: (BuildContext context) => CustomSucessDialog(
                      title: "Sucesso",
                      //description: "testando o aplicativo",
                      buttonText: "Terminar")
              );*/
            },
            textColor: white,
            color: primaryColor,
            child: Text("Open Dialog"),
          ),
        ],
      ),
    );
  }

  FormBlocStep _personalStep(RegisterFormBloc wizardFormBloc) {
    return FormBlocStep(
      title: const Text('Dados Pessoais'),
      content: Column(
        children: <Widget>[
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.firstName,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Primeiro Nome',
              prefixIcon: Icon(Icons.person),
            ),
          ),
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.lastName,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Último Nome',
              prefixIcon: Icon(Icons.person),
            ),
          ),
          RadioButtonGroupFieldBlocBuilder<String>(
            selectFieldBloc: wizardFormBloc.gender,
            itemBuilder: (context, value) => FieldItem(
              child: Text(value),
            ),
            decoration: const InputDecoration(
              labelText: 'Gênero',
              prefixIcon: SizedBox(),
            ),
          ),
          DateTimeFieldBlocBuilder(
            dateTimeFieldBloc: wizardFormBloc.birthDate,
            firstDate: DateTime(1900),
            initialDate: DateTime.now(),
            lastDate: DateTime.now(),
            format: DateFormat('yyyy-MM-dd'),
            decoration: const InputDecoration(
              labelText: 'Data de Nascimento',
              prefixIcon: Icon(Icons.cake),
            ),
          ),
        ],
      ),
    );
  }

  FormBlocStep _socialStep(RegisterFormBloc wizardFormBloc) {
    return FormBlocStep(
      title: const Text('Finalizar'),
      content: Column(
        children: <Widget>[
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.phone,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Telefone',
              prefixIcon: Icon(Icons.phone),
            ),
          ),
          SizedBox(height: 20,),
          DropdownButtonFormField(
            decoration: InputDecoration(
                labelText: 'País de Nacionalidade',
                prefixIcon: Icon(Icons.flag_outlined)
            ),
            value: selectedValueCountry,
            items: dropdownCountrs,
            onChanged: (String){},
          ),SizedBox(height: 20,),
          DropdownButtonFormField(
            decoration: InputDecoration(
                labelText: 'Nível Academico',
              prefixIcon: Icon(Icons.school)
            ),
            validator: (value) => value == null ? "Selecione o Nível Academico" : null,
            value:  selectedValue,

            items: dropdownItems,
            onChanged: (String ? newValue){},
          ),
          /*TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.nacionality,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Twitter',
              prefixIcon: Icon(Icons.sentiment_satisfied),
            ),
          ),
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.academic,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Facebook',
              prefixIcon: Icon(Icons.sentiment_satisfied),
            ),
          ),*/
        ],
      ),
    );
  }
}

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key? key}) => showDialog<void>(
    context: context,
    useRootNavigator: false,
    barrierDismissible: false,
    builder: (_) => LoadingDialog(key: key),
  ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(12.0),
            child: const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.info_outline_rounded, size: 100, color: red,),
            const SizedBox(height: 10),
            const Text(
              'Clique em salvar dados',
              style: TextStyle(fontSize: 54, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => CustomSucessDialog(
                      title: "Sucesso",
                      buttonText: "Finalizar"))),
              icon: const Icon(Icons.save),
              label: const Text('Salvar os dados'),
            ),
          ],
        ),
      ),
    );
  }
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


class WellCome extends StatefulWidget {
  const WellCome({Key? key}) : super(key: key);

  @override
  State<WellCome> createState() => _WellComeState();
}

class _WellComeState extends State<WellCome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Padding(
             padding: const EdgeInsets.only(top: 30),

             child: Center(child: Icon(Icons.check_circle_outline_sharp, size: 200,color: blue,)),
           ),
            SizedBox(height: 10,),
            Text(
              "Bem Vindo.",
              style: TextStyle(fontSize: 30, color: black, decoration: TextDecoration.none),
            ),
            SizedBox(height: 15,),
            Text(
                "Estamos aqui para ajudar na sua Orientação Profissional! A seguir será apresentado algumas áreas de conhecimento.",
              style: TextStyle(fontSize: 20, color: Colors.black38, decoration: TextDecoration.none),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 40,),
            Padding(padding: EdgeInsets.only(top: 60),
              child:  ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: blue,
                  onPrimary: Colors.white,
                  shadowColor: blue,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  minimumSize: Size(300, 50), //////// HERE
                ),
                child: Text(
                    'Continuar',
                  style: TextStyle(fontSize: 20,),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                }
              )

            ),
          ],
        ),
      ),
        );
  }
}

