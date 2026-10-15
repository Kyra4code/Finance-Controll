import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomFloatingactionbutton extends StatelessWidget{

   const CustomFloatingactionbutton({
    super.key,

    required this.onPressed,

    this.tooltip = "Adicionar"


   });

  final AsyncCallback? onPressed;
  final String tooltip; 


  @override

  Widget build(BuildContext context) {

    final callback = onPressed;
    
    return FloatingActionButton(
        onPressed: callback == null ? null : () => callback(),

        backgroundColor: Color.fromRGBO(76, 175, 80,1),

        tooltip: tooltip,

        child: Icon(Icons.add),

    );

  }

}