import 'package:flutter/material.dart';

class Chartbar extends StatelessWidget {
  final String label;
  final double spendamount;
  final double spendpercent;
  Chartbar(this.label, this.spendamount, this.spendpercent);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraint) {
      return Column(
        children: [
          Container(
              height: constraint.maxHeight*0.15,
              child: FittedBox(
                  child: Text('\$${spendamount.toStringAsFixed(0)}'))),
          SizedBox(
            height: constraint.maxHeight*0.05,
          ),
          Container(
              height: constraint.maxHeight*0.6,
              width: 10,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.0,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(220, 220, 220, 1)),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendpercent,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  )
                ],
              )),
          Container(height:constraint.maxHeight*0.15,
          
          child: FittedBox(child: Text(label))),
        ],
      );
    });
  }
}
