//Importando pacotes
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


class CardSetting extends StatelessWidget {
  const CardSetting({
    super.key,
    required this.title,
    this.icon = Icons.settings,
    this.onPressed,
  });

  final AsyncCallback? onPressed;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {

    final Icon icon_select = Icon(icon);

    final VoidCallback? callback = onPressed;

    return Card(

      clipBehavior: Clip.hardEdge,

      child: InkWell(

        onTap: callback == null ? null : () => callback(),

        child: SizedBox(

          width: 800,
          height: 80,
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(height: 20),
              ListTile(
                leading: icon_select == null ? Icon(Icons.settings) : icon_select,
                title: Text(title),
              ),
              

            ],

          ),

        ),

      ),

    );
  }
}