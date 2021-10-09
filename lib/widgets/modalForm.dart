import 'package:finance/widgets/myButton.dart';
import 'package:flutter/material.dart';

class ModalForm extends StatefulWidget {
  final Function(String, double)? fn;
  ModalForm({required this.fn});

  @override
  _ModalFormState createState() => _ModalFormState();
}

class _ModalFormState extends State<ModalForm> {
  TextEditingController? txtController = TextEditingController();
  TextEditingController? valueController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double? doubleConvert = valueController!.text.isEmpty
        ? 0.0
        : double.tryParse(valueController!.text);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Título',
                hintText: 'Ex. Supermercado',
                labelStyle: TextStyle(color: Colors.white),
                hintStyle: TextStyle(color: Colors.grey),
              ),
              controller: txtController,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Valor R\$',
                hintText: 'Ex. 100.00',
                labelStyle: TextStyle(color: Colors.white),
                hintStyle: TextStyle(color: Colors.grey),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: valueController,
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: MyButton(
                color: Colors.white,
                txt: 'REGISTRAR',
                fn: () => widget.fn!(
                  txtController!.text,
                  doubleConvert!,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
