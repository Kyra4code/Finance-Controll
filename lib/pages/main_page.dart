//Importando pacotes
import 'package:flutter/material.dart';

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


class MainPage extends StatelessWidget {

  final int bold_style = 1000;

  final double total_expenses = 200;
  final double total_wage = 1449.98;
 
  const MainPage({super.key});

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
                  fontWeight: FontWeight(bold_style) 
                ),
              ),
            
              SizedBox(height: 5),

              CustomPyChart(
                items: [
                  PyChartItem(
                    title: "Sobra do mes", 
                    value: total_wage, 
                    color: ColorsApp.color_green, 
                    textColor: ColorsApp.textColor
                  ),

                  PyChartItem(
                    title: "Gastos no mes", 
                    value: total_expenses, 
                    color: ColorsApp.red, 
                    textColor: ColorsApp.textColor
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
