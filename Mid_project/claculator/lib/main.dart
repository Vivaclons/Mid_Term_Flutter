import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

dynamic txt = '0';
double firstNumber = 0;
double secondNumber = 0;
dynamic operation = '';
dynamic preOperation = '';
dynamic result = '';
dynamic finalResult = '';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  Widget calButton(String text, Color color, Color txtColor) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          calculation(text);
        },
        child: Text(
          text,
          style: TextStyle(
            fontSize: 35,
            color: txtColor,
          ),
        ),
        color: color,
        padding: EdgeInsets.all(19),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '$txt',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 100,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calButton('AC', Colors.grey[850], Colors.white),
                calButton('+/-', Colors.grey[850], Colors.white),
                calButton('%', Colors.grey[850], Colors.white),
                calButton('/', Colors.orange[700], Colors.white),
              ],
            ),
            SizedBox(
              height: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calButton('7', Colors.grey[700], Colors.white),
                calButton('8', Colors.grey[700], Colors.white),
                calButton('9', Colors.grey[700], Colors.white),
                calButton('x', Colors.orange[700], Colors.white),
              ],
            ),
            SizedBox(
              height: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calButton('4', Colors.grey[700], Colors.white),
                calButton('5', Colors.grey[700], Colors.white),
                calButton('6', Colors.grey[700], Colors.white),
                calButton('-', Colors.orange[700], Colors.white),
              ],
            ),
            SizedBox(
              height: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calButton('1', Colors.grey[700], Colors.white),
                calButton('2', Colors.grey[700], Colors.white),
                calButton('3', Colors.grey[700], Colors.white),
                calButton('+', Colors.orange[700], Colors.white),
              ],
            ),
            SizedBox(
              height: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  padding: EdgeInsets.fromLTRB(21, 20, 135, 20),
                  onPressed: () {
                    calculation('0');
                  },
                  // shape: StadiumBorder(),
                  child: Text(
                    "0",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 35, color: Colors.white),
                  ),
                  color: Colors.grey[700],
                ),
                calButton('.', Colors.grey[700], Colors.white),
                calButton('=', Colors.orange[700], Colors.white),
              ],
            ),
            SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }

  void calculation(text) {
    if (text == 'AC') {
      txt = '0';
      firstNumber = 0;
      secondNumber = 0;
      result = '';
      finalResult = '0';
      operation = '';
      preOperation = '';
    } else if (operation == '=' && text == '=') {
      if (preOperation == '+') {
        finalResult = plus(result, firstNumber, secondNumber);
      } else if (preOperation == '-') {
        finalResult = min(result, firstNumber, secondNumber);
      } else if (preOperation == 'x') {
        finalResult = multiply(result, firstNumber, secondNumber);
      } else if (preOperation == '/') {
        finalResult = divide(result, firstNumber, secondNumber);
      }
    } else if (text == '+' ||
        text == '-' ||
        text == 'x' ||
        text == '/' ||
        text == '=') {
      if (firstNumber == 0) {
        firstNumber = double.parse(result);
      } else {
        secondNumber = double.parse(result);
      }

      if (operation == '+') {
        finalResult = plus(result, firstNumber, secondNumber);
      } else if (operation == '-') {
        finalResult = min(result, firstNumber, secondNumber);
      } else if (operation == 'x') {
        finalResult = multiply(result, firstNumber, secondNumber);
      } else if (operation == '/') {
        finalResult = divide(result, firstNumber, secondNumber);
      }
      preOperation = operation;
      operation = text;
      result = '';
    } else if (text == '%') {
      result = firstNumber / 100;
      finalResult = decimal(result);
    } else if (text == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalResult = result;
    } else if (text == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-' + result.toString();
      finalResult = result;
    } else {
      result = result + text;
      finalResult = result;
    }

    setState(() {
      txt = finalResult;
    });
  }
}

String min(result, firstNumber, secondNumber) {
  result = (firstNumber - secondNumber).toString();
  firstNumber = double.parse(result);
  return decimal(result);
}

String multiply(result, firstNumber, secondNumber) {
  result = (firstNumber * secondNumber).toString();
  firstNumber = double.parse(result);
  return decimal(result);
}

String divide(result, firstNumber, secondNumber) {
  result = (firstNumber / secondNumber).toString();
  firstNumber = double.parse(result);
  return decimal(result);
}

String plus(result, firstNumber, secondNumber) {
  result = (firstNumber + secondNumber).toString();
  firstNumber = double.parse(result);
  return decimal(result);
}

String decimal(dynamic result) {
  if (result.toString().contains('.')) {
    List<String> splitDecimal = result.toString().split('.');
    if (!(int.parse(splitDecimal[1]) > 0))
      return result = splitDecimal[0].toString();
  }
  return result;
}
