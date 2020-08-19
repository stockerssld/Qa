import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qa/quizscreen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "productsans",
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.blue,
    ));
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
                "Quiz",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 90,
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Text(
                      "PLAY",
                      style: TextStyle(fontSize: 32),
                    ),
                    color: Color(0xFFF5CB3B),
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => QuizScreen()),
                      );
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
