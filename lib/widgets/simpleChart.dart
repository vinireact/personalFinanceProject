import 'package:finance/mainTree.dart';
import 'package:finance/widgets/mapChart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SimpleChart extends StatelessWidget {
  final List<Token>? tokenMasterListFilter;
  SimpleChart({this.tokenMasterListFilter});

  List<Map<String, Object>> listMap() => List.generate(
        7,
        (index) {
          var weekDay = DateTime.now().subtract(Duration(days: index));
          double totalSum = 0.0;
          for (Token aux in tokenMasterListFilter!) {
            bool sameDay = aux.date!.day == weekDay.day;
            bool sameMonth = aux.date!.month == weekDay.month;
            bool sameYear = aux.date!.year == weekDay.year;
            if (sameDay && sameMonth && sameYear) {
              totalSum = totalSum + aux.value!;
            }
          }
          return {
            'day': DateFormat.E().format(weekDay),
            'value': totalSum,
          };
        },
      ).reversed.toList();

  @override
  Widget build(BuildContext context) {
    double foldValue = listMap().fold(
      0.0,
      (previousValue, element) => previousValue + (element['value'] as double),
    );
    return Container(
      width: double.infinity,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: listMap()
                .map(
                  (e) => MapChart(
                    weekDay: e['day'].toString(),
                    value: e['value'] as double,
                    percent: foldValue == 0
                        ? 0.0
                        : (e['value'] as double) / foldValue,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
