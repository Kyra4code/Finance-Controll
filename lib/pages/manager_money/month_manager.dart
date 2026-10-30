//Importando pacotes
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:finance_controll/firebase/firebase_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

//Importando telas
import './add_expenses.dart';
import './edit_expenses.dart';

//Importando componentes
import '../../components/cards/custom_card.dart';
import '../../components/custom_floatingactionbutton.dart';

//Importando cores
import '../../assets/style/colors/colors_app.dart';

class MonthManager extends StatefulWidget {


  MonthManager({super.key});

  @override
  State<MonthManager> createState() => _MonthManagerState();
}

class _MonthManagerState extends State<MonthManager> {
  final User? user_data = FirebaseAuth.instance.currentUser;

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

  late final Stream<DatabaseEvent> _gastosStream;

  void initState() {
    super.initState();

    _gastosStream = Firebase_config().rtdb.ref().onValue;

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

              StreamBuilder(
                stream: _gastosStream,
                builder: (context, snapshot) {
                  return FutureBuilder(
                    future: Firebase_config().getData_expenses(user_data?.uid), 
                    builder: (context, snap){

                    if (snap.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }

                    if (snap.hasError) {
                      return Text('Erro ao carregar gastos: ${snap.error}');
                    }

                    final raw = snap.data?.value;

                    if (raw is! Map || raw.isEmpty) {
                      return const Text('Nenhum gasto encontrado', style: TextStyle(color: ColorsApp.textColor, fontSize: 30),);
                    }

                    return Column(
                      children: raw.entries.map<Widget>((entry) {
                        final register = entry.value;

                        if (register is! Map) {
                          return const SizedBox.shrink();
                        }

                        final camps = Map<String, dynamic>.from(register);

                        final date = camps['data']?.toString() ?? entry.key.toString();
                        final name = camps['nome']?.toString() ?? 'Sem nome';
                        final expenses = camps['gasto']?.toString() ?? '0';
                        final paid = camps['pago'] == true ? 'Pago' : 'Pendente';

                        return CustomCard(
                          title: name,
                          icon: Icons.receipt,
                          subtitle: '$date • R\$ $expenses • $paid',
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => EditExpenses()),
                          ),
                        );
                      }).toList(),
                    );
                  });

                },
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