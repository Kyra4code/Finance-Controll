import 'package:flutter/material.dart';
import './add_expenses.dart';

import '../../components/custom_floatingactionbutton.dart';


class MonthManager extends StatelessWidget {
  const MonthManager({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        leading: IconButton(
          onPressed: ()=> {
            Navigator.of(context).pop()
          },
          icon: Icon(Icons.arrow_back),

        ),
        title: const Text('Voltar')
      ),

      body:Center(
        child: Text("em produção"),
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