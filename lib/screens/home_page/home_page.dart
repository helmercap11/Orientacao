import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:orientacao/const/global_const.dart';
import 'package:orientacao/screens/list_radio_page.dart';
import 'package:orientacao/widgets/custom_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    void nextpage(){
      //Navigator.push(context, MaterialPageRoute(builder: (context)=>))
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
              )
          )
      ),
      builder: (context, child){
        return FormThemeProvider(
            theme: FormTheme(
                checkboxTheme: CheckboxFieldTheme(
                    canTapItemTile: true
                ),
                radioTheme: RadioFieldTheme(
                  canTapItemTile: true,
                )
            ),
            child: child!
        );
      },
      home: AreaForm(),
      /*body: FormblocLis(
        child: Column(
          children: [
            Center(
              child: RaisedButton(
                  padding: EdgeInsets.all(0.0),
                  onPressed: (){
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => CustomDialog(
                            title: "Avançar",
                            description: "testando o aplicativo",
                            buttonText: "Próximo")
                    );
                  },
                textColor: white,
                color: primaryColor,
                child: Text("Open Dialog"),
                  ),
            ),
            Container(
                child: RaisedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> MyApp()));
                }, child: Text("Abrir"),),
            )
          ],
        ),
      ),*/
    );
  }
}

class AllFilds extends FormBloc<String, String>{
  final text1 = TextFieldBloc();
  final select1 = SelectFieldBloc(
      items: [
        'Informática',
        'Arquitetura',
        'Construção Cívil',
        'Eletronica de Telecomunicações',
        'Petroleo'
      ],
      validators: [FieldBlocValidators.required]
  );
  final multiSelect1 = MultiSelectFieldBloc<String, dynamic>(
    items: [
      'Informática',
      'Arquitetura',
      'Construção Cívil',
      'Eletronica de Telecomunicações',
      'Petroleo',
      'Mecatronica',
      'Ambiente'
    ]
  );

  final ciencia_exatas = MultiSelectFieldBloc<String, dynamic>(
    items: [
      'Física',
      'Matemática'
    ]
  );

  final ciencia_biologicas = MultiSelectFieldBloc<String, dynamic>(
      items: [
        'Anatomia Humana',
        'Biofísica',
        'Bioquímica',
        'Biotecnologia',
        'Citologia Animal e Vegetal',
        ' Ecologia',
        'Ecologia de Ecossistemas',
        'Educação Ambiental',
        'Evolução',
        'Fisiologia Humana',
        'Fisiologia Vegetal',
        'Genética',
        'Genética de Populações',
        'Impacto Ambiental',
        'Imunobiologia',
        'Microbiologia',
        'Paleontologia',
        'Parasitologia Humana',
        'Psicologia',
        'Sistemas Circulatório',
        'Sistemática Animal',
        'Sistema Vegetal e de Microrganismos',
        'Sociologia',
        'Zoologia de Invertebrados',
      ]
  );

  AllFilds(): super(autoValidate: false){
    addFieldBlocs(fieldBlocs: [
      text1,
      multiSelect1,
      select1,
      ciencia_exatas,
      ciencia_biologicas
    ]);
  }

  @override
  void onSubmitting() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 500));
      emitSuccess(canSubmitAgain: true);
    } catch (e) {
      emitFailure();
    }
  }

}



class AreaForm extends StatefulWidget {
  const AreaForm({Key? key}) : super(key: key);

  @override
  State<AreaForm> createState() => _AreaFormState();
}
enum SingingCharacter { lafayette, jefferson }

class _AreaFormState extends State<AreaForm> {
  @override
  Widget build(BuildContext context) {
    SingingCharacter? _character = SingingCharacter.lafayette;
    String? gender;
    return Scaffold(
      appBar: AppBar(
        title: Text('Orientação Profissional'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
    child: Column(
    children: [

    Text("What is your gender?", style: TextStyle(
    fontSize: 18
    ),),

    Divider(),

    ListTile(
    title: Text("Male"),
    leading: Radio(
    value: "male",
    groupValue: gender,
    onChanged: (value){
    setState(() {
    gender = value.toString();
    });
    }),
    ),

    ListTile(
    title: Text("Female"),
    leading: Radio(
    value: "female",
    groupValue: gender,
    onChanged: (value){
    setState(() {
    gender = value.toString();
    });
    }),
    ),

    ListTile(
    title: Text("Other"),
    leading: Radio(
    value: "other",
    groupValue: gender,
    onChanged: (value){
    setState(() {
    gender = value.toString();
    });
    }),
    )


    ],
    ),
    ),
    );
  }
}


class SubjectForm extends StatelessWidget {
  const SubjectForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>AllFilds(),
      child: Builder(
        builder: (context) {
          final formBloc = BlocProvider.of<AllFilds>(context);

          return Scaffold(
            appBar: AppBar(
              title: Text('Orientação Profissional'),
            ),
            floatingActionButton: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton.extended(
                  heroTag: null,
                  onPressed: formBloc.submit,
                  icon: Icon(Icons.send),
                  label: Text('Enviar Dados'),
                )
              ],
            ),
            body: FormBlocListener<AllFilds, String, String>(
              child: ScrollableFormBlocManager(
                formBloc: formBloc,
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  padding: EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Text(
                          "Escolha as discíplinas em que mais te destacas.",
                          style: TextStyle(
                            color: black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400
                          ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 20,),
                      CheckboxGroupFieldBlocBuilder<String>(
                          multiSelectFieldBloc: formBloc.ciencia_exatas,
                          itemBuilder: (context, item) => FieldItem(
                              child: Text(item)
                          ),
                        decoration: InputDecoration(
                          labelText: ('Ciências Exatas'),
                          prefixIcon: SizedBox(),
                          labelStyle: TextStyle(fontSize: 20, color: black, fontWeight: FontWeight.w900)
                        ),
                      ),
                      CheckboxGroupFieldBlocBuilder<String>(
                          multiSelectFieldBloc: formBloc.ciencia_biologicas,
                          itemBuilder: (context, item) => FieldItem(
                              child: Text(item)
                          ),
                        decoration: InputDecoration(
                          labelText: 'Ciências Biológicas',
                          prefixIcon: SizedBox(),
                          labelStyle: TextStyle(fontSize: 20, color: black, fontWeight: FontWeight.w900)
                        ),
                      ),
                      CheckboxGroupFieldBlocBuilder<String>(
                        multiSelectFieldBloc: formBloc.multiSelect1,
                        itemBuilder: (context, item) => FieldItem(
                          child: Text(item),
                        ),
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(fontSize: 20, color: black, fontWeight: FontWeight.bold),
                          labelText: 'Áreas de Conhecimento',
                          prefixIcon: SizedBox(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

