import 'package:Contri/models/Groups.dart';
import 'package:Contri/models/HandleUser.dart';
import 'package:Contri/models/singleGroup.dart';
import 'package:Contri/screen/ExpenseDetail.dart';
import 'package:Contri/screen/SearchUsers.dart';
import 'package:Contri/screen/createExpense.dart';
import 'package:Contri/widget/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupContent extends StatefulWidget {
  static String id = 'GroupContent';
  final Groups obj;
  GroupContent({this.obj});
  @override
  _GroupContentState createState() => _GroupContentState();
}

class _GroupContentState extends State<GroupContent> {
  Future<QuerySnapshot> allExpenses;
  Map<String, dynamic> memberlist;
  Future<QuerySnapshot> b;
  List<List> settleAndpay;
  int totalallexpense;
  List<List> membersCS = [];
  @override
  initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  dothis(sg) async {
    memberlist = await sg.allMembers(widget.obj);
  }

  settleandpay1(List sengleExp) {
    var j = 1;
    var cal = [];
    totalallexpense = totalallexpense + sengleExp[0];
    for (var i = 1; i <= sengleExp.length / 4; i++) {
      var a = [
        sengleExp[j],
        sengleExp[j + 1],
        sengleExp[j + 2],
        sengleExp[j + 3]
      ];
      cal.add(a);
      j = j + 4;
    }
    settleAndpay.add(cal);
  }

  settleandpay2(List<List> sAnde) {
    membersCS = [];
    memberlist.forEach((key, value) => {
          membersCS == null
              ? membersCS = [
                  [key, value]
                ]
              : membersCS.add([key, value])
        });
    for (var i = 0; i < sAnde.length; i++) {
      for (var j = 0; j < sAnde[i].length; j++) {
        if (membersCS[j].length < 3) {
          membersCS[j].add(sAnde[i][j][2]);
          membersCS[j].add(sAnde[i][j][3]);
        } else {
          membersCS[j][2] = sAnde[i][j][2] + membersCS[j][2];
          membersCS[j][3] = sAnde[i][j][3] + membersCS[j][3];
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final sg = Provider.of<SingleGroup>(context, listen: true);
    allExpenses = sg.allExpense(widget.obj);
    dothis(sg);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.obj.groupName),
        centerTitle: true,
        actions: <Widget>[
          Center(child: Text('Add Member')),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      //passing Groups obj and members list to the createexpense page
                      builder: (context) => Search(obj: widget.obj)));
            },
          )
        ],
        bottom: PreferredSize(
            child: FutureBuilder(
              initialData: b,
              future: allExpenses,
              builder: (BuildContext content, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  totalallexpense = 0;
                  settleAndpay = [];
                  snapshot.data.documents.forEach((data1) {
                    var a = SingleGroup.fromDocument(data1);
                    settleandpay1(a.expense);
                  });
                  // if (settleAndpay.length > 0) {
                  //   settleandpay2(settleAndpay);
                  // return NamesAndOther(
                  //     totalallexpense: totalallexpense, membersCS: membersCS);
                  //   return Text(
                  //     'Group Expense : ' + totalallexpense.toString(),
                  //     style: TextStyle(
                  //         fontSize: 25,
                  //         fontWeight: FontWeight.bold,
                  //         color: Colors.white),
                  //   );
                  // } else {
                  return Text(
                    'Group Expense : ' + (totalallexpense).toString(),
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  );
                  //  }
                } else {
                  return Text(
                    'Group Expense : ' + 0.toString(),
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  );
                }
              },
            ),
            preferredSize: Size.fromHeight(200.0)),
      ),
      body: Column(children: <Widget>[
        Expanded(
          flex: 5,
          child: Stack(
            children: <Widget>[
              FutureBuilder(
                  initialData: b,
                  future: allExpenses,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    Future.delayed(Duration(milliseconds: 500));
                    if (snapshot.hasData) {
                      List<ExpensTile> names = [];
                      var i = 0;
                      snapshot.data.documents.forEach((data1) {
                        var a = SingleGroup.fromDocument(data1);
                        names.add(ExpensTile(
                            a.name, a.date, a.expense, sg, widget.obj, i));
                        i = i + 1;
                      });

                      return ListView(children: names, shrinkWrap: true);
                    } else {
                      return circularProgress();
                    }
                  }),
              Positioned(
                child: ClipOval(
                  child: Material(
                    color: Colors.blue, // button color
                    child: InkWell(
                      child: SizedBox(
                          width: 65,
                          height: 65,
                          child:
                              Icon(Icons.add, color: Colors.white, size: 25)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                //passing Groups obj and members list to the createexpense page
                                builder: (context) => CreateExpense(
                                    memberlist: memberlist,
                                    obj: widget.obj,
                                    sg: sg)));
                      },
                    ),
                  ),
                ),
                bottom: 25,
                right: 25,
              )
            ],
          ),
        ),
      ]),
    );
  }
}

// class NamesAndOther extends StatelessWidget {
//   const NamesAndOther({
//     Key key,
//     @required this.totalallexpense,
//     @required this.membersCS,
//   }) : super(key: key);

//   final int totalallexpense;
//   final List<List> membersCS;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(10),
//       child: Column(
//         children: <Widget>[
//           Text(
//             'Group Expense : ' + totalallexpense.toString(),
//             style: TextStyle(
//                 fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
//           ),
//           ListView.builder(
//               shrinkWrap: true,
//               itemCount: membersCS.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return Container(
//                   height: 30,
//                   margin: EdgeInsets.all(3.0),
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10.0),
//                       color: Colors.grey[300]),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: <Widget>[
//                           Text(
//                             "    " + membersCS[index][0],
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 17.0,
//                                 fontWeight: FontWeight.w400),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: <Widget>[
//                           if (membersCS[index][2] - membersCS[index][3] < 0)
//                             Container(
//                                 width: 105,
//                                 child: Text('owes : ' +
//                                     (-(membersCS[index][2] -
//                                             membersCS[index][3]))
//                                         .toString())),
//                           if (membersCS[index][2] - membersCS[index][3] > 0)
//                             Container(
//                               width: 105,
//                               child: Text('should get : ' +
//                                   (-(membersCS[index][3] - membersCS[index][2]))
//                                       .toString()),
//                             ),
//                           if (membersCS[index][2] - membersCS[index][3] == 0)
//                             Container(
//                               width: 105,
//                               child: Text('settled'),
//                             ),
//                         ],
//                       )
//                     ],
//                   ),
//                 );
//               }),
//         ],
//       ),
//     );
//   }
// }

// class ExpenseTile extends StatelessWidget {
//   final String name;
//   final DateTime time;
//   final List<dynamic> expense;
//   final List<List> cal = [];
//   static int myContri;
//   static int mySpent;
//   final SingleGroup sg;
//   final Groups obj;
//   final int docId;
//   ExpenseTile(
//       this.name, this.time, this.expense, this.sg, this.obj, this.docId);

//   dothis() {
//     var j = 1;
//     for (var i = 1; i <= expense.length / 6; i++) {
//       if (HandleUser.userinfo.uid == expense[j + 1]) {
//         myContri = expense[j + 4];
//         mySpent = expense[j + 5];
//       }
//       var a = [
//         expense[j],
//         expense[j + 1],
//         expense[j + 2],
//         expense[j + 3],
//         expense[j + 4],
//         expense[j + 5]
//       ];
//       cal.add(a);
//       j = j + 6;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     dothis();

//     return cal == null
//         ? Container(
//             height: 60,
//             margin: EdgeInsets.all(3.0),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10.0),
//               color: Colors.grey[300],
//             ),
//             child: ListTile(
//               isThreeLine: true,
//               title: Text(name),
//               subtitle: Text("Your Conti : " + myContri.toString()),
//               trailing: Column(
//                 children: <Widget>[
//                   Text("Total Amount : " + expense[0].toString()),
//                   if ((myContri - mySpent) < 0)
//                     Text("You owe : " + (-(myContri - mySpent)).toString()),
//                   if ((myContri - mySpent) > 0)
//                     Text("You lend : " + (myContri - mySpent).toString()),
//                   if ((myContri - mySpent) == 0) Text(" Settled "),
//                 ],
//               ),
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ExpenseDetails(
//                             name, cal, time, expense[0], sg, obj, docId)));
//               },
//             ))
//         : circularProgress();
//   }
// }

class ExpensTile extends StatefulWidget {
  final String name;
  final DateTime time;
  final List<dynamic> expense;
  final SingleGroup sg;
  final Groups obj;
  final int docId;

  ExpensTile(this.name, this.time, this.expense, this.sg, this.obj, this.docId);
  @override
  _ExpensTileState createState() => _ExpensTileState();
}

class _ExpensTileState extends State<ExpensTile> {
  final List<List> cal = [];
  static int myContri;
  static int mySpent;

  @override
   initState() {
    super.initState();
    dothis();
  }

  dothis()  {
    var j = 1;
    for (var i = 1; i <= widget.expense.length / 6; i++) {
      if (HandleUser.userinfo.uid == widget.expense[j + 2]) {
        myContri = widget.expense[j + 4];
        mySpent = widget.expense[j + 5];
        print(myContri);
        print(mySpent);
      }
      var a = [
        widget.expense[j],
        widget.expense[j + 1],
        widget.expense[j + 2],
        widget.expense[j + 3],
        widget.expense[j + 4],
        widget.expense[j + 5]
      ];
      cal.add(a);
      j = j + 6;
    }
    print(cal);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        margin: EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey[300],
        ),
        child: ListTile(
          isThreeLine: true,
          title: Text(widget.name),
          subtitle: Text("Your Conti : " + myContri.toString()),
          trailing: Column(
            children: <Widget>[
              Text("Total Amount : " + widget.expense[0].toString()),
              if ((myContri - mySpent) < 0)
                Text("You owe : " + (-(myContri - mySpent)).toString()),
              if ((myContri - mySpent) > 0)
                Text("You lend : " + (myContri - mySpent).toString()),
              if ((myContri - mySpent) == 0) Text(" Settled "),
            ],
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ExpenseDetails(
                        widget.name,
                        cal,
                        time,
                        widget.expense[0],
                        widget.sg,
                        widget.obj,
                        widget.docId)));
          },
        ));
  }
}
