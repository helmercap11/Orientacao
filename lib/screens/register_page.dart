import 'package:flutter/material.dart';
import 'package:orientacao/const/global_const.dart';
import 'package:orientacao/screens/home_page/home_page.dart';
import 'package:orientacao/screens/login_page/login_page.dart';
import 'package:orientacao/widgets/custom_text.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

List<GlobalKey<FormState>> formKeys = [GlobalKey<FormState>(), GlobalKey<FormState>(), GlobalKey<FormState>(), GlobalKey<FormState>()];
bool obsecure = true;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class MyData {
  String name = '';
  String phone = '';
  String email = '';
  String age = '';
}



class _RegisterPageState extends State<RegisterPage> {
  int currStep = 0;

  static var _focusNode =  FocusNode();
  GlobalKey<FormState> _formKey =  GlobalKey<FormState>();
  static MyData data =  MyData();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
      print('Has focus: $_focusNode.hasFocus');
    });
  }

  /*@override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }*/

  String _selectedGender = 'male';

  final _dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        var date =
            "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
        _dateController.text = date;
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

    List<Step> steps = [
      Step(
          title: const Text('Conta'),
          isActive: true,
          //state: StepState.error,
          state: StepState.indexed,
          content: Form(
            key: formKeys[0],
            child: Column(
              children: <Widget>[
                TextFormField(
                  focusNode: _focusNode,
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  /*onSaved: (value) {
                  data.name = value!;
                },*/
                  maxLines: 1,
                  validator: (value) {
                    if (value!.isEmpty || value!.length < 1) {
                      return 'campo obrigatorio';
                    }
                  },
                  decoration:  InputDecoration(
                      labelText: 'Nome de Usuário',
                      hintText: 'nomde de usuário',
                      //filled: true,
                      prefixIcon: Icon(Icons.person),
                      labelStyle:
                      TextStyle(decorationStyle: TextDecorationStyle.solid)),
                ),
                SizedBox(height: 15,),
                TextFormField(
                  autocorrect: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty || !value!.contains('@')) {
                      return 'Please enter valid email';
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email)
                  ),
                ),
                SizedBox(height: 15,),
                TextFormField(
                  obscureText: obsecure,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      labelText: 'Palavra Passe',
                      prefixIcon: Icon(Icons.password)
                  ),
                )
              ],
            ),
          )),
      Step(
          title: const Text('Dados Pessoais'),
          //subtitle: const Text('Subtitle'),
          isActive: true,
          //state: StepState.editing,
          state: StepState.indexed,
          content: Form(
            key: formKeys[1],
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Primeiro Nome',
                      prefixIcon: Icon(Icons.person)
                  ),
                ),
                SizedBox(height: 15,),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Útimo Nome',
                      prefixIcon: Icon(Icons.person)
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /* Padding(
                  padding: EdgeInsets.only(right: 200, top: 15),
                 child: CustomText(text: "Genero", size: 12, color: black, weight: FontWeight.bold),
                ),*/
                      ListTile(
                        title: const Text('Masculino'),
                        leading: Radio<String>(
                          value: 'Masculino',
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState((){
                              _selectedGender = value!;
                            });
                          },
                        ),
                      ),

                      ListTile(
                        title: const Text('Femenino'),
                        leading: Radio<String>(
                          value: 'Femenino',
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState((){
                              _selectedGender = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      onSaved: (val) {
                        //task.date = selectedDate;
                        // task.date = selectedDate;
                      },
                      controller: _dateController,
                      decoration: InputDecoration(
                          labelText: "Data de Nascimento",
                          prefixIcon: Icon(Icons.calendar_today)
                      ),
                      /*validator: (value) {
                 if (value!.isEmpty)
                    return "Please enter a date for your task";
                  return null;
                },*/
                    ),
                  ),
                )
              ],
            ),
          )),
      Step(
          title: const Text('Finalizar'),
          // subtitle: const Text('Subtitle'),
          isActive: true,
          state: StepState.indexed,
          // state: StepState.disabled,
          content:  Form(
            key: formKeys[2],
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value!.length < 10) {
                      return 'Please enter valid number';
                    }
                  },
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: true
                  ),
                  decoration: InputDecoration(
                      labelText: 'Telefone',
                      prefixIcon: Icon(Icons.phone)
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
                ),
                SizedBox(height: 20,),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Endereço',
                      prefixIcon: Icon(Icons.location_city)
                  ),
                ),
                SizedBox(height: 20,),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                      labelText: 'Nível Academico'
                  ),
                  validator: (value) => value == null ? "Selecione o Nível Academico" : null,
                  value:  selectedValue,

                  items: dropdownItems,
                  onChanged: (String ? newValue){},
                ),
              ],
            ),
          )),
      //  Step(
      //     title: const Text('Fifth Step'),
      //     subtitle: const Text('Subtitle'),
      //     isActive: true,
      //     state: StepState.complete,
      //     content: const Text('Enjoy Step Fifth'))
    ];
    return Scaffold(
      body: Theme(
          data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                  )
              )
          ),
          child: Container(
            child: FormBlocListener(
              onSubmitting: (context, state)  => LoadingDialog.show(context),
              onSubmissionFailed: (context, state) => LoadingDialog.hide(context),
              onSuccess: (context, state){
                LoadingDialog.hide(context);
                if(state.stepCompleted ==state.lastStep){
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_)  =>  SuccessScreen())
                  );
                }
              },
              onFailure: (context, state){
                LoadingDialog.hide(context);
              },
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
                            child:  Stepper(
                              steps: steps,
                              type: StepperType.horizontal,
                              currentStep: this.currStep,
                              onStepCancel: () {
                                setState(() {
                                  if (currStep > 0) {
                                    currStep = currStep - 1;
                                  } else {
                                    currStep = 0;
                                  }
                                });},

                              onStepTapped: (step) {
                                setState(() {
                                  currStep = step;
                                });
                              },
                              onStepContinue: () {
                                setState((){
                                  if(formKeys[currStep].currentState!.validate()){
                                    if(currStep < steps.length -1 ){
                                      currStep = currStep +1;
                                    }else{
                                      currStep = 0;
                                    }
                                  }
                                });
                              },

                            ),
                            height: MediaQuery.of(context).size.height/1.1,
                            width: MediaQuery.of(context).size.width,
                            color: white,
                          ),
                        ),
                      )
                  )
                  /*RaisedButton(
                    child:  Text(
                      'Save details',
                      style:  TextStyle(color: Colors.white),
                    ),
                    onPressed: _submitDetails,
                    color: Colors.blue,
                  )*/
                ],
              ),
            ),
          )
      ),
    );
  }
}

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key? key}) => showDialog<void>(
    context: context,
    useRootNavigator: false,
    barrierDismissible: false,
    builder: (_) =>LoadingDialog(key: key),
  ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: EdgeInsets.all(12.0),
            child: CircularProgressIndicator(),
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
          children: [
            Icon(Icons.tag_faces, size: 100,),
            SizedBox(height: 10,),
            Text(
              'Sucesso',
              style: TextStyle(fontSize: 54, color: black),textAlign: TextAlign.center,
            ),
            SizedBox(height: 10,),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => RegisterPage())
              ),
              icon: Icon(Icons.replay),
              label: Text('Guardar'),
            )
          ],
        ),
      ),
    );
  }
}