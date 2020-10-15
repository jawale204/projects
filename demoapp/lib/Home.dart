import 'dart:convert';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static String id = "Home";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  TabController _controller;
  ScrollController _scrollcontroller;
  ScrollController _scrollcontroller1;
  // var selectedOption;
  var optionValue;
  var info;
  var optionValue1;
  List questionOptions = [];
  List<List<List>> questions = [];
  static var a = """[
   {
      "Questions" : {
        "Popular": {
          "1": "How old is the car?",
          "2": "Are you willing to bargain?"
        },
        "RC": {
          "1": "Which RTO it is registered in?",
          "2": "Company or Individual Registeration?",
          "3": "When does the Registeration expires?",
          "4": "Can you share the Registeration no?"
        },
        "Car Condition": {
          "1": "Is the car accidential?",
          "2": "Is the colour origial or repainted?",
          "3": "How old is the battery?",
          "4": "Are all the parts original?",
          "5": "is the inspection report available?"
        },
        "Insurance": {
          "1": "Is it insured?",
          "2": "What is the insured value?",
          "3": "when does the insurance expires?",
          "4": "can you share the insurance copy?"
        },
        "Fuel type": {
          "1": "is it petrol or diesel?",
          "2": "is it CNG?",
          "3": "is the CNG registered?"
        },
        "User": {
          "1": "Are you a dealer or owner?",
          "2": "Any perticular reason for selling?"
        },
        "Km Run": {"1": "How much has the car driven?"}
      },
      "Make Offer": {}
  }  
  ]""";
  @override
  void initState() {
    info = jsonDecode(a);
    _controller = TabController(initialIndex: 0, length: 2, vsync: this);
    _scrollcontroller = ScrollController();
    _scrollcontroller1 = ScrollController();
    _scrollcontroller.addListener(listen);
    _scrollcontroller1.addListener(listen1);
    perform();
   // selectedOption = questions[0];
    super.initState();
  }

  listen() {
    var maxscrollValue = _scrollcontroller.position.maxScrollExtent;
    var div = (maxscrollValue / questions.length) + 10;
    var scrollvalue = _scrollcontroller.offset.round();
    optionValue = (scrollvalue / div).round();
    // setState(() {
    //   selectedOption = questions[optionValue];
    // });
  }

  listen1() {
    var maxscrollValue1 = _scrollcontroller1.position.maxScrollExtent;
    var div1 = (maxscrollValue1 / questionOptions.length) + 10;
    var scrollvalue = _scrollcontroller1.offset.round();
    optionValue1 = (scrollvalue / div1).round();
  }

  perform() {
    for (var a in info) {
      a['Questions'].forEach((x, y) {
        questionOptions.add(x);
        var k = [];
        for (var i = 0; i < y.length; i++) {
          k.add(y[(i + 1).toString()]);
        }
        questions.add([
          k,
          [false]
        ]);
      });
    }
  }

  scrollToSlide(int index) {
    var maxscrollValue = _scrollcontroller.position.maxScrollExtent;
    var div = (maxscrollValue / questions.length) + 10;
    var scrolltovalue = index * div;
    _scrollcontroller.animateTo(scrolltovalue,
        curve: Curves.easeIn, duration: Duration(milliseconds: 500));
  }

  scrollToSlide1(int index) {
    var maxscrollValue = _scrollcontroller1.position.maxScrollExtent;
    var div = (maxscrollValue / questionOptions.length) + 10;
    var scrolltovalue = index * div;
    _scrollcontroller1.animateTo(scrolltovalue,
        curve: Curves.easeIn, duration: Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Demo"),
          bottom: TabBar(
            labelStyle: TextStyle(fontSize: 20),
            controller: _controller,
            tabs: [
              Tab(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.question_answer),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Questions'),
                  ],
                ),
              ),
              Tab(
                  child: Row(
                children: <Widget>[
                  Icon(Icons.attach_money),
                  SizedBox(
                    width: 5,
                  ),
                  Text('Make Offer'),
                ],
              )),
            ],
          ),
        ),
        body: TabBarView(controller: _controller, children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: ListView.builder(
                    controller: _scrollcontroller1,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: questionOptions.length,
                    itemBuilder: (context, int index) {
                      return InkWell(
                        onTap: () {
                          scrollToSlide(index);
                        },
                        child: Container(
                            padding: EdgeInsets.all(0),
                            child: Card(
                                color: Colors.blue[900],
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(
                                      questionOptions[index] +
                                          "(${questions[index][0].length})",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  ),
                                ))),
                      );
                    }),
              ),
              Expanded(
                  flex: 20,
                  child: Container(
                      child: ListView.builder(
                          controller: _scrollcontroller,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: questionOptions.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                scrollToSlide1(index);
                              },
                              child: Container(
                                margin: EdgeInsets.all(3.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.grey[200]),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                            padding: EdgeInsets.all(7),
                                            child: Text(
                                              questionOptions[index],
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.blue[600]),
                                            )),
                                      ],
                                    ),
                                    Divider(
                                      height: 1,
                                    ),
                                    ListView.builder(
                                       physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: questions[index][0].length,
                                        itemBuilder: (context, index1) {
                                          return Container(
                                              margin: EdgeInsets.all(3.0),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  color: Colors.white),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(questions[index]
                                                    [0][index1],style: TextStyle(fontSize: 15),),
                                              ));
                                        }),
                                  ],
                                ),
                              ),
                            );
                          })))
            ],
          ),
          GestureDetector(child: Text('hello'))
        ]));
  }
}
