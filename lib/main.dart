// Importando pacotes
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Importando telas
import 'package:finance_controll/pages/main_page.dart';
import 'package:finance_controll/pages/login/login.dart';



Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();

  try{

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

  }
  catch(e, st){
    debugPrint('Falha ao inicializar o Firebase: $e\n$st');
    print("ERROR: $e");
    return;
  }

  runApp(MaterialApp(home:AuthGate()));

}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          return const MainPage();
        }

        return LoginPage(); // adicione `const` se o construtor for const
      },
    );
  }
}