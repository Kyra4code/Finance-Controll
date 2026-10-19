//Importando pacotes
import 'package:flutter/material.dart';

//Importando compontentes
import '../../components/textformfield/custom_textform.dart';

//Importando cores
import '../../assets/style/colors/colors_app.dart';



class EditExpenses extends StatelessWidget {
  const EditExpenses({super.key});

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
                  subTitle: "Nome do item",
                  keyboardType: TextInputType.text,

                ),

                const SizedBox(height: 16),

                CustomTextform(
                  title: "Gastos", 
                  subTitle: "Ex: 200; 10,50 e etc",
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
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

                
                
                const SizedBox(height:50),

                ElevatedButton(
                  onPressed: null, 

                  style: ButtonStyle(
                    padding: WidgetStatePropertyAll(EdgeInsets.all(20.0)),
                    backgroundColor: WidgetStatePropertyAll<Color?>(Colors.green),
                    textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                    minimumSize: WidgetStatePropertyAll(Size(double.infinity, 55)),
                    
                    ),

                  child: const Text("Atualizar"),
                ),

                const SizedBox(height: 18),

                ElevatedButton(
                  onPressed: null, 

                  style: ButtonStyle(
                    padding: WidgetStatePropertyAll(EdgeInsets.all(20.0)),
                    backgroundColor: WidgetStatePropertyAll<Color?>(const Color.fromARGB(255, 230, 20, 20)),
                    textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                    minimumSize: WidgetStatePropertyAll(Size(double.infinity, 55)),
                    
                    ),

                  child: const Text("Excluir"),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}