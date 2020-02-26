import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'dart:convert';
import 'package:clima/services/weather.dart';
import 'package:flutter/services.dart';


class LocationScreen extends StatefulWidget {
  LocationScreen(this.weatherData);
   final String weatherData;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
String condition,message;
var cityName;
  int temperature;
  String city;
  int id,temp;
 WeatherModel weather=WeatherModel();
 @override
  void dispose() {
     SystemNavigator.pop();
    super.dispose();
    
  }
 @override
  void initState() {
    super.initState();
    reQuired(widget.weatherData);
  }
  
  dynamic reQuired(data){
    setState(() {
      if(data==null){
        
        condition='404';
        message="restart";
        city='bc';
        return;
       }
           print('entered');
           var temp= jsonDecode(data)['main']['temp'];
           print('ok');
           city= jsonDecode(data)['name'];
           id = jsonDecode(data)['weather'][0]['id'];
           condition= weather.getWeatherIcon(id);
           temperature=temp.toInt();
           message=weather.getMessage(temperature);
    });
       
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async{
                     
                      String weatherData= await WeatherModel().getWeatherData();
                      reQuired(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      cityName= await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();}
                        ));
                    if(cityName != null) {
                      
                      print(cityName);
                      String cityData= await weather.getCityWeather(cityName);
                      print(cityData);
                      reQuired(cityData);
                    }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$condition',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$message in $city",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
