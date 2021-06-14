import 'package:flutter/material.dart';
import 'package:gasfast/src/models/moves/deposit_response.dart';
import 'package:intl/intl.dart';

class CardMovements extends StatelessWidget {
  final Deposit? deposit;
  const CardMovements({Key? key, this.deposit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final format = DateFormat('yyyy/MM/dd');
    var formatter = NumberFormat.currency(locale: "es_MX", symbol: "\$");
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Card(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: size.height * 0.12,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: size.width * 0.25,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Importe',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                          Text('${formatter.format(deposit!.balance)}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17))
                        ],
                      ),
                    ),
                    Container(
                      width: size.width * 0.3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Fecha',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                          Text(
                              '${format.format(DateTime.parse(deposit!.date.toString()))}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17))
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: size.width * 0.25,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Status',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16)),
                          Text('Autorizado',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17))
                        ],
                      ),
                    ),
                    Container(
                      width: size.width * 0.3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hora',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16)),
                          Text('${deposit!.hour}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17))
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
