import 'package:flutter/material.dart';
import 'package:orientacao/const/global_const.dart';
import 'package:orientacao/model/FieldStudyModel.dart';
import 'package:orientacao/screens/home_page/home_page.dart';
import 'package:orientacao/widgets/custom_text.dart';

class CustomFieldStudy extends StatefulWidget {
  //const CustomFieldStudy({Key? key}) : super(key: key);

  final String name;
  final bool isSelected;
  final int index;


  CustomFieldStudy(this.name, this.isSelected, this.index);

  @override
  State<CustomFieldStudy> createState() => _CustomFieldStudyState();
}

class _CustomFieldStudyState extends State<CustomFieldStudy> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue[700],
        child: Icon(
          Icons.person_outline_outlined,
          color: white,
        ),
      ),
      title: CustomText(
          text: widget.name,
          size: 20,
          color: black,
          weight: FontWeight.w500
      ),
    trailing: widget.isSelected
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
        fieldStudy[widget.index].isSelected = !fieldStudy[widget.index].isSelected;
        if (fieldStudy[widget.index].isSelected == true) {
          selectedFieldStudy.add(FieldStudyModel(widget.name, true));
        } else if (fieldStudy[widget.index].isSelected == false) {
          selectedFieldStudy
              .removeWhere((element) => element.name == fieldStudy[widget.index].name);
        }
      });
    },
    );
  }
}
