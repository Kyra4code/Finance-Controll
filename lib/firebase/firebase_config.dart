import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

final FirebaseApp firebaseApp = Firebase.app();

class Firebase_config {

  final FirebaseDatabase rtdb = FirebaseDatabase.instanceFor(
    app: firebaseApp,
    databaseURL: 'https://database-money-control-default-rtdb.firebaseio.com/',
  );

  Future<DataSnapshot?> getData_User(String uid) async{

    final ref = rtdb.ref("/users/$uid");

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

  Future<DataSnapshot?> getData_expense_edit(String uid, String? key_item) async{

    final ref = rtdb.ref('gastos/$uid/$key_item');

    DataSnapshot data_expense = await ref.get();

    return data_expense;

  }

  Future<String> delete_expense_edit(String uid, String? key_item)async{

    try{

      final ref = rtdb.ref('gastos/$uid/$key_item');

      await ref.remove();

      return "O gasto foi deletado com sucesso!";
    }
    on FirebaseException catch (e){

      return "Erro no banco de dados. Tente novamente ($e)";
    }
    catch(e){
      return "Um erro inesperado aconteceu. Tente novamente!";

    }

  }

  Future<String> update_expense(String uid, String? key_item, Map<String, dynamic> value)async{

    try{

      final ref = rtdb.ref("gastos/$uid/$key_item");

      await ref.update(value);

      return "Gasto atualizado com sucesso !";

    }
    on FirebaseException catch(e){
      return "Erro no banco de dados. Tente novamente ($e)";
    }
    catch(e){
      return "Um erro inesperado aconteceu. Tente novamente!";

    }
  }

  Future<String> update_paid(String uid, String uid_item, Map<String, dynamic> state_trade)async{
    try{

      final ref = rtdb.ref("gastos/$uid/$uid_item");

      await ref.update(state_trade);

      bool? data_state; 

      data_state = state_trade.entries.map((e) => data_state).first;

      if(data_state == false){
         return "Gasto agora esta como nao pago !";
      }
      else{
        return "Gasto mudado para pago com sucesso !";
      }

    }
    on FirebaseException catch(e){
      return "Erro no banco de dados. Tente novamente ($e)";
    }
    catch(e){
      return "Um erro inesperado aconteceu. Tente novamente!";

    }

  }

}


