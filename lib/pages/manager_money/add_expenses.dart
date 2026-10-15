// import 'dart:ffi';

import 'package:flutter/material.dart';

class AddExpenses extends StatelessWidget {
  const AddExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        title: const Text('Nova despesa'),

      ),

      body: Center(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(16),

          child: ConstrainedBox(

            constraints: const BoxConstraints(maxWidth: 500),

            child: Column(

              mainAxisSize: MainAxisSize.min,

              children: [

                TextFormField(
                  textInputAction: TextInputAction.next,

                  textCapitalization: TextCapitalization.sentences,

                  decoration: const InputDecoration(

                    icon: Icon(Icons.shopping_bag_outlined),

                    hintText: 'Nome do item',

                    labelText: 'Nome',
                  ),

                ),

                const SizedBox(height: 16),

                TextFormField(

                  keyboardType: const TextInputType.numberWithOptions(decimal: true),

                  decoration: const InputDecoration(

                    icon: Icon(Icons.attach_money),

                    hintText: 'Apenas número (exemplo: 200; 10,50)',

                    labelText: 'Gastos *',

                  ),

                ),

                const SizedBox(height: 16),

                ElevatedButton(
                  onPressed: (){

                    Future<DateTime?> select_date = showDatePicker(
                      context: context, 
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000), 
                      lastDate: DateTime(2100),
                      builder: (BuildContext context, Widget? child ){
                        return Theme(
                          data: ThemeData.dark(), 
                          child: child!
                        );
                      }
                    );
                      

                  }, 

                  child: const Text("Selecionar data")
                ),

                
                
                const SizedBox(height: 70),

                ElevatedButton(
                  onPressed: null, 

                  style: ButtonStyle(
                    padding: WidgetStatePropertyAll(EdgeInsets.all(20.0)),
                    backgroundColor: WidgetStatePropertyAll<Color?>(Colors.green),
                    textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                    minimumSize: WidgetStatePropertyAll(Size(double.infinity, 55)),
                    
                    ),

                  child: const Text("Adicionar"),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}