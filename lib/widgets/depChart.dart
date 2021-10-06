import 'package:finance/mainTree.dart';
import 'package:finance/widgets/charts_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DepChart extends StatelessWidget {
  final List<Token>? tokenMasterListFilter;
  DepChart({this.tokenMasterListFilter});

  List<Map<String, Object>> listMap() => List.generate(
        7,
        (index) {
          var weekDay = DateTime.now().subtract(Duration(days: index));
          String weekDayConvert(String wDay) {
            if (wDay == 'Tue') {
              return 'Ter';
            } else if (wDay == 'Mon') {
              return 'Seg';
            } else if (wDay == 'Sun') {
              return 'Dom';
            } else if (wDay == 'Sat') {
              return 'Sab';
            } else if (wDay == 'Fri') {
              return 'Sex';
            } else if (wDay == 'Thu') {
              return 'Qui';
            } else {
              return 'Qua';
            }
          }

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
            'day': weekDayConvert(DateFormat.E().format(weekDay)),
            'value': totalSum,
          };
        },
      ).reversed.toList();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      child: Card(
        elevation: 4,
        color: Colors.grey[600],
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SimpleBarChart(listMap: listMap()),
        ),
      ),
    );
  }
}
