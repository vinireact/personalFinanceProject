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
  List<Token> tokenMasterList = [];

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

    List<Widget> drawerList = [
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
        drawer: Drawer(
          elevation: 4,
          child: tokenMasterList.isEmpty
              ? nullList
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: tokenMasterList.length,
                    itemBuilder: (ctx, index) => drawerList[index],
                  ),
                ),
        ),
        appBar: AppBar(
          title: const Text(
            'Controle financeiro',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [IconButton(onPressed: openModal, icon: Icon(Icons.add))],
          bottom: const TabBar(
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
