//Importando pacotes
import 'package:flutter/material.dart';
import 'package:finance_controll/firebase/firebase_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:finance_controll/firebase/firebase_config.dart';

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

  final User? user_data = FirebaseAuth.instance.currentUser;

  final List<DropdownMenuEntry<String>> months = [

    DropdownMenuEntry<String>(value: '01', label: 'Janeiro'),
    DropdownMenuEntry<String>(value: '02', label: 'Fevereiro'),
    DropdownMenuEntry<String>(value: '03', label: 'Março'),
    DropdownMenuEntry<String>(value: '04', label: 'Abril'),
    DropdownMenuEntry<String>(value: '05', label: 'Maio'),
    DropdownMenuEntry<String>(value: '06', label: 'Junho'),
    DropdownMenuEntry<String>(value: '07', label: 'Julho'),
    DropdownMenuEntry<String>(value: '08', label: 'Agosto'),
    DropdownMenuEntry<String>(value: '09', label: 'Setembro'),
    DropdownMenuEntry<String>(value: '10', label: 'Outubro'),
    DropdownMenuEntry<String>(value: '11', label: 'Novembro'),
    DropdownMenuEntry<String>(value: '12', label: 'Dezembro'),

  ];

  String selectedMonth = DateTime.now().month.toString();

  void _showMessage(String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment .center,
            children: [

              DropdownMenu(
                textStyle: TextStyle(
                  color: ColorsApp.textColor
                ),
                selectOnly: true,
                dropdownMenuEntries: months, 
                initialSelection: DateTime.now().month.toString(), 
                onSelected:(String? value){

                  setState(() {
                    selectedMonth = value ?? DateTime.now().month.toString();
                  });

                  print(value);

                }
              ),
              SizedBox(height: 20),

              FutureBuilder(
                future: Firebase_config().getData_expenses(user_data?.uid), 
                builder: (context, snapshot){

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    return Text('Erro ao carregar gastos: ${snapshot.error}');
                  }

                  final raw = snapshot.data?.value;

                  if(raw is! Map || raw.isEmpty){

                    return const Text('Nenhum gasto encontrado', style: TextStyle(color: ColorsApp.textColor, fontSize: 30));

                  }

                  if(!raw.entries.map((e) => e.value['data']?.toString().split('-')[1]).contains(selectedMonth)){
                    return const Text('Nenhum gasto encontrado neste mês', style: TextStyle(color: ColorsApp.textColor, fontSize: 30),);
                  }

                  print(raw);

                  return Column(
                    children: raw.entries.map<Widget>((e){

                      final data = e.value;

                      final camps = Map<String, dynamic>.from(data);

                      final String name_item = camps["nome"].toString();
                      bool state_expense = camps["pago"];

                      return CardMoneyControll(
                        title: name_item, 
                        icon: Icons.abc, 
                        subtitle: "subtitle",
                        state_item: state_expense,
                        onChanged: (value) async{

                          setState(() {
                            state_expense = value!;
                          });

                          Map<String, dynamic> data = {
                            "pago": state_expense,
                          };
                          
                          final response = await Firebase_config().update_paid(user_data!.uid,  e.key.toString(), data);

                          print(response);

                          _showMessage(response);

                        },
                      );


                    }).toList()
                  );

                })
            ],
          ),
        )
      ),

    );

  }
}