import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

final FirebaseApp firebaseApp = Firebase.app();

class Firebase_config {

  final FirebaseDatabase rtdb = FirebaseDatabase.instanceFor(
    app: firebaseApp,
    databaseURL: 'https://database-money-control-default-rtdb.firebaseio.com/',
  );

  Future<DataSnapshot?> getData_User(String? uid) async{

    DatabaseReference ref = rtdb.ref("/users/$uid");

    DataSnapshot data_user = await ref.get();

    return data_user;

    
  }

  Future<DataSnapshot?> getData_expenses(String? uid) async{

    DatabaseReference ref = rtdb.ref("/gastos/$uid");

    DataSnapshot data_user = await ref.get();

    return data_user;

  }

  Future<String> saveExpenses(String? uid, Map<String, dynamic> data)async{

    try{

      final ref = rtdb.ref("gastos/$uid");

      await ref.push().set(data);

      return "Dados salvos com sucesso!"; 

    }
    on FirebaseException catch (e){

      return "Nao foi possivel salvar no banco de dados. Tente novamente ($e)";
    }
    catch(e){
      return "Um erro inespeerado aconteceu. Tente novamente!";
    }

  }

}



