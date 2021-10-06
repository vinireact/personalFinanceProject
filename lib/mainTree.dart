import 'package:finance/widgets/depChart.dart';
import 'package:finance/widgets/label.dart';
import 'package:finance/widgets/modalForm.dart';
import 'package:finance/widgets/simpleChart.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class MainTree extends StatefulWidget {
  @override
  _MainTreeState createState() => _MainTreeState();
}

class _MainTreeState extends State<MainTree> {
  List<Token> tokenMasterList = [
    Token(
      title: 'Bitcoin',
      value: 350.00,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Token(
      title: 'Farmácia',
      value: 130.62,
      date: DateTime.now().subtract(Duration(days: 6)),
    ),
    Token(
      title: 'Lanche Facul',
      value: 43.78,
      date: DateTime.now().subtract(Duration(days: 2)),
    )
  ];

  void register(String txt, double value) {
    Token aux = Token(value: value, title: txt, date: DateTime.now());
    setState(() {
      tokenMasterList.add(aux);
    });
    Navigator.of(context).pop();
  }

  void openModal() {
    showModalBottomSheet(
      context: context,
      builder: (_) => ModalForm(
        fn: register,
      ),
    );
  }

  void removeLabel(String id) {
    setState(() {
      tokenMasterList.removeWhere((element) => element.id == id);
    });
  }

  List<Token> get tokenMasterListFilter {
    return tokenMasterList
        .where(
          (element) =>
              element.date!.isAfter(DateTime.now().subtract(Duration(days: 7))),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    Widget nullList = Center(
      child: TextButton(
        onPressed: openModal,
        child: Text(
          'Clique aqui para começar',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

    List<Widget> tabList1 = [
      SimpleChart(
        tokenMasterListFilter: tokenMasterListFilter,
      ),
      ...tokenMasterList
          .map(
            (e) => Label(
              token: e,
              fn: removeLabel,
            ),
          )
          .toList()
    ];

    List<Widget> tabList2 = [
      DepChart(
        tokenMasterListFilter: tokenMasterListFilter,
      ),
      ...tokenMasterList
          .map(
            (e) => Label(
              token: e,
              fn: removeLabel,
            ),
          )
          .toList()
    ];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.payments_outlined),
          title: Text(
            'Controle financeiro',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [IconButton(onPressed: openModal, icon: Icon(Icons.add))],
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                icon: Icon(Icons.bar_chart_outlined),
              ),
              Tab(
                icon: Icon(Icons.signal_cellular_alt_outlined),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            tokenMasterList.isEmpty
                ? nullList
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: tabList1.length,
                      itemBuilder: (ctx, index) => tabList1[index],
                    ),
                  ),
            tokenMasterList.isEmpty
                ? nullList
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: tabList2.length,
                      itemBuilder: (ctx, index) => tabList2[index],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class Token {
  String? id = randomAlphaNumeric(64);
  double? value;
  String? title;
  DateTime? date;
  Token({this.value, this.title, this.date});
}