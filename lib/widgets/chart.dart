import 'package:expense/models/transaction.dart';
import 'package:expense/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recenttransactions;

  Chart(this.recenttransactions);
  List<Map<String, dynamic>> get groupedtransactions {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      var totalsum = 0.0;
      for (var i = 0; i < recenttransactions.length; i++) {
        if (recenttransactions[i].date.day == weekday.day &&
            recenttransactions[i].date.month == weekday.month &&
            recenttransactions[i].date.year == weekday.year) {
          totalsum += recenttransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekday).substring(0,1),
        'amount': totalsum,
      };
    }).reversed.toList();
  }
double get maxSpending{
  return groupedtransactions.fold(0.0, (sum, element) {
    return sum + element['amount']; 
  });
}
  @override
  Widget build(BuildContext context) {
    print(groupedtransactions);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
    
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
             ...groupedtransactions.map((data){
                return Flexible(
                  fit:FlexFit.tight,
                  child: Chartbar(data['day'], data['amount'], 
                  maxSpending==0.0?0.0:(data['amount'] as double)/ maxSpending),
                );
              }).toList()
            ],
          ),
        ),
      );
    
  }
}
