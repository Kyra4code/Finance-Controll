//Importando pacotes
import 'package:flutter/material.dart';

//Importando componentes
import '../../components/textformfield/custom_textform.dart';

//Importando cores
import '../../assets/style/colors/colors_app.dart';

class AddExpenses extends StatelessWidget {
  const AddExpenses({super.key});

  @override
  Widget build(BuildContext context) {
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

      body: Center(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(16),

          child: ConstrainedBox(

            constraints: const BoxConstraints(maxWidth: 500),

            child: Column(

              mainAxisSize: MainAxisSize.min,

              children: [

                CustomTextform(
                  title: "Nome", 
                  subTitle: "Nome do item"

                ),

                const SizedBox(height: 16),

                CustomTextform(
                  title: "Gastos", 
                  subTitle: "Ex: 200; 10,50 e etc"
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