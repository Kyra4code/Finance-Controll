//Importando pacotes
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:finance_controll/firebase/firebase_config.dart';

//Importando compontentes
import '../../components/textformfield/custom_textform.dart';
import '../../components/buttons/customButton.dart';

//Importando cores
import '../../assets/style/colors/colors_app.dart';



class EditExpenses extends StatefulWidget {

  final String? key_item;

  EditExpenses({
    super.key,
    required this.key_item,

  });

  @override
  State<EditExpenses> createState() => _EditExpensesState();
}

class _EditExpensesState extends State<EditExpenses> {

  final User? user_data = FirebaseAuth.instance.currentUser;

  Map<String, dynamic> get value => {
    "data": dateSelected?.toIso8601String().split('T').first,
    "gasto": double.parse(expensesController.text.replaceAll(',', '.')),
    "nome": nameExpenses.text,
  };

  final nameExpenses = TextEditingController();
  final expensesController = TextEditingController();

  DateTime? dateSelected = DateTime.now();


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

  void _showMessage(String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }



  @override
  Widget build(BuildContext context) {

    //---------------------------------Functions voids dos botoes-----------------------------
    Future<void> delete_expenses() async {
      try {
        await Firebase_config().delete_expense_edit(user_data!.uid, widget.key_item);
        _showMessage("Gasto deletado com sucesso!");
        Navigator.of(context).pop();
      } catch (e) {
        _showMessage("Erro ao deletar gasto: $e");
      }
    }  

    Future<void> update_expense()async{

      if(nameExpenses.text == "" || expensesController.text == ""){

        _showMessage("Por favor, Preencha todos os campos para salvar !");
      }

      final response = await Firebase_config().update_expense(user_data!.uid, widget.key_item, value);

      _showMessage(response);

      print(response);

      Navigator.pop(context);
    }
    //-----------------------------------------------------------------------------------------

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
                  valueTextInput: expensesController,
                ),

                const SizedBox(height: 16),

                ElevatedButton(
                  onPressed: ()=> _showDatePicker(),
                  child: Text(dateSelected == null ?
                  "Selecione uma data":
                  "${dateSelected!.day.toString().padLeft(2)}/"
                  "${dateSelected!.month.toString().padLeft(2)}/"
                  "${dateSelected!.year.toString().padLeft(2)}"
                  )
                ),

                const SizedBox(height:50),

                CustomButton(
                  stateTrue: true,
                  title: "Atualizar",
                  onPress: () async => await update_expense()
                  ),

                const SizedBox(height: 18),

                CustomButton(
                  stateTrue: false, 
                  title: "Excluir",
                  onPress: () async {
                    await delete_expenses();
                  },
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}