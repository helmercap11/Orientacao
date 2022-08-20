import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:orientacao/const/global_const.dart';
import 'package:orientacao/model/FieldStudyModel.dart';
import 'package:orientacao/screens/list_radio_page.dart';
import 'package:orientacao/screens/login_page/login_page.dart';
import 'package:orientacao/widgets/custom_dialog.dart';
import 'package:orientacao/widgets/custom_fieldStudy.dart';
import 'package:orientacao/widgets/custom_text.dart';

List<FieldStudyModel> fieldStudy = [
  FieldStudyModel("Ciências Exatas", false),
  FieldStudyModel("Ciências Biológicas", false),
  FieldStudyModel("Ciências da Saúde", false),
  FieldStudyModel("Ciências Agrárias", false),
  FieldStudyModel("Ciências Humanas", false),
  FieldStudyModel("Ciências Sociais Aplicadas", false),
  FieldStudyModel("Engenharias", false),
  FieldStudyModel("Linguística, Letras e Artes", false),

];

List<FieldStudyModel> selectedFieldStudy = [];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orientação Profissional"),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue[700],
      ),
      body: Container(

        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0),
          child: SafeArea(
            child: Container(
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Container(
                    margin: EdgeInsets.all(9.0),
                    child:  Text(
                      "Escolha as áreas em que mais te destacas.",
                      style: TextStyle(
                          color: black,
                          fontSize: 20,
                          fontWeight: FontWeight.w400
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: fieldStudy.length,
                        itemBuilder: (BuildContext context, int index) {
                          // return item
                          return Card(
                            margin: EdgeInsets.all(9.0),
                            elevation: 7.0,
                            child: ContactItem(
                              fieldStudy[index].name,
                              fieldStudy[index].isSelected,
                              index,
                            ),
                          );
                        }),
                  ),
                  selectedFieldStudy.length > 0 ? Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 10,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Container(
                       // margin: EdgeInsets.all(9.0),
                        child: RaisedButton(
                          color: Colors.blue[700],
                          child: Text(
                            "Avançcar (${selectedFieldStudy.length})",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ), 
                          onPressed: () {
                            //print("Delete List Lenght: ${selectedFieldStudy.length}");
                            //Navigator.push(context, MaterialPageRoute(builder: (context) =>LoginPage()));
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SubjectForm()));
                          },
                        ),
                      ),
                    ),
                  ): Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget ContactItem(
      String name, bool isSelected, int index) {
    return ListTile(
      /*leading: CircleAvatar(
        backgroundColor: Colors.blue[700],
        child: Icon(
          Icons.person_outline_outlined,
          color: Colors.white,
        ),
      ),*/
      title:  CustomText(
          text: name,
          size: 20,
          color: black,
          weight: FontWeight.w500
      ),
     // subtitle: Text(phoneNumber),
      trailing: isSelected
          ? Icon(
        Icons.check_circle,
        color: Colors.blue[700],
      )
          : Icon(
        Icons.check_circle_outline,
        color: Colors.grey,
      ),
      onTap: () {
        setState(() {
          fieldStudy[index].isSelected = !fieldStudy[index].isSelected;
          if (fieldStudy[index].isSelected == true) {
            selectedFieldStudy.add(FieldStudyModel(name, true));
          } else if (fieldStudy[index].isSelected == false) {
            selectedFieldStudy
                .removeWhere((element) => element.name == fieldStudy[index].name);
          }
        });
      },
    );
  }
}


/*class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    void nextpage(){
      //Navigator.push(context, MaterialPageRoute(builder: (context)=>))
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Orientação Profissional"),
        backgroundColor: blue,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: fieldStudy.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CustomFieldStudy(
                        fieldStudy[index].name,
                        fieldStudy[index].isSelected,
                        index,
                      );
                    }
                ),
              ),
              selectedFieldStudy.length  > 0 ? Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 10,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    color: blue,
                    child: CustomText(
                        text: "Avançar",
                        size: 18,
                        color: white,
                        weight: FontWeight.bold
                    ),
                    onPressed: (){
                      print("Delete List Lenght: ${selectedFieldStudy.length}");
                    },
                  ),
                ),
              ): Container()
            ],
          ),
        ),
      ),
    );

    /*return MaterialApp(
      title: 'Orientação Profissional',
     debugShowCheckedModeBanner: false,
     theme: ThemeData(
       primaryColor: primaryColor,
     ),
      home: HomeObject(),
    );*/
   /* return MaterialApp(
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
      home: SubjectForm(),
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
    );*/
  }
  Widget FieldStudyItem( String name, bool isSelected, int index){
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue[700],
        child: Icon(
          Icons.person_outline_outlined,
          color: white,
        ),
      ),
      title: CustomText(
          text: name,
          size: 20,
          color: black,
          weight: FontWeight.w500
      ),
      trailing: isSelected
          ? Icon(
        Icons.check_circle,
        color: blue,
      )
          : Icon(
        Icons.check_circle_outline,
        color: Colors.grey,
      ),
      onTap: () {
        setState(() {
          fieldStudy[index].isSelected = !fieldStudy[index].isSelected;
          if (fieldStudy[index].isSelected == true) {
            selectedFieldStudy.add(FieldStudyModel(name, true));
          } else if (fieldStudy[index].isSelected == false) {
            selectedFieldStudy
                .removeWhere((element) => element.name == fieldStudy[index].name);
          }
        });
      },
    );
  }
}*/

class HomeObject extends StatelessWidget {
  const HomeObject({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orientação Profissional'),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                      itemCount: fieldStudy.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CustomFieldStudy(
                            fieldStudy[index].name,
                            fieldStudy[index].isSelected,
                            index,
                        );
                      }
                  ),
              ),
              selectedFieldStudy.length  > 0 ? Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 10,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    color: blue,
                    child: CustomText(
                        text: "Avançar",
                        size: 18,
                        color: white,
                        weight: FontWeight.bold
                    ),
                    onPressed: (){
                      print("Delete List Lenght: ${selectedFieldStudy.length}");
                    },
                  ),
                ),
              ): Container()
            ],
          ),
        ),
      ),
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
                  //onPressed: formBloc.submit,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>LoginPage()));
                  },
                  icon: Icon(Icons.send),
                  label: Text('Enviar Dados'),
                )
              ],
            ),
            body: Theme(
              data: Theme.of(context).copyWith(
                  inputDecorationTheme: InputDecorationTheme(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  )
              ),
              child: FormBlocListener<AllFilds, String, String>(
                child: ScrollableFormBlocManager(
                  formBloc: formBloc,
                  child: SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    padding: EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Text(
                            "Escolha o curso da respetiva área de conhecimento.",
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
                        SizedBox(height: 15,),
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
                        SizedBox(height: 15,),
                        CheckboxGroupFieldBlocBuilder<String>(
                          multiSelectFieldBloc: formBloc.multiSelect1,
                          itemBuilder: (context, item) => FieldItem(
                            child: Text(
                                item, style: TextStyle(color: black),

                            ),
                          ),
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(fontSize: 25, color: black, fontWeight: FontWeight.bold,),
                            labelText: 'Engenharia',
                            prefixIcon: SizedBox(),
                          ),
                        ),
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
}

