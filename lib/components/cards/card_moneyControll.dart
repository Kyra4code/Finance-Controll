//Importando pacotes
import 'package:flutter/material.dart';

class CardMoneyControll extends  StatefulWidget {

  final String title;
  final IconData icon;
  final String subtitle;

   const CardMoneyControll({
     super.key,
     required this.title,
     required this.icon,
     required this.subtitle,
   });

  @override
  State<CardMoneyControll> createState() => _CardMoneyControllState();
}

class _CardMoneyControllState extends State<CardMoneyControll> {
  bool onPressed = false;

  @override
  Widget build(BuildContext context) {

    return Card(
      child: SizedBox(
      width: double.infinity,
      height: 50,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Checkbox(
              value: onPressed,
              onChanged: (value){
                setState((){
                  onPressed = value!;
                });
              },
            ),

            SizedBox(width: 10),

            Text(
              widget.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            )

            ],
          )
        ),
      ),
    );
   }
}