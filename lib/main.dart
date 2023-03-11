import 'package:flutter/material.dart';

void main() {
  runApp(const FreeMain());
}

class FreeMain extends StatelessWidget {
  const FreeMain({Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const HomeLayout(),
        backgroundColor: const Color(0xFF393939),
        floatingActionButton: FloatingActionButton(
          onPressed: () {

          },
          backgroundColor: const Color(0xFF656565),
          child: const Text('⚙'),
        ),
      ),
    );
  }
}

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeState();
}

class _HomeState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle = TextStyle(color: Color(0xFFFFFFFF), fontSize: 42, fontFamily: "Montserrat",);
    const TextStyle buttonTextStyle = TextStyle(color: Color(0xFFFFFFFF), fontSize: 16, fontFamily: "Montserrat");
    final ButtonStyle style = ElevatedButton.styleFrom(textStyle: buttonTextStyle,
    padding: const EdgeInsets.all(20), backgroundColor: const Color(0xFF656565));

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.fromLTRB(0, 200, 0, 0),
          alignment: Alignment.topCenter,
          child: const Text('FreeChess',
          style: textStyle,
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
          child: ElevatedButton(
            style: style,
            onPressed: () {

            },
            child: const Text('START GAME'),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
          child: ElevatedButton(
            style: style,
            onPressed: () {

            },
            child: const Text('LOAD GAME'),
          ),
        ),
      ],
    );
  }
}