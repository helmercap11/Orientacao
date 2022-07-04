import 'package:flutter/material.dart';
import 'package:orientacao/const/global_const.dart';
import 'package:orientacao/screens/home_page/home_page.dart';
import 'package:orientacao/screens/login_page/login_page.dart';
import 'package:orientacao/widgets/custom_text.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class RegisterUserPage extends StatefulWidget {
  const RegisterUserPage({Key? key}) : super(key: key);

  @override
  State<RegisterUserPage> createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
  List<GlobalKey<FormState>> formKeys = [GlobalKey<FormState>(), GlobalKey<FormState>(), GlobalKey<FormState>(), GlobalKey<FormState>()];

  bool obsecure = true;

  int _currentStep = 0;

  _setState(int step){
    if(_currentStep > step){
      return StepState.complete;
    }else{
      return StepState.editing;
    }
  }

  static var _focusNode =  FocusNode();



  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
      print('Has focus: $_focusNode.hasFocus');
    });
  }
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

  late String _name,_lastName,_email, _tel, _password;
  TextEditingController _nameController = new TextEditingController();

  _setps() => [
    Step(
      title: const Text('Conta'),
      state: _setState(0),
      isActive: _currentStep == 0,
      content: Form(
        key: formKeys[0],
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              autocorrect: false,
              maxLines: 1,
              //initialValue: 'Aseem Wangoo',
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                return value!.contains('')
                    ? 'campo obrigatorio'
                    :null;
              },
              focusNode: _focusNode,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Nome de Usuário',
                focusColor: black,
                prefixIcon: Icon(Icons.person),
                /* fillColor: Colors.white,
              focusedBorder:OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                borderRadius: BorderRadius.circular(25.0),
              ),*/
              ),
            ),
            SizedBox(height: 15,),
            TextFormField(
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
            SizedBox(height: 15,),
            TextFormField(

              obscureText: obsecure,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if(value == null || value.isNotEmpty){
                  return 'campo obrigátorio';
                }
              },
              decoration: InputDecoration(
                  labelText: 'Palavra Passe',
                  prefixIcon: Icon(Icons.password)
              ),
            )
          ],
        ),
      ),
    ),
    
    Step(
        title: Text('Dados Pessoais') , 
        content: Form(
          key:formKeys[1],
          child: Column(
            children: [
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
        ),
        state: _setState(1),
        isActive: _currentStep == 1,
    ),
    Step(
        title: Text('Finalizar'),
        content: Form(
          key: formKeys[2],
          child: Column(
            children: [
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
        ),
        state: _setState(2) ,
        isActive:  _currentStep == 2,
    )
  ];
  bool hideError = false;
  void _homepage(){
    Navigator.push(context, 
      MaterialPageRoute(builder: (context) => HomePage()
      )
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      /*appBar: AppBar(
        title: Text("Orientação Profissional"),
        backgroundColor: primaryColor,
      ),*/
          body: Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                )
              )
            ),
            child: FormBlocListener(
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
                              child: Stepper(
                                type: StepperType.horizontal,
                                controlsBuilder: (BuildContext context, ControlsDetails controls) {
                                return Padding(
                                    padding: EdgeInsets.symmetric(vertical: 16.0),
                                  child: Row(
                                    children: [
                                    RaisedButton(
                                    onPressed: controls.onStepContinue,
                                    child: Text('Avançar'),
                                    textColor: Colors.white,
                                    color: primaryColor,
                                   ),
                                     if(_currentStep !=0)
                                       TextButton(
                                           onPressed: controls.onStepCancel,
                                           child: Text(
                                             'Voltar', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                                           )
                                       )
                                    ],
                                  ),
                                );
                                },
                                onStepTapped: (step) => setState(() => _currentStep = step),
                                /*onStepContinue: () {

                                  setState(() {
                                  if(_currentStep < _setps().length -0){
                                      _currentStep +=1;
                                    }else {
                                      _currentStep = 0;
                                    }

                                  });
                                },*/
                                onStepContinue: () {
                                  setState((){

                                      if(_currentStep < _setps().length -0){
                                        _currentStep +=1;
                                      }else {
                                        _currentStep = 0;
                                      }

                                  });
                                },
                                onStepCancel: () {
                                  setState(() {
                                    if(_currentStep > 0) {
                                      _currentStep -= 1;
                                    }else{
                                      _currentStep =0;
                                    }
                                  });
                                },
                                currentStep: _currentStep,
                                steps: _setps(),
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
    );
  }
}






class _AccountStep extends StatelessWidget {
  //const _AccountStep({Key? key}) : super(key: key);

  static var _focusNode =  FocusNode();
  GlobalKey<FormState> _formKey =  GlobalKey<FormState>();


  final _controller = TextEditingController();

  // dispose it when the widget is unmounted

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = new TextEditingController();
    TextEditingController _lastNameController = new TextEditingController();
    TextEditingController _emailController = new TextEditingController();
    TextEditingController _telController = new TextEditingController();
    TextEditingController _passwordController = new TextEditingController();



    final requiredValidator = RequiredValidator(errorText: 'this field is required');

    late String _name,_lastName,_email, _tel, _password;

    return Form(
      child: Column(
        children: [
          TextFormField(
            validator: requiredValidator,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Nome de Usuário',
              focusColor: black,
              prefixIcon: Icon(Icons.person),
             /* fillColor: Colors.white,
              focusedBorder:OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                borderRadius: BorderRadius.circular(25.0),
              ),*/
            ),
          ),
          SizedBox(height: 15,),
          TextFormField(
          validator: EmailValidator(errorText: 'entrar com endereço válido'),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email)
            ),
          ),
          SizedBox(height: 15,),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Palavra Passe',
              prefixIcon: Icon(Icons.password)
            ),
          )
        ],
      ),

    );
  }
}




class _PersonalStep extends StatefulWidget {

  const _PersonalStep({Key? key}) : super(key: key);

  @override
  State<_PersonalStep> createState() => _PersonalStepState();
}

class _PersonalStepState extends State<_PersonalStep> {
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

  @override
  Widget build(BuildContext context) {

   // String FavoriteMethod { flutter, kotlin, swift, reactNative}
    return Form(
      child: Column(
        children: [
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
    );
  }
}



class _FinalStep extends StatelessWidget {
  //const _FinalStep({Key? key}) : super(key: key);

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
    return Form(
      child: Column(
        children: [
          TextFormField(
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
    );
  }
}




Widget _input(Icon icon, String hint, TextEditingController controller, bool obsecure){
  return Container(
    padding: EdgeInsets.only(left: 20, right: 20),
    child: TextFormField(
      controller: controller,
      obscureText: obsecure,
      style: TextStyle(
        fontSize: 20
      ),
      decoration: InputDecoration(
        hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: primaryColor,
            width: 2
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