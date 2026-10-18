//Importando pacotes
import 'package:flutter/material.dart';

//Importando telas

//Importando componentes
import '../../components/cards/card_setting.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Voltar"),
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