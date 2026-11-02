//Importando pacotes
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
                initialSelection: DateTime.now().month.toString(), 
                onSelected:(String? value) {

                  setState(() {
                    selectedMonth = value ?? DateTime.now().month.toString();
                  });
                  
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

                    if(!raw.entries.map((e) => e.value['data']?.toString().split('-')[1]).contains(selectedMonth)){
                      return const Text('Nenhum gasto encontrado neste mês', style: TextStyle(color: ColorsApp.textColor, fontSize: 30),);
                    }

                    return Column(
                      
                      children: raw.entries.map<Widget>((entry) {
                        final register = entry.value;

                        if (register is! Map) {
                          return const SizedBox.shrink();
                        }

                        final camps = Map<String, dynamic>.from(register);

                        if(camps['data']?.toString().split("-")[01] != selectedMonth){
                          return const SizedBox.shrink();
                        }
                        
                        final date = camps['data']?.toString() ?? entry.key.toString();
                        final name = camps['nome']?.toString() ?? 'Sem nome';
                        final expenses = camps['gasto']?.toString() ?? '0';
                        final paid = camps['pago'] == true ? 'Pago' : 'Pendente';


                        return CustomCard(
                          title: name,
                          icon: Icons.receipt,
                          subtitle: '$date • R\$ $expenses • $paid',
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => EditExpenses(key_item: entry.key.toString())),
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