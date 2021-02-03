import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app05/model/question.dart';

class QuizAppState extends StatefulWidget {
  QuizAppState({Key key}) : super(key: key);

  @override
  _QuizAppStateState createState() => _QuizAppStateState();
}

class _QuizAppStateState extends State<QuizAppState> {
  int _currentQuestionIndex = 0;

  List questionBank = [
    Question.name("the U.S Declaration of independence was adopted in 1776", true),
    Question.name("the supreme law of the land is the constitution", true),
    Question.name(
        "the two rights in the declaration of independence are:"
        "\n Life"
        "\n Pusuit of happiness",
        true),
    Question.name("The (US) Constitution has 26 Amendments", false),
    Question.name(
        "Freedom of religion means:\n You can practice any religion,"
        "or not practice a religion",
        true),
    Question.name("Journalist is one brach or part of the goverment", false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tru Citizen"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: Colors.blueGrey,
      body: Builder(
        builder: (context) => Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(
                  child: Image.asset(
                "images/flag.png",
                width: 250,
                height: 180,
              )),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(14.4),
                      border: Border.all(
                          color: Colors.blueGrey.shade700, style: BorderStyle.solid)),
                  height: 120.0,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      questionBank[_currentQuestionIndex].questionText,
                      style: TextStyle(fontSize: 16.9, color: Colors.white),
                    ),
                  )),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    onPressed: () => _checkAnswer(true, context),
                    color: Colors.blueGrey.shade900,
                    child: Text("TRUE"),
                  ),
                  RaisedButton(
                    onPressed: () => _checkAnswer(false, context),
                    color: Colors.blueGrey.shade900,
                    child: Text("FALSE"),
                  ),
                  RaisedButton(
                    onPressed: () => _nextQuestion(),
                    color: Colors.blueGrey.shade900,
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  _nextQuestion() {
    setState(() {
      _currentQuestionIndex = (_currentQuestionIndex + 1) % questionBank.length;
    });
  }

  _checkAnswer(bool userChoise, BuildContext context) {
    if (userChoise == questionBank[_currentQuestionIndex].isCorrect) {
//correct answer
      debugPrint("yes correct!");
      final snackbar = SnackBar(content: Text("Correct!!"));
      Scaffold.of(context).showSnackBar(snackbar);
    } else {
      debugPrint("Incorrect!");
      final snackbar = SnackBar(content: Text("Incorrect!!"));
      Scaffold.of(context).showSnackBar(snackbar);
    }
  }
}

class BillSplitter extends StatefulWidget {
  @override
  _BillSplitterState createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  int _tipPercentage = 0;
  int _personCounter = 1;
  double _billAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.deepPurple[50],
                  borderRadius: BorderRadius.circular(12.0)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Total Per Person",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 20.0,
                          color: Colors.purple),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "\$  ${calculateTotalPerPerson(_billAmount, _personCounter, _tipPercentage)}",
                        style: TextStyle(
                            color: Colors.purple,
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                      color: Colors.blueGrey.shade100, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(12.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: Colors.deepPurple[200]),
                    decoration: InputDecoration(
                        prefixText: "Bill Amount", prefixIcon: Icon(Icons.attach_money)),
                    onChanged: (String value) {
                      try {
                        _billAmount = double.parse(value);
                      } catch (exception) {
                        _billAmount = 0.0;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Split",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_personCounter > 1) {
                                  _personCounter--;
//                                  debugPrint("$_personCounter");
                                } else {}
                              });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  color: Colors.purple[50]),
                              child: Center(
                                child: Text(
                                  "-",
                                  style: TextStyle(
                                      color: Colors.purple[200],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 35.0),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "$_personCounter",
                            style: TextStyle(color: Colors.purple[200], fontSize: 20.0),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_personCounter >= 1) {
                                  _personCounter++;
//                                  debugPrint("$_personCounter");
                                } else {}
                              });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  color: Colors.purple[50]),
                              child: Center(
                                child: Text(
                                  "+",
                                  style: TextStyle(
                                      color: Colors.purple[200],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 35.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tip",
                        style: TextStyle(color: Colors.purple.shade700, fontSize: 20.0),
                      ),
                      Text(
                          "\$ ${(calculateTotalTip(_billAmount, _personCounter, _tipPercentage)).toStringAsFixed(2)}",
                          style:
                              TextStyle(color: Colors.purple.shade700, fontSize: 20.0)),
                    ],
                  ),
                  //Slider
                  Column(
                    children: [
                      Text(
                        "$_tipPercentage%",
                        style: TextStyle(
                            color: Colors.purple,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Slider(
                        divisions: 10,
                        min: 0,
                        max: 100,
                        activeColor: Colors.purple,
                        inactiveColor: Colors.grey,
                        value: _tipPercentage.toDouble(),
                        onChanged: (double newvalue) {
                          setState(() {
                            _tipPercentage = newvalue.round();
                          });
                        },
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  calculateTotalPerPerson(double billAmount, int splitBy, int tipPercentage) {
    var totalPerPerson =
        (calculateTotalTip(billAmount, splitBy, tipPercentage) + billAmount) / splitBy;
    return totalPerPerson.toStringAsFixed(2);
  }

  calculateTotalTip(double billAmount, int splitBy, int tipPercentage) {
    double totalTip = 0.0;
    if (billAmount < 0 || billAmount.toString().isEmpty || billAmount == null) {
      //no go

    } else {
      totalTip = (billAmount * tipPercentage) / 100;
      return totalTip;
    }
  }
}

class Wisdom extends StatefulWidget {
  @override
  _WisdomState createState() => _WisdomState();
}

class _WisdomState extends State<Wisdom> {
  int _index = 0;

  List quotes = [
    "Algún dinero evita preocupaciones mucho las atrae",
    "Cada cosa tiene su belleza, pero no todos pueden verla",
    "Cuando el objetivo te parezca difícil, no cambies de objetivo; busca un nuevo camino para llegar a él",
    "El ir un poco lejos es tan malo como no ir todo lo necesario",
    "El que domina su cólera domina a su peor enemigo",
    "Es mejor encender una vela que maldecir la oscuridad",
    "La música produce una especie de placer sin el que la naturaleza humana no puede pasarse",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Container(
                  width: 350,
                  height: 200,
                  margin: EdgeInsets.all(30.0),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(14.5)),
                  child: Center(
                      child: Text(
                    quotes[_index % quotes.length],
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontStyle: FontStyle.italic,
                        fontSize: 16.5),
                  )),
                ),
              ),
            ),
            Divider(
              thickness: 2.3,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: FlatButton.icon(
                  onPressed: _showQuote,
                  color: Colors.green.shade500,
                  icon: Icon(Icons.wb_sunny),
                  label: Text(
                    "Inspire me!",
                    style: TextStyle(color: Colors.white, fontSize: 18.8),
                  )),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }

  void _showQuote() {
    setState(() {
      _index += 1;
    });

    debugPrint("$_index");
  }
}

class BizCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BizCard"),
      ),
      backgroundColor: Colors.redAccent,
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [_getCard(), _getAvatar()],
        ),
      ),
    );
  }
}

Container _getCard() {
  return Container(
    width: 350,
    height: 200,
    margin: EdgeInsets.all(50.0),
    decoration:
        BoxDecoration(color: Colors.pinkAccent, borderRadius: BorderRadius.circular(4.5)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Osmar Alvarez",
          style:
              TextStyle(color: Colors.white, fontSize: 20.9, fontWeight: FontWeight.w500),
        ),
        Text("www.alvarez.com"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(Icons.person_outline), Text('T:@osmaralverez')],
        )
      ],
    ),
  );
}

Container _getAvatar() {
  return Container(
    width: 100,
    height: 100,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
        border: Border.all(color: Colors.redAccent, width: 1.2),
        image: DecorationImage(
            image: NetworkImage("https://picsum.photos/200/300"), fit: BoxFit.cover)),
  );
}

class ScaffoldExample extends StatelessWidget {
  _tapButton() {
    debugPrint('tambbutton');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scaffold"),
        centerTitle: true,
        backgroundColor: Colors.amber.shade500,
        actions: [
          IconButton(
            icon: Icon(Icons.email),
            onPressed: () => debugPrint("Email presionado"),
          ),
          IconButton(icon: Icon(Icons.access_alarm), onPressed: _tapButton)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => debugPrint("hello"),
        backgroundColor: Colors.lightGreen,
        child: Icon(Icons.call_missed),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), title: Text("First")),
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit), title: Text("Second")),
          BottomNavigationBarItem(icon: Icon(Icons.access_alarm), title: Text("third")),
        ],
        onTap: (int index) => debugPrint("$index"),
      ),
      backgroundColor: Colors.redAccent.shade100,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton()
//            InkWell(
//              child: Text(
//                "Presiona me!!",
//                style: TextStyle(fontSize: 40.4),
//              ),
//              onTap: () => debugPrint("me presionaste"),
//            )
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final snackBar = SnackBar(content: Text("hola"));
        Scaffold.of(context).showSnackBar(snackBar);
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.amber.shade600, borderRadius: BorderRadius.circular(8.1)),
        child: Text("Button"),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.purple,
      child: Center(
        child: Text(
          "hello fluter",
          textDirection: TextDirection.ltr,
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 23.4, fontStyle: FontStyle.italic),
        ),
      ),
    );
//    return Center(
//        child: Container(
//      child: Text(
//        "Hello flutter",
//        textDirection: TextDirection.ltr,
//      ),
//    ));
  }
}
