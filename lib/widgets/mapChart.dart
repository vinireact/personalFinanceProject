import 'package:flutter/material.dart';

class MapChart extends StatelessWidget {
  final double? value;
  final double? percent;
  final String? weekDay;
  const MapChart({this.value, this.percent, this.weekDay});

  String get convertValue {
    if (value! <= 999.99) {
      return value!.toStringAsFixed(2);
    } else if (value! <= 9999.99) {
      return '+1k';
    } else {
      return '+10k';
    }
  }

  String get convertWeekDay {
    if (weekDay! == 'Tue') {
      return 'Ter';
    } else if (weekDay! == 'Mon') {
      return 'Seg';
    } else if (weekDay! == 'Sun') {
      return 'Dom';
    } else if (weekDay! == 'Sat') {
      return 'Sab';
    } else if (weekDay! == 'Fri') {
      return 'Sex';
    } else if (weekDay! == 'Thu') {
      return 'Qui';
    } else {
      return 'Qua';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              convertValue,
              style: const TextStyle(fontSize: 9),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              width: 20,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Container(
                    width: 20,
                    height: percent! * 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
            Text(convertWeekDay, style: TextStyle(fontSize: 11)),
          ],
        ),
      ),
    );
  }
}
