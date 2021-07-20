import 'dart:math';

import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CALCULATOR',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyCalculatorPage(title: 'CALCULATOR'),
    );
  }
}

class MyCalculatorPage extends StatefulWidget {
  MyCalculatorPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyCalculatorPageState createState() => _MyCalculatorPageState();
}

class _MyCalculatorPageState extends State<MyCalculatorPage> {
  late String answer;
  late String answerTemp;
  late String inputFull;
  late String operator;
  late bool calculateMode;

  @override
  void initState() {
    answer = "0";
    operator = "";
    answerTemp = "";
    inputFull = "";
    calculateMode = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[300],
        title: Text(widget.title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        elevation: 1,
      ),
      body: Container(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[buildAnswerWidget(), buildNumPadWidget()],
      )),
    );
  }

  Widget buildAnswerWidget() {
    return Expanded(
        child: Container(
            padding: EdgeInsets.all(26),
            color: Color(0xffdbdbdb),
            child: Align(
                alignment: Alignment.bottomRight,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(inputFull + " " + operator,
                          style: TextStyle(fontSize: 20)),
                      Text(answer,
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.bold))
                    ]))));
  }

  Widget buildNumPadWidget() {
    return Container(
        color: Color(0xffdbdbdb),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(children: <Widget>[
              buildNumberButton("CE", numberButton: false, onTap: () {
                clearAnswer();
              }),
              buildNumberButton("C", numberButton: false, onTap: () {
                clearAll();
              }),
              buildNumberButton("⌫", numberButton: false, onTap: () {
                removeAnswerLast();
              }),
            ]),
            Row(children: <Widget>[
              buildNumberButton("%", numberButton: false, onTap: () {
                calculate(percent: true);
              }),
              buildNumberButton("√", numberButton: false, onTap: () {
                calculate(root: true);
              }),
              buildNumberButton("3√", numberButton: false, onTap: () {
                calculate(rootthree: true);
              }),
              buildNumberButton("y√", numberButton: false, onTap: () {
                addOperatorToAnswer("√");
              }),
            ]),
            Row(children: <Widget>[
              buildNumberButton("^y", numberButton: false, onTap: () {
                addOperatorToAnswer("^");
              }),
              buildNumberButton("^2", numberButton: false, onTap: () {
                calculate(powtwo: true);
              }),
              buildNumberButton("^3", numberButton: false, onTap: () {
                calculate(powthree: true);
              }),
              buildNumberButton("÷", numberButton: false, onTap: () {
                addOperatorToAnswer("÷");
              }),
            ]),
            Row(children: <Widget>[
              buildNumberButton("7", onTap: () {
                addNumberToAnswer(7);
              }),
              buildNumberButton("8", onTap: () {
                addNumberToAnswer(8);
              }),
              buildNumberButton("9", onTap: () {
                addNumberToAnswer(9);
              }),
              buildNumberButton("×", numberButton: false, onTap: () {
                addOperatorToAnswer("×");
              }),
            ]),
            Row(children: <Widget>[
              buildNumberButton("4", onTap: () {
                addNumberToAnswer(4);
              }),
              buildNumberButton("5", onTap: () {
                addNumberToAnswer(5);
              }),
              buildNumberButton("6", onTap: () {
                addNumberToAnswer(6);
              }),
              buildNumberButton("−", numberButton: false, onTap: () {
                addOperatorToAnswer("-");
              }),
            ]),
            Row(children: <Widget>[
              buildNumberButton("1", onTap: () {
                addNumberToAnswer(1);
              }),
              buildNumberButton("2", onTap: () {
                addNumberToAnswer(2);
              }),
              buildNumberButton("3", onTap: () {
                addNumberToAnswer(3);
              }),
              buildNumberButton("+", numberButton: false, onTap: () {
                addOperatorToAnswer("+");
              }),
            ]),
            Row(children: <Widget>[
              buildNumberButton("±", numberButton: false, onTap: () {
                toggleNegative();
              }),
              buildNumberButton("0", onTap: () {
                addNumberToAnswer(0);
              }),
              buildNumberButton(".", numberButton: false, onTap: () {
                addDotToAnswer();
              }),
              buildNumberButton("=", numberButton: false, onTap: () {
                calculate();
              }),
            ]),
          ],
        ));
  }

  void toggleNegative() {
    setState(() {
      if (answer.contains("-")) {
        answer = answer.replaceAll("-", "");
      } else {
        if (answer == "0") {
          answer = "-";
        } else {
          answer = "-" + answer;
        }
      }
    });
  }

  void clearAnswer() {
    setState(() {
      answer = "0";
    });
  }

  void clearAll() {
    setState(() {
      answer = "0";
      inputFull = "";
      calculateMode = false;
      operator = "";
    });
  }

  void calculate(
      {percent = false,
      root = false,
      powtwo = false,
      powthree = false,
      rootthree = false}) {
    print(answer);
    setState(() {
      if (percent && double.parse(answer) != 0) {
        calculateMode = true;
      } else if (root && double.parse(answer) != 0) {
        calculateMode = true;
      } else if (rootthree && double.parse(answer) != 0) {
        calculateMode = true;
      } else if (powtwo && double.parse(answer) != 0) {
        calculateMode = true;
      } else if (powthree && double.parse(answer) != 0) {
        calculateMode = true;
      }
      print(calculateMode);

      if (calculateMode) {
        bool decimalMode = false;
        num value = 0;
        if (answer.contains(".") || answerTemp.contains(".")) {
          decimalMode = true;
        }
        if (operator == "+" &&
            !percent &&
            !root &&
            !rootthree &&
            !powthree &&
            !powtwo) {
          value = (double.parse(answerTemp) + double.parse(answer));
        } else if (operator == "-" &&
            !percent &&
            !root &&
            !powthree &&
            !powtwo &&
            !rootthree) {
          value = (double.parse(answerTemp) - double.parse(answer));
        } else if (operator == "×" &&
            !percent &&
            !root &&
            !powthree &&
            !powtwo &&
            !rootthree) {
          value = (double.parse(answerTemp) * double.parse(answer));
        } else if (operator == "÷" &&
            !percent &&
            !root &&
            !powthree &&
            !powtwo &&
            !rootthree) {
          value = (double.parse(answerTemp) / double.parse(answer));
        } else if (root && !percent && !powthree && !powtwo && !rootthree) {
          value = sqrt(double.parse(answer));
          if (value.toString().contains(".")) {
            decimalMode = true;
          } else {
            decimalMode = false;
          }
        } else if (operator == "√" &&
            !percent &&
            !powthree &&
            !powtwo &&
            !root &&
            !rootthree) {
          value = pow(double.parse(answer), (1 / double.parse(answerTemp)));
          if (value.toString().contains(".")) {
            decimalMode = true;
          } else {
            decimalMode = false;
          }
        } else if (rootthree && !percent && !powthree && !powtwo && !root) {
          value = pow(double.parse(answer), (1 / 3));
          if (value.toString().contains(".")) {
            decimalMode = true;
          } else {
            decimalMode = false;
          }
        } else if (operator == "^" &&
            !percent &&
            !root &&
            !powthree &&
            !powtwo &&
            !rootthree) {
          value = pow(double.parse(answerTemp), double.parse(answer));
        } else if (powtwo && !percent && !root && !powthree && !rootthree) {
          value = pow(double.parse(answer), 2);
          print(value);
          if (value.toString().contains(".")) {
            decimalMode = true;
          } else {
            decimalMode = false;
          }
        } else if (powthree && !percent && !root && !powtwo && !rootthree) {
          value = pow(double.parse(answer), 3);
          if (value.toString().contains(".")) {
            decimalMode = true;
          } else {
            decimalMode = false;
          }
        } else if (percent && !root && !powthree && !powtwo && !rootthree) {
          if ((operator == "+" || operator == "-")) {
            value = (double.parse(answerTemp) +
                ((double.parse(answer) * double.parse(answerTemp)) / 100));
          } else if ((operator == "×")) {
            value = ((double.parse(answer) * double.parse(answerTemp)) / 100);
          } else if ((operator == "÷")) {
            value = (((double.parse(answer) * 100) / double.parse(answerTemp)));
          } else {
            value = (double.parse(answer)) * 0.01;
            if (value.toString().contains(".")) {
              decimalMode = true;
            } else {
              decimalMode = false;
            }
          }
        }

        if (!decimalMode && !root) {
          answer = value.toInt().toStringAsFixed(2);
        } else if (decimalMode && !root) {
          answer = value.toStringAsFixed(2);
        } else if (!decimalMode && root) {
          answer = value.toInt().toString();
        } else if (decimalMode && root) {
          answer = value.toString();
        }

        calculateMode = false;
        operator = "";
        answerTemp = "";
        inputFull = "";
      }
    });
  }

  void addOperatorToAnswer(String op) {
    print(op);
    setState(() {
      if (answer != "0" && !calculateMode) {
        calculateMode = true;
        answerTemp = answer;
        inputFull += operator + " " + answerTemp;
        operator = op;
        answer = "0";
      } else if (calculateMode) {
        if (answer.isNotEmpty) {
          calculate();
          calculateMode = true;
          answerTemp = answer;
          inputFull += operator + " " + answerTemp;
          operator = op;
          answer = "0";
        } else {
          operator = op;
        }
      }
    });
  }

  void addDotToAnswer() {
    setState(() {
      if (!answer.contains(".")) {
        answer = answer + ".";
      }
    });
  }

  void addNumberToAnswer(int number) {
    setState(() {
      if (number == 0 && answer == "0") {
        // Not do anything.
      } else if (number != 0 && answer == "0") {
        answer = number.toString();
      } else {
        answer += number.toString();
      }
    });
  }

  void removeAnswerLast() {
    if (answer == "0") {
      // Not do anything.
    } else {
      setState(() {
        if (answer.length > 1) {
          answer = answer.substring(0, answer.length - 1);
          if (answer.length == 1 && (answer == "." || answer == "-")) {
            answer = "0";
          }
        } else {
          answer = "0";
        }
      });
    }
  }

  Widget buildNumberButton(String str,
      {required Function() onTap, bool numberButton = true}) {
    Widget widget;
    if (numberButton) {
      widget = Container(
          margin: EdgeInsets.all(1),
          child: Material(
              color: Colors.white,
              child: InkWell(
                  onTap: onTap,
                  splashColor: Colors.blue,
                  child: Container(
                      height: 70,
                      child: Center(
                          child: Text(str,
                              style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold)))))));
    } else {
      widget = Container(
          margin: EdgeInsets.all(1),
          child: Material(
              color: Color(0xffecf0f1),
              child: InkWell(
                  onTap: onTap,
                  splashColor: Colors.blue,
                  child: Container(
                      height: 70,
                      child: Center(
                          child: Text(str, style: TextStyle(fontSize: 28)))))));
    }

    return Expanded(child: widget);
  }
}
