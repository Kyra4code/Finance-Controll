import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 

//Importando cores
import '../../assets/style/colors/colors_app.dart';

//Estilizacao feita pelo Clude pq tava com preguica (FALO MESMO)

class CustomTextform extends StatelessWidget{

  final String title;
  final String subTitle;
  final TextInputType keyboardType;

  CustomTextform({
    super.key,
    required this.title,
    required this.subTitle,
    this.keyboardType = const TextInputType.numberWithOptions(decimal: true)

  });


  Widget build(BuildContext context){

    return TextFormField(
      style: const TextStyle(color: ColorsApp.textColor),
      cursorColor: ColorsApp.color_green,
      keyboardType: keyboardType,
      // aceita só dígitos, 1 separador (vírgula ou ponto) e até 2 casas decimais
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*[,.]?\d{0,2}')),
      ],
      validator: (value) {
        final number = double.tryParse((value ?? '').replaceAll(',', '.'));
        if (number == null || number <= 0) return 'Informe um valor válido';
        return null;
      },
      decoration: InputDecoration(
        labelText: title,
        labelStyle: TextStyle(color: ColorsApp.textMuted),
        floatingLabelStyle: TextStyle(color: ColorsApp.color_green),
        hintText: subTitle,
        hintStyle: TextStyle(color: ColorsApp.textMuted),
        errorStyle: TextStyle(color: ColorsApp.red),

        prefixIcon: Icon(Icons.attach_money),
        prefixIconColor: ColorsApp.textMuted,

        filled: true,
        fillColor: ColorsApp.card,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: ColorsApp.cardBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: ColorsApp.color_green, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: ColorsApp.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: ColorsApp.red, width: 2),
        ),
      ),
    );
  }

}// FilteringTextInputFormatter

