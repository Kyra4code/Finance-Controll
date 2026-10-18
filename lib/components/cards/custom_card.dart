import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

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

                  title: Text(title),

                  subtitle: Text("Data da compra: $subtitle"),

                ),

              ],

            ),

          )

        ),

      );
    }

}