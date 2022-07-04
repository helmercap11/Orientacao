import 'package:flutter/material.dart';
import 'package:orientacao/const/global_const.dart';



class CustomSucessDialog extends StatelessWidget {
  //const CustomDialog({Key? key}) : super(key: key);

  final String title, buttonText;
  //final Image image;


  CustomSucessDialog({
    required this.title,
    //required  this.description,
    required this.buttonText,
    // required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(paddingS)
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContext(context),
    );
  }

  dialogContext(BuildContext context){
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(
              top: avatarRadiusS + paddingS,
              bottom: paddingS,
              left: paddingS
          ),
          margin: EdgeInsets.only(top: avatarRadiusS),
          decoration: new BoxDecoration(
              color: white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(paddingS),
              boxShadow: [
                BoxShadow(
                    color: white,
                    blurRadius: 10.0,
                    offset: const Offset(0.0, 0.0)
                )
              ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                    color: black
                ),
              ),
              SizedBox(height: 24.0,),
              Align(
                alignment: Alignment.center,
                child: FlatButton(onPressed: (){
                  Navigator.of(context).pop();
                }, child: Text(buttonText,style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: black),)
                ),

              )
            ],
          ),
        ),
        Positioned(
            left: paddingS,
            right: paddingS,
            child: CircleAvatar(
              backgroundColor: green,
              radius: avatarRadiusS,
              child:  const Icon(Icons.verified, size: 100, color: white,),),
            )
      ],
    );
  }
}


