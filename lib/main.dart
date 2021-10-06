import 'package:finance/mainTree.dart';
import 'package:finance/widgets/myButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Finance',
      debugShowCheckedModeBanner: false,
      home: Home(),
      routes: {'mainTree': (context) => MainTree()},
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Montserrat',
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (ctx, constraints) => Column(
          children: [
            Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight * 0.35,
            ),
            Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight * 0.65,
              padding: EdgeInsets.all(constraints.maxWidth * 0.045),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 140,
                    height: 140,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  MyButton(
                    txt: 'ENTRAR',
                    color: Colors.white,
                    fn: () => Navigator.pushNamed(context, 'mainTree'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
