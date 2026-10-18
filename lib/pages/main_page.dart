//Importando pacotes
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

//Importando telas
import './manager_money/month_manager.dart';
import './manager_money/add_expenses.dart';
import './/money_controll/money_controll.dart';
import './settings/settings_page.dart';

//Importando componentes
import '../components/custom_floatingactionbutton.dart';
import '../components/py_chart/custom_pychart.dart';


class MainPage extends StatelessWidget {

  final int bold_style = 1000;

  final double total_expenses = 200;
  final double total_wage = 1449.98;
 
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),

      drawer: Drawer(

        child: ListView(

          padding: EdgeInsets.all(8.0),

          children: [

            const DrawerHeader(

              // decoration: BoxDecoration(color: Colors.white),

              child: Center(

                child: Text("Selecione uma pagina"),

              )
            ),


            ListTile(

              leading: Icon(
                Icons.calendar_month
              ),

              title: Text("Gerenciamento de Gastos"),

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
                Icons.money_off_rounded
              ),

              title: Text("Controle de dividas"),

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
                Icons.settings
              ),

              title: Text("Configurações"),

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
                  color: Colors.black,
                  fontSize: 29,
                  fontWeight: FontWeight(bold_style) 
                ),
              ),
            
              SizedBox(height: 5),

              CustomPyChart(
                items: [
                  PyChartItem(
                    title: "Sobra do mes", 
                    value: total_wage, 
                    color: Colors.green, 
                    textColor: Colors.black
                  ),

                  PyChartItem(
                    title: "Gastos no mes", 
                    value: total_expenses, 
                    color: Colors.red, 
                    textColor: Colors.black
                  )

                ],

              ),

            

          ],

        ) 
      ),

      floatingActionButton: CustomFloatingactionbutton(
        onPressed: ()=> 
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=> const AddExpenses())
          )
      )
    );
  }
}
