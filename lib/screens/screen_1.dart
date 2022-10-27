import 'package:flutter/material.dart';
import 'package:up_todo/screens/screen_2.dart';

class Screen1 extends StatelessWidget {
  const Screen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Screen 1",
          style: TextStyle(fontSize: 32),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => Screen2()),
          );
        },
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}
