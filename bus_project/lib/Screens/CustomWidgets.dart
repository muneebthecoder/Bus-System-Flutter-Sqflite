import 'package:flutter/material.dart';

InkWell customMenuButton({
  required Function() onTap,
  required String txt,


}){
  return InkWell(onTap: onTap,
  child: Ink(
                                 decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(100.0),
                                 color: Colors.black87,
                                 ),
                                 child: Container(
                                   constraints:const BoxConstraints(minWidth: 60.0, minHeight: 60.0), 
                                   alignment: Alignment.center,
                                  child: Text(txt,style: TextStyle(color: Colors.white,fontSize: 30),),
              ),
            ),);
}

TextFormField customTextForm({
  required TextEditingController controller,
  required String hintText,
  required String labelText,
  
})
{
  return TextFormField(
    controller: controller,
    
    decoration: InputDecoration(
      hintText: hintText,
      labelText: labelText,
      border: OutlineInputBorder(),
    ),
  );
}

