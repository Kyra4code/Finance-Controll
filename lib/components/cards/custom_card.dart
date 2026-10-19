//Importando pacotes
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

//Importando cores
import '../../../assets/style/colors/colors_app.dart';

class CustomCard extends StatelessWidget{

  const CustomCard({
    super.key, 
    required this.title,
    required this.subtitle,
    this.icon = Icons.monetization_on,
    this.onPressed = null,

  });

    final AsyncCallback? onPressed;
    final IconData icon;
    final String title;
    final String subtitle;

    @override
    Widget build(BuildContext context) {

      final VoidCallback? callback = onPressed;

      return Card(

        color: ColorsApp.card,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: ColorsApp.cardBorder)
        ),


        clipBehavior: Clip.hardEdge,

        child: InkWell(

          onTap: callback == null ? null : () => callback(),

          child: SizedBox(
            width: 450,
            height: 100,
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                SizedBox(height: 10),

                ListTile(

                  leading: Icon(icon),

                  title: Text(
                    title,
                    style: TextStyle(
                      color: ColorsApp.textColor
                    ),
                  ),

                  subtitle: Text(
                    "Data da compra: $subtitle",
                    style: TextStyle(
                      color: ColorsApp.textColor
                    ),
                  ),

                ),

              ],

            ),

          )

        ),

      );
    }

}