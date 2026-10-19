//Importando pacotes
import 'package:flutter/material.dart';

//Importando telas
import './add_expenses.dart';
import './edit_expenses.dart';
import '../../components/cards/custom_card.dart';
import '../../components/custom_floatingactionbutton.dart';

//Importando cores
import '../../assets/style/colors/colors_app.dart';


class MonthManager extends StatelessWidget {

  MonthManager({super.key});

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

      body:SingleChildScrollView(

        child: Center(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children:[

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

              CustomCard(
                title:"Faculdade",
                icon: Icons.school,
                subtitle: "22/10/2026",
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditExpenses()
                  )

                )

              ),

              SizedBox(height: 20),

              SizedBox(height: 1),

              CustomCard(
                title:"Alimentação",
                icon: Icons.fastfood,
                subtitle: "22/10/2026",
              ),
                
            ]
          )
        )
      ),

      floatingActionButton: CustomFloatingactionbutton(

        onPressed: () =>
        Navigator.of(context).push(

          MaterialPageRoute(

            builder: (context) => AddExpenses()

          )

        )
      )
    );
  }
}