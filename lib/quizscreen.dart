import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qa/QuizHelp.dart';
import 'package:http/http.dart' as http;
import 'package:qa/ResultScreen.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  String apiURL =
      "https://opentdb.com/api.php?amount=10&category=18&type=multiple";

  QuizHelper quizHelper;

  int currentQuestion = 0;
  int totalSecounds = 30;
  int elapsedSeconds = 0;
  Timer timer;
  int score = 0;

  @override
  void initState() {
    fetchAllQuiz();
    super.initState();
  }

  fetchAllQuiz() async {
    var response = await http.get(apiURL);
    var body = response.body;
    var json = jsonDecode(body);

    print(body);
    setState(() {
      quizHelper = QuizHelper.fromJson(json);
      quizHelper.results[currentQuestion].incorrectAnswers
          .add(quizHelper.results[currentQuestion].correctAnswer);

      quizHelper.results[currentQuestion].incorrectAnswers.shuffle();
      initTimer();
    });
  }

  initTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (t.tick == totalSecounds) {
        // print("Timer completed");
        t.cancel();
        changeQuestion();
      } else {
        setState(() {
          elapsedSeconds = t.tick;
        });
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  checkAnswer(answer) {
    String correctAnswer = quizHelper.results[currentQuestion].correctAnswer;
    if (correctAnswer == answer) {
      score += 1;
      changeQuestion();
    } else {
      changeQuestion();
    }
  }

  void changeQuestion() {
    timer.cancel();
    if (currentQuestion == quizHelper.results.length - 1) {
      print("Quiz Complete");
      print("Score: $score");
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => ResultScreen(score: score)));
    } else {
      setState(() {
        currentQuestion += 1;
      });

      quizHelper.results[currentQuestion].incorrectAnswers
          .add(quizHelper.results[currentQuestion].correctAnswer);

      quizHelper.results[currentQuestion].incorrectAnswers.shuffle();
      initTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (quizHelper != null) {
      return Scaffold(
        backgroundColor: Colors.blue,
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(color: Colors.yellow, width: 3))),
                    margin: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image(
                          image: AssetImage("assets/qa.png"),
                          width: 75,
                          height: 75,
                          color: Color(0xFFF5CB3B),
                        ),
                        Text(
                          "$elapsedSeconds S",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )
                      ],
                    )),
                Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Q. ${quizHelper.results[currentQuestion].question}",
                      style: TextStyle(fontSize: 35, color: Colors.white),
                      textAlign: TextAlign.center,
                    )),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Column(
                    children: quizHelper
                        .results[currentQuestion].incorrectAnswers
                        .map((option) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: RaisedButton(
                            onPressed: () {
                              checkAnswer(option);
                            },
                            color: Color(0xFFDB9646),
                            colorBrightness: Brightness.dark,
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              option,
                              style: TextStyle(fontSize: 18),
                            ),
                          ));
                    }).toList(),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
          backgroundColor: Colors.blue,
          body: Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red)),
          ));
    }
  }
}
