import 'dart:convert';

import 'package:flutter/material.dart';

class Task2 extends StatefulWidget {
  static String id = "task2";
  @override
  _Task2State createState() => _Task2State();
}

class _Task2State extends State<Task2> {
  ScrollController _scrollController1;
  ScrollController _scrollController2;
  List<dynamic> problems = [];
  var selectedpriority;
  var optionValue1;
  var optionValue2;
  var json = """
[
    {"Management committee":{
      "1":"Issue with appliction",
      "2":"Bad behaviour of Management staff",
      "3":"other"
    }},
     {"Management":{
      "1":"Lift is not working",
      "2":"Guard denied duty",
      "3":"other",
      "4":"payment of society"
    }},
    {"HouseKeeping":{
      "1":"Garbage in common area",
      "2":"Housekeeping staff is not working properly"
    }},
    {"Security":{
      "1":"Absence of security Guard"
    }},
    {"Amenities and sports":{
      "1":"Lift is not working"
    }},
    {"Maintenance":{
      "1":"Water not available",
      "2":"Childern's play area ",
      "3": "Problem of water leakage"
    }},
    {"Account":{
      "1":"Maintenance charge issue"
    }}

  ]""";

  @override
  void initState() {
    _scrollController1 = ScrollController();
    _scrollController2 = ScrollController();
    _scrollController1.addListener(listen1);
    _scrollController2.addListener(listen2);
    super.initState();
     problems = [];
  }

  listen1() {
    var maxscrollvalue = _scrollController1.position.maxScrollExtent;
    var div = (maxscrollvalue / problems.length) + 10;
    var scrollvalue = _scrollController2.position.pixels;
    optionValue1 = (scrollvalue / div).round();
    print(optionValue1);
  }

  listen2() {
    var maxscrollvalue = _scrollController2.position.maxScrollExtent;
    var div = (maxscrollvalue / problems.length) + 10;
    var scrollvalue = _scrollController2.position.pixels;
    optionValue2 = (scrollvalue / div).round();
    print(optionValue2);
   
  }

  perform() {
     problems = [];
    var jsondecode = jsonDecode(json);
    for (Map<String, dynamic> b in jsondecode) {
      b.forEach((key, value) {
        var use = [];
        value.forEach((key, value) {
          use.add(value);
        });
        problems.add([key, use]);
      });
    }
  }

  Widget customRadio(option, index) {
    return MaterialButton(
      onPressed: () {
        changeSelectedPriority(index);
      },
      color: index == selectedpriority ? Colors.blue : Colors.grey[300],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Text(option),
    );
  }

  changeSelectedPriority(index) {
    setState(() {
      selectedpriority = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    perform();
    return Scaffold(
      appBar:
          AppBar(title: Text("Add Complaint"), leading: Icon(Icons.arrow_back)),
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Container(
            height: 35,
            child: ListView.builder(
              controller: _scrollController1,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: problems.length,
              itemBuilder: (context, index) {
                return Container(
                    padding: EdgeInsets.all(0),
                    child: Card(
                        color: Colors.blue[900],
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(
                              problems[index][0],
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        )));
              },
            ),
          ),
          Card(
            elevation: 8,
            child: Container(
                height: 250,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListView.builder(
                    controller: _scrollController2,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: problems.length,
                    itemBuilder: (context, index1) {
                      return Column(children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey[300],
                                ),
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  problems[index1][0],
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.blue[600]),
                                ))
                          ],
                        ),
                        Divider(
                          height: 1,
                        ),
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: problems[index1][1].length,
                            itemBuilder: (context, index2) {
                              return Container(
                                  margin: EdgeInsets.all(3.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.white),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      problems[index1][1][index2],
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ));
                            }),
                      ]);
                    },
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                  borderSide: new BorderSide(),
                ),
                fillColor: Colors.black,
                labelText: 'Complaint',
                hintText: 'Complaint',
              ),
              maxLines: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                  borderSide: new BorderSide(),
                ),
                fillColor: Colors.black,
                labelText: 'ComplaintDescription',
                hintText: 'ComplaintDescription',
              ),
              maxLines: 2,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              customRadio('Low', 1),
              customRadio("Medium", 2),
              customRadio("Urgent", 3)
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Choose File(Max Size : 10 mb)",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        // child: IconButton(
                        //   icon: IconWidget(
                        //     iconData: Icons.mic,
                        //     color: BLUE_ACCENT,
                        //     size: 30,
                        //   ),

                        // ),
                        child: Icon(Icons.filter),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.mic),
                        // child: IconButton(
                        //   icon: IconWidget(
                        //     iconData: Icons.mic,
                        //     color: BLUE_ACCENT,
                        //     size: 30,
                        //   ),

                        // ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white10),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        // child: IconButton(
                        //   icon: IconWidget(
                        //     iconData: Icons.mic,
                        //     color: BLUE_ACCENT,
                        //     size: 30,
                        //   ),

                        // ),
                        child: Icon(Icons.ondemand_video),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: MaterialButton(
                onPressed: () {},
                child: Text("Add Complaint", style: TextStyle(fontSize: 15)),
                height: 50,
                elevation: 5,
                color: Colors.blueAccent,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                )),
          )
        ],
      ),
    );
  }
}
