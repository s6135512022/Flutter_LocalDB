import 'package:flutter/foundation.dart';
import 'package:flutter_database/database/transaction_db.dart';
import 'package:flutter_database/models/Transactions.dart';

class TransactionProvider with ChangeNotifier{

      List<Transactions> transactions = [];

      // fetch
      List<Transactions> getTransaction(){
        return transactions;
      }
      void initData() async{
          var db=TransactionDB(dbName: "transactions.db");

          transactions=await db.loadAllData();
          notifyListeners();
      }
      
      void addTransaction(Transactions statement) async{
          var db=TransactionDB(dbName: "transactions.db");
          //save data
          await db.InsertData(statement);

          transactions=await db.loadAllData();
          //notify Consumer
          notifyListeners();
      }
}