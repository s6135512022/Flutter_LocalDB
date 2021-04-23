import 'package:flutter/material.dart';
import 'package:flutter_database/models/Transactions.dart';
import 'package:flutter_database/providers/transaction_provider.dart';
import 'package:flutter_database/screens/home_screen.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class FormScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  // controller
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Customer Information"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: new InputDecoration(labelText: "Name"),
                  autofocus: false,
                  controller: firstnameController,
                  validator: (String str) {

                    if (str.isEmpty) {
                      return "Please Enter Name";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: new InputDecoration(labelText: "Surname"),
                  autofocus: false,
                  controller: lastnameController,
                  validator: (String str) {

                    if (str.isEmpty) {
                      return "Please Enter Surname";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: new InputDecoration(labelText: "Phone Number"),
                  keyboardType: TextInputType.number,
                  controller: phoneController,
                  validator: (String str) {
                    if (str.isEmpty) {
                      return "Please Enter Phone Number";
                    }
                    if (double.parse(str) <= 10) {
                      return "Please Enter 10 Digits of Phone Number";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: new InputDecoration(labelText: "Address"),
                  autofocus: false,
                  controller: addressController,
                  validator: (String str) {

                    if (str.isEmpty) {
                      return "Please Enter Phone Number";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: new InputDecoration(labelText: "Username"),
                  autofocus: false,
                  controller: usernameController,
                  validator: (String str) {

                    if (str.isEmpty) {
                      return "Please Enter Username";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: new InputDecoration(labelText: "Password"),
                  keyboardType: TextInputType.number,
                  controller: passwordController,
                  validator: (String str) {
                    if (str.isEmpty) {
                      return "Please Enter Password";
                    }
                    if (double.parse(str) <= 10) {
                      return "Please Enter 10 Digits of Password";
                    }
                    return null;
                  },
                ),
                FlatButton(
                  child: Text("Add"),
                  color: Colors.lightGreen,
                  textColor: Colors.white,
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      var firstname = firstnameController.text;
                      var lastname = lastnameController.text;
                      var phone = phoneController.text;
                      var address = addressController.text;
                      var username = usernameController.text;
                      var password = passwordController.text;

                      Transactions statement = Transactions(
                          firstname: firstname,
                          lastname: lastname,
                          phone: phone,
                          address: address,
                          username: username,
                          password: password,
                          date: DateTime.now()); //object


                      var provider = Provider.of<TransactionProvider>(context,
                          listen: false);
                      provider.addTransaction(statement);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (context) {
                                return MyHomePage();
                              }));
                    }
                  },
                )
              ],
            ),
          ),
        ));
  }
}
