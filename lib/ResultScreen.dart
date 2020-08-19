import 'package:flutter/material.dart';
import 'package:qa/quizscreen.dart';

class ResultScreen extends StatelessWidget {
  final int score;

  ResultScreen({this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 90,
                ),
                Center(
                  child: Image(
                    image: AssetImage("assets/qa.png"),
                    width: 100,
                    height: 300,
                    color: Color(0xFFF5CB3B),
                  ),
                ),
                Text(
                  "Result",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                  ),
                ),
                Text(
                  "$score/10",
                  style: TextStyle(
                    color: Color(0xFFFFBA00),
                    fontSize: 60,
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                    child: RaisedButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Text(
                        "RESTART",
                        style: TextStyle(fontSize: 32),
                      ),
                      color: Color(0xFFFFBA00),
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => QuizScreen()),
                        );
                      },
                    )),
                Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: RaisedButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Text(
                        "EXIT",
                        style: TextStyle(fontSize: 32),
                      ),
                      color: Color(0xFFF24841),
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )),
              ],
            ),
          ),
        ));
  }
}
