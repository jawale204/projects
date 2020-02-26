import 'package:flutter/material.dart';
import 'question_array.dart';


void main() => runApp(Quiz());

class Quiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.black,
          body: 
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Quizbody(),
            )
            ),

      ),
    );
  }
}

class Quizbody extends StatefulWidget {
  @override
  _QuizbodyState createState() => _QuizbodyState();
}

class _QuizbodyState extends State<Quizbody> {
  List<Widget> scoreKeeper=[];
  int score=0;
  QuestionArray array= QuestionArray();
  void checkAns(bool userAns){
     
      setState(() {
      bool check= array.getQuestionAns() ;
              if (check==userAns){
                scoreKeeper.add(Icon(Icons.check,color: Colors.green));
                score ++;
              }
              else{
                scoreKeeper.add(Icon(Icons.close,color: Colors.red));
              }
             int reset =array.nextQuestion(context,score);
             if (reset==0)
             {
               scoreKeeper=[];
               score=0;
             }
              });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Center(
            child: Text(array.getQuestionText(),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
            ),
            ),
          ),
        ),
       Expanded(
          child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FlatButton(
            color: Colors.green,
           child: Text('True',style: TextStyle(
             fontSize: 20.0,
             color: Colors.white,
           ),),
           onPressed: (){
             checkAns(true);
           },
          ),
           ),
       ),
       Expanded(
                child: Padding(
             padding: const EdgeInsets.all(16.0),
             child: FlatButton(
               color: Colors.red,
             child: Text('False',style: TextStyle(
                fontSize: 20.0,
             color: Colors.white,
             )),
             onPressed: (){
               checkAns(false);
             },
           ),
           ),
       ),
       Row(
         children: scoreKeeper, 
       ),
      ],
    );
  }
}
