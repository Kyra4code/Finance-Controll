//Importando pacotes
import 'package:flutter/material.dart';

//Importando cores
import '../../../assets/style/colors/colors_app.dart';

class CardMoneyControll extends  StatefulWidget {

  final String title;
  final IconData icon;
  final String subtitle;
  bool state_item;
  ValueChanged<bool?> onChanged;

  CardMoneyControll({
     super.key,
     required this.title,
     required this.icon,
     required this.subtitle,
     required this.state_item,
     required this.onChanged,
   });

  @override
  State<CardMoneyControll> createState() => _CardMoneyControllState();
}

class _CardMoneyControllState extends State<CardMoneyControll> {

  @override
  Widget build(BuildContext context) {

    return Card(

      color: ColorsApp.card,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: ColorsApp.cardBorder)
      ),

      child: SizedBox(

      width: double.infinity,

      height: 50,

        child: Center(

          child: Row(

            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              Checkbox(
                checkColor: ColorsApp.textColor,
                focusColor: ColorsApp.textColor,
                value: widget.state_item,
                onChanged:widget.onChanged
              ),

              SizedBox(width: 10),

              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ColorsApp.textColor,
                ),
              )

            ],
          )
        ),
      ),
    );
  }
}