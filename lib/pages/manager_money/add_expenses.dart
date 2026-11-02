//Importando pacotes
import 'package:flutter/material.dart';
import 'package:finance_controll/firebase/firebase_config.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Importando componentes
import 'package:finance_controll/components/textformfield/custom_textform.dart';
import 'package:finance_controll/components/buttons/customButton.dart';

//Importando cores
import '../../assets/style/colors/colors_app.dart';

class AddExpenses extends StatefulWidget{

  AddExpenses({super.key});

  @override
  State<AddExpenses> createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses> {

  final User? user_data = FirebaseAuth.instance.currentUser;

  Map<String, dynamic> get data => {
    "data": dateSelected?.toIso8601String().split('T').first,
    "gasto": double.parse(expensesValue.text.replaceAll(',', '.')),
    "nome": nameExpenses.text,
    "pago": false
  };

  final expensesValue = TextEditingController();

  final nameExpenses = TextEditingController();

  DateTime? dateSelected = DateTime.now();


    //Metodo para ativar o showDatePicker
    Future<void> _showDatePicker()async{

      final DateTime? date = await showDatePicker(
        context: context, 
        currentDate: dateSelected ?? DateTime.now(),
        initialDate: dateSelected ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        builder: (BuildContext context, Widget? child ){
          return Theme(
            data: ThemeData.dark(), 
            child: child!
          );
        }
      );

      if (date != null) {
        setState(() => dateSelected = date);
      }
      else{

        setState(() => dateSelected = DateTime.now());
      }

    }


  //Messangem q aparece no canto inferior da tela.
  void _showMessage(String text) {
    // if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context){

    Future<void> save_expense()async{

      try{

        if(nameExpenses.text == "" || expensesValue.text == ""){

          _showMessage("Por favor, Preencha todos os campos para salvar !");
          print("Por favor, Preencha todos os campos para salvar !");

        }

        final response = await Firebase_config().saveExpenses(user_data?.uid, data);

        _showMessage(response);
        print(response);

        Navigator.of(context).pop();

        }

      catch(e){
        print("Error catch: $e");
      }


    }
    //Renderizacao da tela:
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
                  icons: Icon(Icons.shopping_bag),
                  valueTextInput: nameExpenses,
                ),

                const SizedBox(height: 16),

                CustomTextform(
                  title: "Gastos", 
                  subTitle: "Ex: 200; 10,50 e etc",
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  valueTextInput: expensesValue,
                ),

                const SizedBox(height: 16),

                ElevatedButton(
                  onPressed: _showDatePicker,

                  child: Text(
                    dateSelected == null
                    ? "Selecionar data"
                    : "${dateSelected!.day.toString().padLeft(2, '0')}/"
                    "${dateSelected!.month.toString().padLeft(2, '0')}/"
                    "${dateSelected!.year}",
                  ),                  
                ),

                const SizedBox(height: 70),

                CustomButton(
                  stateTrue: true, 
                  title: "Adicionar",
                  onPress: () async=> await save_expense(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}