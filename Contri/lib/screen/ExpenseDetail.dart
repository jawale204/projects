import 'package:Contri/models/Groups.dart';
import 'package:Contri/models/singleGroup.dart';
import 'package:Contri/widget/genbutton.dart';
import 'package:flutter/material.dart';

class ExpenseDetails extends StatelessWidget {
  final String name;
  final DateTime time;
  final List<List> cal;
  final int expense;
  final SingleGroup sg;
  final int docId;
  final Groups obj;
  ExpenseDetails(this.name, this.cal, this.time, this.expense, this.sg,
      this.obj, this.docId);
  final GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();
  snackBar(bool present) {
    var message;
    if (present) {
      message = 'Expense deleted';
    }
    final snackBar = SnackBar(content: Text(message));
    _scaffoldstate.currentState.showSnackBar(snackBar);
  }

  doit(context) async {
    bool p = await sg.deleteExpense(docId, obj);
    snackBar(p);
   
    Future.delayed(const Duration(milliseconds: 500), () {
       Navigator.pop(context);
       });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldstate,
      appBar: AppBar(
        title: Text(name),
        centerTitle: true,
      ),
      body: Column(children: <Widget>[
        SizedBox(
          height: 40,
        ),
        Center(
          child: Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'Expense Amount : ' + expense.toString(),
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              )),
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
        ListView.builder(
            shrinkWrap: true,
            itemCount: cal.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 35,
                margin: EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey[300]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "   " + cal[index][1].split(" ")[0],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "      " + cal[index][0],
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 9.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                            width: 105, child: Text(cal[index][4].toString())),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 80,
                          child: Text(cal[index][5].toString()),
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
        SizedBox(
          height: 30,
        ),
        SaveButton(
            txt: 'Delete Expense',
            onpress: () {
              doit(context);
              //        Navigator.of(context).popUntil(ModalRoute(Group.id)) ;
            })
      ]),
    );
  }
}
