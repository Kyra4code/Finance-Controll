//Importando pacotes
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//Importando cores
import '../assets/style/colors/colors_app.dart';



class CustomFloatingactionbutton extends StatefulWidget{

   const CustomFloatingactionbutton({
    super.key,

    required this.onPressed,

    this.tooltip = "Adicionar"


   });

  final AsyncCallback? onPressed;
  final String tooltip; 

  @override
  State<CustomFloatingactionbutton> createState() => _CustomFloatingactionbuttonState();
}

class _CustomFloatingactionbuttonState extends State<CustomFloatingactionbutton> {
  @override

  Widget build(BuildContext context) {

    final callback = widget.onPressed;
    
    return FloatingActionButton(

        onPressed: callback == null ? null : () => callback(),

        backgroundColor: ColorsApp.color_green,

        tooltip: widget.tooltip,

        child: Icon(Icons.add),

        hoverElevation: 20,

        foregroundColor: ColorsApp.textColor,

    );

  }
}