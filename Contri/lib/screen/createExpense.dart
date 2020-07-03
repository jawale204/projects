import 'package:Contri/models/Groups.dart';
import 'package:Contri/models/singleGroup.dart';
import 'package:flutter/material.dart';

class CreateExpense extends StatefulWidget {
  static String id = 'CreateExpense';
  final Map<String, dynamic> memberlist;
  final SingleGroup sg;
  final Groups obj;
  CreateExpense({this.memberlist, this.obj, this.sg});
  @override
  _CreateExpenseState createState() => _CreateExpenseState();
}

class _CreateExpenseState extends State<CreateExpense> {
  final TextEditingController description = TextEditingController();
  final TextEditingController amount = TextEditingController();
  //COntrollers for input values of contri and spent of user
  List<TextEditingController> contribution = [];
  List<TextEditingController> spent = [];
  //member name and id in list
  List<List> members;
  var contrisum = [];
  var spentsum = [];
  bool done = false;
  DateTime time = DateTime.now();

  final _formKey = GlobalKey<FormState>();
  @override
  initState() {
    super.initState();
    makeList();
  }

//converts the memberlist map to list of list //initializes th controller dynamically
  makeList() {
    widget.memberlist.forEach((key, value) => {
          members == null
              ? members = [
                  [key, value]
                ]
              : members.add([key, value])
        });
    members.forEach((element) {
      var contricontroller = new TextEditingController();
      var spentcontroller = new TextEditingController();
      spent == null ? spent = [spentcontroller] : spent.add(spentcontroller);
      contribution == null
          ? contribution = [contricontroller]
          : contribution.add(contricontroller);
    });
  }

//converts the usersinfo and there contri,spent in an array where 0 index is the actual total amount and for every next 4 index interval we find userinfo and contri spent
  convert() {
    List<dynamic> expense = [int.parse(amount.value.text)];
    for (var i = 0; i < members.length; i++) {
      var memberholder = members[i][1].values.toList();
      expense.add(memberholder[0]);
      expense.add(memberholder[1]);
      expense.add(memberholder[2]);
      expense.add(memberholder[3]);
      expense.add(contrisum[i]);
      expense.add(spentsum[i]);
    }
    //creates obj to add expense
     widget.sg.addExpense(expense, description.value.text, widget.obj, time);
    setState(() {
      done = true;
    });
  }

//validates the description and amount // also if the fields in contri and spent are empty then considers them as Zero

  validate() async {
    if (_formKey.currentState.validate()) {
      var contrisum = 0;
      var spentsum = 0;
      var mainamount = int.parse(amount.value.text);
      contribution.forEach((element) {
        var val;
        if (element.value.text.isNotEmpty) {
          val = int.parse(element.value.text);
        } else {
          val = 0;
        }
        contrisum = val + contrisum;
        this.contrisum == null
            ? this.contrisum = [val]
            : this.contrisum.add(val);
      });
      spent.forEach((element) {
        var val;
        if (element.value.text.isNotEmpty) {
          val = int.parse(element.value.text);
        } else {
          val = 0;
        }
        spentsum = val + spentsum;
        this.spentsum == null ? this.spentsum = [val] : this.spentsum.add(val);
      });
      if ((spentsum == contrisum) && (contrisum == mainamount)) {
        print(contrisum);
        convert();
      } else {
        //if amount and sum of contri and sum of spent is not equal it shows error in the error box
        await showerror(mainamount, contrisum, spentsum);
      }
    }
  }

//shows error
  showerror(mainamount, contrisum, spentsum) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text('Values doesnot match'),
              content: Container(
                width: 250,
                height: 75,
                child: Column(
                  children: <Widget>[
                    Text('Total Contribution :$contrisum'),
                    Text('Total Spent :$spentsum'),
                    Text('Actual Amount :$mainamount'),
                  ],
                ),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Expense'), actions: <Widget>[
        GestureDetector(
            child: Center(
                child: Text('SAVE',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400))),
            onTap: () {
              validate();
              //pops when group is created
              if (done) {
                Navigator.pop(context);
              }
            })
      ]),
      body: Form(
        key: _formKey,
        child: Column(children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.description),
              Expanded(
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Description';
                    }
                    return null;
                  },
                  controller: description,
                  decoration: InputDecoration(hintText: 'Enter Description'),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Icon(Icons.monetization_on),
              Expanded(
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Amount';
                    }
                    return null;
                  },
                  controller: amount,
                  decoration: InputDecoration(hintText: 'Amount'),
                  keyboardType: TextInputType.numberWithOptions(),
                ),
              )
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 20,
              ),
              Text('Member'),
              SizedBox(
                width: 70,
              ),
              Text('Contributed'),
              SizedBox(
                width: 50,
              ),
              Text('spent')
            ],
          ),
          SizedBox(
            height: 5,
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: members.length,
              itemBuilder: (BuildContext context, int index) {
                List memberholder = members[index][1].values.toList();
                return Container(
                  height: 40,
                  margin: EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[300]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "   " + memberholder[1].split(' ')[0],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w400),
                                ),
                                Flexible(
                                  child: Text(
                                    "    " + memberholder[0],
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 9.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            width: 100,
                            child: Form(
                              child: TextFormField(
                                controller: contribution[index],
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.lightBlueAccent,
                                        width: 1.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.lightBlueAccent,
                                        width: 2.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                ),
                                keyboardType: TextInputType.numberWithOptions(),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter Amount';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: 100,
                            child: Form(
                              child: TextFormField(
                                controller: spent[index],
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.lightBlueAccent,
                                        width: 1.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.lightBlueAccent,
                                        width: 2.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                ),
                                keyboardType: TextInputType.numberWithOptions(),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter Amount';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }),
        ]),
      ),
    );
  }
}

//   ListTile(
//     title: Text('Paid by (Single)'),
//     trailing: IconButton(
//         onPressed: (){
//           setState(() {
//             _isExpanded=!_isExpanded;

//           });
//         },
//         icon: Icon(_isExpanded? Icons.expand_less:Icons.expand_more
//     ),
//   ),
//   ),
//  if(_isExpanded)
//   ListView(
//  children: list,
//  shrinkWrap: true,
//  ),
// if(_isExpanded)
//  Text('Selected Member :'+singleSelectedmember[0],
//   style:TextStyle(
//             color: Colors.black,
//             fontSize: 17.0,
//             fontWeight: FontWeight.w400
//           ),
//  ),
//  ListTile(
//     title: Text('Paid by (Multiple)'),
//     trailing: IconButton(
//         onPressed: (){
//           setState(() {

//           });
//         },
//         icon: Icon(_isExpanded? Icons.expand_less:Icons.expand_more
//     ),
//   ),
//   ),
