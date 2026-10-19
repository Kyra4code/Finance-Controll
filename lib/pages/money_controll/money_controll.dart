//Importando pacotes
import 'package:flutter/material.dart';

//Importando telas

//Importando componentes
import 'package:finance_controll/components/cards/card_moneyControll.dart';

//Importando cores
import 'package:finance_controll/assets/style/colors/colors_app.dart';

class MoneyControll extends StatefulWidget {

  const MoneyControll({super.key});

  @override
  State<MoneyControll> createState() => _MoneyControllState();
}

class _MoneyControllState extends State<MoneyControll>{

  bool isChecked = false;

  final List<DropdownMenuEntry<String>> months = [

    DropdownMenuEntry<String>(value: 'Janeiro', label: 'Janeiro'),
    DropdownMenuEntry<String>(value: 'Fevereiro', label: 'Fevereiro'),
    DropdownMenuEntry<String>(value: 'Março', label: 'Março'),
    DropdownMenuEntry<String>(value: 'Abril', label: 'Abril'),
    DropdownMenuEntry<String>(value: 'Maio', label: 'Maio'),
    DropdownMenuEntry<String>(value: 'Junho', label: 'Junho'),
    DropdownMenuEntry<String>(value: 'Julho', label: 'Julho'),
    DropdownMenuEntry<String>(value: 'Agosto', label: 'Agosto'),
    DropdownMenuEntry<String>(value: 'Setembro', label: 'Setembro'),
    DropdownMenuEntry<String>(value: 'Outubro', label: 'Outubro'),
    DropdownMenuEntry<String>(value: 'Novembro', label: 'Novembro'),
    DropdownMenuEntry<String>(value: 'Dezembro', label: 'Dezembro'),

  ];

  String selectedMonth = 'Janeiro';

  @override
  Widget build(BuildContext context){

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

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment .center,
          children: [

            DropdownMenu(
                textStyle: TextStyle(
                  color: ColorsApp.textColor
                ),
                selectOnly: true,
                dropdownMenuEntries: months, 
                initialSelection: months[0].value, 
                onSelected:(String? value){
                  
                  if(value != null){
                    selectedMonth = value;
                  }
                  else{
                    selectedMonth = 'Janeiro';
                  }
                  print(value);
                }
              ),

              SizedBox(height: 20),

            CardMoneyControll(
              title: "Faculdade",
              icon: Icons.add,
              subtitle: "Adicionar Receita",
            ),

            CardMoneyControll(
              title: "Alimentação",
              icon: Icons.remove,
              subtitle: "Adicionar Despesa",
            ),

          ],
        ),
      ),

    );

  }
}