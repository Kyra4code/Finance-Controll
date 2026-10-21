//Importando pacotes
import 'package:flutter/material.dart';

//Importando cores
import '../../assets/style/colors/colors_app.dart';

class CustomButton extends StatelessWidget {

  final bool stateTrue;
  final String title;

  //Arrumar dps <---------------------

  const CustomButton({
    super.key,
    required this.stateTrue,
    required this.title
  });

  Widget build(BuildContext context){


    return Center(
      child: ElevatedButton(
        onPressed: null, 

        style: ButtonStyle(
          padding: WidgetStatePropertyAll(EdgeInsets.all(20.0)),

          backgroundColor: stateTrue == true? 
          WidgetStatePropertyAll<Color?>(ColorsApp.color_green):
          WidgetStatePropertyAll<Color?>(ColorsApp.red),

          textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
          minimumSize: WidgetStatePropertyAll(Size(double.infinity, 55)),   
        ),

        child: const Text(""),
      ),
    );
  }
}
