import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function selecthandler;

  NewTransaction(this.selecthandler);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titlecontroller = TextEditingController();

DateTime ?selecteddate; 
  final amountcontroller = TextEditingController();

  void _submitdata() {
    if(amountcontroller.text==null)
    {
      return;
    }
    final enteredtitle=titlecontroller.text; 
    final enteredamount=double.parse(amountcontroller.text);
    if(enteredtitle.isEmpty || enteredamount<=0||selecteddate==null)
    {
      return ;
    }
    widget.selecthandler(enteredtitle,enteredamount,selecteddate);
    Navigator.of(context).pop();
  }

void _datepicker(){
  showDatePicker(context: context, initialDate: DateTime.now(), firstDate:DateTime(2022), lastDate: DateTime.now()).then((pickeddate){
if(pickeddate==null)
return;
setState(() {
  selecteddate=pickeddate;
});
  });
}
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: SingleChildScrollView(
        child: Container(
        
          padding: EdgeInsets.only(top: 10,left: 10,right: 10,bottom:MediaQuery.of(context).viewInsets.bottom+10),
         child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: titlecontroller,
                autocorrect: true,
                autofocus: true,
                onSubmitted: (_)=>_submitdata(),
                decoration: InputDecoration(
                  labelText: 'Title',
                  
                  border: OutlineInputBorder(),
                ),
              ),
              TextField(
                keyboardType: TextInputType.numberWithOptions(),
                onSubmitted: (_) =>_submitdata() ,
                controller: amountcontroller,
                decoration: InputDecoration(
                    alignLabelWithHint: true,
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    labelText: 'Amount'),
              ),
            Container(
              height:80,
              child: Row(children: [
               Text(selecteddate==null ?'no date ':'Picked date:${DateFormat.yMd().format(selecteddate!)}'),
                // ignore: deprecated_member_use
                Expanded(
                  // ignore: deprecated_member_use
                  child: FlatButton(onPressed: _datepicker,
                
                  
                  textColor: Theme.of(context).primaryColor,
                            child: Text("Choose date")),
                )
              ],),
            ),
              // ignore: deprecated_member_use
              RaisedButton(
                  onPressed:_submitdata,
                  child: Text('ADD TRANSACTION'),
                  color:Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button!.color,
                     )
            ],
          ),
        ),
      ),
    );
  }
}
