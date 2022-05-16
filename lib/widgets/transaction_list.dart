import 'package:expense/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
final Function delete;

  TransactionList(this.transactions,this.delete);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 800,
        child: transactions.isEmpty
            ? Column(
                children: [
                  Text(
                    "No transaction yet!!!!!!!!!",
                    style: TextStyle(fontFamily: 'Quicksand'),
                  ),
                  Image.asset('asset/Images/new.gif',
                  height:MediaQuery.of(context).size.height*0.4)
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          child:Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: FittedBox(child: Text('\$${transactions[index].amount}')),
                          )
                        ),
                        title: Text(transactions[index].title,
                        style:Theme.of(context).textTheme.headline6),
                        subtitle: Text(DateFormat.yMMMd().format(transactions[index].date)),

                      trailing: MediaQuery.of(context).size.width>460?
                      // ignore: deprecated_member_use
                      FlatButton.icon(
                        icon: Icon(Icons.delete),
                        label: Text('delete'),
                        textColor:Theme.of(context).errorColor ,
                      onPressed: ()=>delete(transactions[index].id),
                      )
                      :IconButton(icon: Icon(Icons.delete),
                      color:Theme.of(context).errorColor,
                      onPressed: ()=>delete(transactions[index].id),
                      )));
                },
                itemCount: transactions.length,
              ));
  }
}
