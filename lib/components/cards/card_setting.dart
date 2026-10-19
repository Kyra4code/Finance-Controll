//Importando pacotes
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

//Importando cores
import '../../../assets/style/colors/colors_app.dart';

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

      color: ColorsApp.card,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: ColorsApp.cardBorder)
      ),

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
                leading: icon_select,
                title: Text(
                  title,
                  style: TextStyle(
                    color: ColorsApp.textColor

                  ),
                ),
              ),
              

            ],

          ),

        ),

      ),

    );
  }
}