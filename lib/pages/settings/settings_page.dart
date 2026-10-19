//Importando pacotes
import 'package:flutter/material.dart';

//Importando telas

//Importando componentes
import '../../components/cards/card_setting.dart';

//Importando cores
import '../../assets/style/colors/colors_app.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: ColorsApp.color_background,

      appBar: AppBar(

        backgroundColor: ColorsApp.color_background,

        title: Center(
          child:Text(
            "Voltar",
            style:TextStyle(
              color: ColorsApp.textColor
            )
        )),

        iconTheme: IconThemeData(
          color: ColorsApp.textColor
        ), 
        
      ),
      
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            CardSetting(
              title: "Usuario",
              icon: Icons.person,
              
            ),

            SizedBox(height: 28),

            CardSetting(
              title: "Fianceiro",
              icon: Icons.monetization_on,
              
            ),

            SizedBox(height: 28),

            CardSetting(
              title: "Sobre",
              icon: Icons.info,
              
            ),

          ],

        ),
      ),
    );
  }
}