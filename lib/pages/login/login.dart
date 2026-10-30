//Importand pacotes
import 'package:flutter/material.dart';

//Importando componentes
import 'package:finance_controll/components/textformfield/custom_textform.dart';
import 'package:finance_controll/components/buttons/customButton.dart';
import 'package:firebase_auth/firebase_auth.dart';


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

  final _email_controller = TextEditingController();
  final _password_controller = TextEditingController();
  bool _isLoading = false;


  void _showMessage(String text) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }


  Future<void> _login() async{

    final email = _email_controller.text.trim();
    final password = _password_controller.text;
    
    if (email.isEmpty || password.isEmpty) {
      _showMessage('Preencha o email e a senha.');
      return;
    }

    setState(() => _isLoading = true);

   try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

    } 
    on FirebaseAuthException catch (e) {
      _showMessage(e.code);
    } 
    catch (e) {
      debugPrint('Erro inesperado no login: $e');
      _showMessage('Erro inesperado. Tente novamente.');
    } 
    finally {
      if (mounted) setState(() => _isLoading = false);
    }
    
  }


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
                valueTextInput:_email_controller,
              ),

              SizedBox(height: 20),

              CustomTextform(
                title: "Senha", 
                subTitle: "",
                icons: Icon(Icons.password),
                keyboardType: TextInputType.text,
                valueTextInput: _password_controller,
              ),

              SizedBox(height: 28),

              CustomButton(
                stateTrue: true, 
                title: _isLoading? "Entrando...": "Login",
                onPress: _isLoading ? null : _login,
                
              )
            ],
          ),
        )
      ),
      
    );
  }
}
