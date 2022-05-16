import 'package:expense/models/transaction.dart';
import 'package:expense/widgets/chart.dart';
import 'package:expense/widgets/new_transaction.dart';
import 'package:expense/widgets/transaction_list.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    MaterialApp(
        home: Expense(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme: ThemeData.light()
                .textTheme
                .copyWith(button: TextStyle(color: Colors.white)),
            appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                      headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  )),
            ),
            hoverColor: Colors.lightBlueAccent,
            primarySwatch: Colors.purple,
            fontFamily: 'Quicksand ')),
  );
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
}

class Expense extends StatefulWidget {
  @override
  _ExpenseState createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 16.53,
    //   date: DateTime.now(),
    // ),
  ];
  bool _showchart=false;
  void _deletetransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  void _addNewTransaction(
      String txtitle, double txamount, DateTime chosendate) {
    final newtx = Transaction(
        id: DateTime.now().toString(),
        title: txtitle,
        amount: txamount,
        date: chosendate);
    setState(() {
      _userTransactions.add(newtx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
              child: NewTransaction(_addNewTransaction), onTap: () {});
        });
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((txn) {
      return txn.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    print(_recentTransactions);
    final _islandscape=MediaQuery.of(context).orientation==Orientation.landscape;
    final appbar = AppBar(title: Text("Expense"), centerTitle: true, actions: [
      IconButton(
          onPressed: () => _startAddNewTransaction(context),
          icon: Icon(
            Icons.add,
            semanticLabel: "hi",
          ))
    ]);
    final txlist=Container(
                 height:( MediaQuery.of(context).size.height-appbar.preferredSize.height-MediaQuery.of(context).padding.top)*0.7,
                  child: TransactionList(_userTransactions, _deletetransaction));
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [ if(_islandscape)
              Row(children: [
              Text("Show chart"),
 Switch(value: _showchart, onChanged: (val){
                setState(() {
                  _showchart=val;
                });
              })
            ],),
            if(!_islandscape) Container(
                  height:( MediaQuery.of(context).size.height-appbar.preferredSize.height-MediaQuery.of(context).padding.top)*0.3,
                  child: Chart(_recentTransactions)),
                  if(!_islandscape)txlist,
    if(_islandscape)
    _showchart?         
              Container(
                  height:( MediaQuery.of(context).size.height-appbar.preferredSize.height-MediaQuery.of(context).padding.top)*0.7,
                  child: Chart(_recentTransactions))
              :txlist,
            ]),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
      
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
