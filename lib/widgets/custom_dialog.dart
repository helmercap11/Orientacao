import 'package:flutter/material.dart';
import 'package:orientacao/const/global_const.dart';

class CustomDialog extends StatelessWidget {
  //const CustomDialog({Key? key}) : super(key: key);

  final String title, description, buttonText;
  //final Image image;


  CustomDialog({
     required this.title,
     required  this.description,
    required this.buttonText,
   // required this.image,
});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(padding)
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
            top: avatarRadius + padding,
            bottom: padding,
            left: padding,
            right: padding
          ),
          margin: EdgeInsets.only(top: avatarRadius),
          decoration: new BoxDecoration(
            color: white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(padding),
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
              SizedBox(height: 16.0,),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0
                ),
              ),
              SizedBox(height: 24.0,),
              Align(
                alignment: Alignment.bottomRight,
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
            left: padding,
            right: padding,
            child: CircleAvatar(
              backgroundColor: primaryColor,
              radius: avatarRadius,
              child: Text("Orientação", style: TextStyle(color: white),),
            )
        )
      ],
    );
  }
}


