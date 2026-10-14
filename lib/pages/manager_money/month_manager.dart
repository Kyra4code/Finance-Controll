import 'package:flutter/material.dart';
import './add_expenses.dart';

class MonthManager extends StatelessWidget {
  const MonthManager({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar mês')
      ),

      body:Center(
        child: Text("em produção"),
      ),

      floatingActionButton: FloatingActionButton(
        
        
        
        
        onPressed: ()=>{
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (context)=>Add_expenses()
            )
          )
        },

      ),
    );
  }
}