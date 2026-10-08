import 'package:flutter/material.dart';

class MonthManager extends StatelessWidget {
  const MonthManager({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar mês')
      ),

      body: ListView.builder(
        itemCount: 30,
        itemBuilder: (context, index) {
          
          return ListTile(

            title: Text('Lançamento ${index + 1}'),
            subtitle: const Text('R\$ 0,00'),

          );

        },
      ),
    );
  }
}