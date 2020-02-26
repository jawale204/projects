import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bmi_calculator/primary_box.dart';
import 'package:bmi_calculator/card_content.dart';
import 'constant.dart';
import 'NewScreen.dart';
import 'brain.dart';

enum Gender{
 male,
 female,
}
class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender selectedGender;
  int height=180;
  int weight=50;
  int age=20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
       
        children: <Widget>[
          Expanded(
              child: Row(
              children: <Widget>[
                Expanded(child: Primarybox(
                onPress: (){
                setState(() {
                    selectedGender=Gender.male;
                  });
                },
                cardChild:CardContent(g:'Male',acon:FontAwesomeIcons.mars),
                colour: selectedGender==Gender.male? activeBoxColor:inactiveBoxColor,
                ),
                  ),
             
                Expanded(child: Primarybox(
                onPress: (){
                  setState(() {
                    selectedGender=Gender.female;
                  });
                },
                colour: selectedGender==Gender.female?activeBoxColor:inactiveBoxColor,
                cardChild:CardContent(g:'Female',acon:FontAwesomeIcons.venus),
                   ),
                  ),
              ],
            ),
          ),
          Expanded(child:
           Container(child: Primarybox(
             colour:activeBoxColor,
             cardChild: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
              Text('Height',
               style: labelTextStyle,
             
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.baseline,
                 textBaseline: TextBaseline.alphabetic,
                 children: <Widget>[
                   Text(height.toString(),style: textStyle,),
                    Text('cm'),
                     ],
               ),
               Slider(
                      value: height.toDouble(),
                      max: 200,
                      min: 25,
                      activeColor: bottonHeightColor,
                      onChanged: (double newHeight){
                        setState(() {
                          height=newHeight.round();
                        });
                      },
                    ),
               ],
             ),
             )
             )
          ),
          Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                   Expanded(child: Container(child: Primarybox(
                    colour:activeBoxColor,
                     cardChild: Column(
                       children: <Widget>[
                         Text('Weight',style: labelTextStyle,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: <Widget>[
                             Text(weight.toString(),style: textStyle,),
                             
                           ],
                           ),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: <Widget>[
                               GestureDetector(
                                onTap: (){
                                 setState(() {
                                   weight--;
                                 });
                               }, 
                                 child: Icon(Icons.remove_circle,size: 55)),
                               SizedBox(
                                 width: 10,
                               ),
                               GestureDetector(
                                    onTap: (){
                                 setState(() {
                                   weight++;
                                 });
                               }, 
                                 child: Icon(Icons.add_circle,size: 55, )),
                             ],
                           )
                       ],
                     )
                   ,))),
                Expanded(child: Container(child: Primarybox(
                  colour:activeBoxColor,
                  cardChild: Column(
                      children: <Widget>[
                        Text('Age',style:labelTextStyle,) ,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                           Text(age.toString(),style: textStyle,),
                           
                          ],
                        ) ,
                        Row( mainAxisAlignment: MainAxisAlignment.center,
                             children: <Widget>[
                               GestureDetector(
                               onTap: (){
                                 setState(() {
                                   age--;
                                 });
                               },  
                               child: Icon(Icons.remove_circle,size:55)),
                               SizedBox(
                                 width:10,
                               ),
                               GestureDetector(
                                onTap: (){
                                 setState(() {
                                   age++;
                                 });
                               }, 
                                 child: Icon(Icons.add_circle,size:55 )),
                             ],
                           )
                        ],
                        ),
                     )
                     ),
                   ),
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
                Brain cal= Brain(height: height,weight: weight);
              Navigator.push(context,MaterialPageRoute(builder: (context)=>Screen(
               bmi: cal.calBmi(),
               result:  cal.getResult(),
               inter: cal.interpretationRes()
              )));
            },
                      child: Container(
              child: Center(
                child: Text('Calculate',style: TextStyle(
                  fontSize: 20 )),
              ),
              color: bottonHeightColor ,
              height: 65.0,
              width: double.infinity,
            ),
          )
        ],
      ),
    );
  }
}

