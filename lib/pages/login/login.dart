//Importand pacotes
import 'package:flutter/material.dart';

//Importando componentes
import 'package:finance_controll/components/textformfield/custom_textform.dart';
import 'package:finance_controll/components/buttons/customButton.dart';

//Importando Cores
import 'package:finance_controll/assets/style/colors/colors_app.dart';



class LoginPage extends StatefulWidget{

  const LoginPage({
    super.key
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  Widget build(BuildContext context){

    return Scaffold(

      backgroundColor: ColorsApp.color_background,

      body: Center(

        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450),

          child: Column(

            mainAxisSize: MainAxisSize.min,

            children: [

              Text(
                "Login",
                style: TextStyle(
                  color: ColorsApp.textColor,
                  fontSize: 40,
                  fontWeight: FontWeight(700)
                ),
              
              ),

              SizedBox(height: 60),


              CustomTextform(
                title: "Email", 
                subTitle: "exemple@gmail.com",
                icons: Icon(Icons.mail),
                keyboardType: TextInputType.emailAddress,
              ),

              SizedBox(height: 20),

              CustomTextform(
                title: "Senha", 
                subTitle: "",
                icons: Icon(Icons.password),
                keyboardType: TextInputType.text,
              ),

              SizedBox(height: 28),

              CustomButton(
                stateTrue: true, 
                title: "Login"
              )
            ],
          ),
        )
      ),
      
    );
  }
}