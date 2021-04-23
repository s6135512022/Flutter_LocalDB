import 'dart:io';

import 'package:flutter_database/models/Transactions.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class TransactionDB {
  //DBMS

  String dbName; //Collect DB Name


  TransactionDB({this.dbName});

  Future<Database> openDatabase() async {
    //find db address
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbName);
    //create database
    DatabaseFactory dbFactory = await databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  //save data
  Future<int> InsertData(Transactions statement) async {

    // transaction.db => expense
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("expense");

    // json
    var keyID = store.add(db, {
      "firstname": statement.firstname,
      "lastname": statement.lastname,
      "phone": statement.phone,
      "address": statement.address,
      "username": statement.username,
      "password": statement.password,
      "date": statement.date.toIso8601String()
    });
    db.close();
    return keyID;
  }

  //fetch


  Future<List<Transactions>> loadAllData() async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("expense");
    var snapshot = await store.find(db,
        finder: Finder(sortOrders: [SortOrder(Field.key, false)]));
    List transactionList = List<Transactions>();

    for (var record in snapshot) {
      transactionList.add(Transactions(
          firstname: record["firstname"],
          lastname: record["lastname"],
          phone: record["phone"],
          address: record["address"],
          username: record["username"],
          password: record["password"],
          date: DateTime.parse(record["date"])));
    }
    return transactionList;
  }
}
