import 'package:flutter/material.dart';
// import '../style/colors/colors.json';
import './manager_money/month_manager.dart';

import './manager_money/add_expenses.dart';

import '../components/custom_floatingactionbutton.dart';


class MainPage extends StatelessWidget {
 

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
                Icons.money
              ),

              title: Text("Pagamentos"),

              onTap: ()=>{
                // Navigator.of(context).push(
                //   MaterialPageRoute<void>(
                //     builder: (context)=> MonthManager()
                //   )
                // )

              }
            ),

            ListTile(

              leading: Icon(
                Icons.settings
              ),

              title: Text("Configurações"),

              onTap: ()=>{
                // Navigator.of(context).push(
                //   MaterialPageRoute<void>(
                //     builder: (context)=> MonthManager()
                //   )
                // )

              }
            )

          ],

        ),

      ),

      body: Container(

        child: const Center(

          child: Text("Seu gasto foi xxxx")

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
