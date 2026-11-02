//Importando pacotes
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:finance_controll/firebase/firebase_config.dart';


//Importando telas
import './manager_money/month_manager.dart';
import './manager_money/add_expenses.dart';
import './/money_controll/money_controll.dart';
import './settings/settings_page.dart';

//Importando componentes
import '../components/custom_floatingactionbutton.dart';
import '../components/py_chart/custom_pychart.dart';

//Importando arquivos de estilizacao
import '../assets/style/colors/colors_app.dart';


class MainPage extends StatefulWidget {

  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  double totalExpenses = 0;
  double totalWage = 0;

  final User? user_data = FirebaseAuth.instance.currentUser;

  late final Stream<DatabaseEvent> _userStream;

  late final Stream<DatabaseEvent> _expenseStream;

  @override
  void initState() {
    super.initState();

    _userStream = Firebase_config().userStream(user_data!.uid);

    _expenseStream = Firebase_config().userStream(user_data!.uid);

    _loadWage();
    _loadExpenses();
  }

  Future<void> _loadWage()async{

    final DataSnapshot? data = await Firebase_config().getData_User(user_data!.uid);

    final raw = data?.value;

    if (raw is! Map) return;

    final wage = (raw['salario'] as num?)?.toDouble() ?? 0;

    if (!mounted) return;
    setState(() => totalWage = wage);

  }

  Future<void> _loadExpenses()async{

     final DataSnapshot? data = await Firebase_config().getData_expenses(user_data!.uid);

     final raw = data?.value;

     if (raw is! Map) return;

     double soma = 0;

    for(final entry in raw.entries){

      final value = entry.value;
      if (value is! Map) continue;
      soma += double.tryParse(value['gasto'].toString()) ?? 0;
    }

    if (!mounted) return;
    setState(() => totalExpenses = soma);

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorsApp.color_background,

      appBar: AppBar(

        backgroundColor: ColorsApp.color_background,

        title: Center(
          child:Text(
            "Home",
            style:TextStyle(
              color: ColorsApp.textColor
            )
          )),

        iconTheme: IconThemeData(
          color: ColorsApp.textColor
        ), 
        
      ),

      drawer: Drawer(
        backgroundColor: ColorsApp.color_background,
        surfaceTintColor: ColorsApp.textColor,

        child: ListView(

          padding: EdgeInsets.all(8.0),

          children: [

            const DrawerHeader(

              // decoration: BoxDecoration(color: Colors.white),

              child: Center(

                child: Text(
                  "Selecione uma pagina",
                  style: TextStyle(
                    color:ColorsApp.textColor
                  ),
                ),

              )
            ),


            ListTile(

              leading: Icon(
                Icons.calendar_month,
                color:ColorsApp.textColor 
              ),

              title: Text(
                "Gerenciamento de Gastos",
                style: TextStyle(
                  color: ColorsApp.textColor
                ),
                ),

              onTap: ()=>{
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (context)=> MonthManager()
                  )
                )
              }
            ),

            ListTile(

              leading: Icon(
                Icons.money_off_rounded,
                color:ColorsApp.textColor ,
              ),

              title: Text(
                "Controle de dividas",
                style: TextStyle(
                  color: ColorsApp.textColor
                ),
              ),

              onTap: ()=>{
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (context)=> MoneyControll()
                  )
                )

              }

            ),

            ListTile(

              leading: Icon(
                Icons.settings,
                color:ColorsApp.textColor 
              ),

              title: Text(
                "Configurações",
                  style: TextStyle(
                  color: ColorsApp.textColor
                ),
              ),

              onTap: ()=>{
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (context)=> SettingsPage()
                  )
                )
              }

            )

          ],

        ),

      ),

      body: Center(

        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Text(
              "Controle financeiro mensal",
              style: TextStyle(
                color: ColorsApp.textColor,
                fontSize: 29,
                fontWeight: FontWeight(1000) 
              ),
            ),
            
            SizedBox(height: 5),

            StreamBuilder(
              stream: _expenseStream, 
              builder: (context, snapshot){
                return StreamBuilder(
                  stream: _userStream, 
                  builder: (context, snap){

                    _loadExpenses();

                    if (snapshot.connectionState == ConnectionState.waiting || snap.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError || snap.hasError) {
                      return Text('Erro: ${snapshot.error}');
                    }

                    final rest = totalWage - totalExpenses;

                    return CustomPyChart(
                      items: [
                        PyChartItem(
                          title: "${rest.toStringAsFixed(2)} R\$",
                          value: totalWage,
                          color: ColorsApp.color_green,
                          textColor: ColorsApp.textColor,
                        ),
                        PyChartItem(
                          title: '${totalExpenses.toStringAsFixed(2)} R\$',
                          value: totalExpenses,
                          color: ColorsApp.red,
                          textColor: ColorsApp.textColor,
                        )
                      ],
                    );
                });
              })
          ],

        ) 
      ),

      floatingActionButton: CustomFloatingactionbutton(
        onPressed: ()=> 
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=> AddExpenses())
          )
      )
    );
  }
}
