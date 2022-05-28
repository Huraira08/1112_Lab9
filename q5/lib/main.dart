import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';

import 'NetworkHelper.dart';

void main() {
  runApp(MaterialApp(
    home: WeatherApp(),
  ));
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  double lon = 0, lat = 0;
  String? city;
  int? id;
  double? temp;
  bool displaySpinKit = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetWeather();
  }

  // void GetCurrentPosition() async {
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   try {
  //     if (permission == LocationPermission.denied) {
  //       var position = await Geolocator.getCurrentPosition();
  //       setState(() {
  //         lon = position.longitude;
  //         lat = position.latitude;
  //       });
  //     }
  //   } catch (e) {}
  // }

  void GetWeather() async {
    LocationPermission permission = await Geolocator.checkPermission();
    try {
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
    } catch (e) {}
    var position = await Geolocator.getCurrentPosition();
    lon = position.longitude;
    lat = position.latitude;
    // setState(() {
    //   lon = position.longitude;
    //   lat = position.latitude;
    print("Long and Lat");
    // });

    var net = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=9e915b5720777feafaf4465d77780400');
    var jsonData = await net.getData();
    setState(() {
      city = jsonData['name'];
      id = jsonData['weather'][0]['id'];
      temp = jsonData['main']['temp'];
      print("temps");
      displaySpinKit = false;
    });
  }

  SpinKitDoubleBounce GetSpinkit() {
    return SpinKitDoubleBounce(color: Colors.black, size: 50);
  }

  Column GetFields() {
    return Column(
      children: [
        Text("City = $city"),
        Text("id = $id"),
        Text('Temperature = $temp')
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Container(
            child: Column(
          children: [
            displaySpinKit ? GetSpinkit() : GetFields(),
          ],
        )),
      ),
    );
  }
}
