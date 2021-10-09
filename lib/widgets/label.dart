import 'package:finance/mainTree.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Label extends StatelessWidget {
  final Token? token;
  final Function(String) fn;
  const Label({this.token, required this.fn});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      child: Card(
        elevation: 4,
        child: Row(
          children: [
            Container(
              height: 30,
              padding: const EdgeInsets.only(left: 5, right: 5),
              margin: const EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  'R\$' + token!.value!.toStringAsFixed(2),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    token!.title!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    DateFormat('dd MMM y').format(token!.date!),
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: IconButton(
                onPressed: () => fn(token!.id!),
                icon: Icon(Icons.delete),
              ),
            )
          ],
        ),
      ),
    );
  }
}
