import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MaterialApp(
    home: MyLocator(),
  ));
}

class MyLocator extends StatefulWidget {
  MyLocator({Key? key}) : super(key: key);
  dynamic lon = "Unknown";
  dynamic lat = "Unknown";
  @override
  State<MyLocator> createState() => _MyLocatorState();
}

class _MyLocatorState extends State<MyLocator> {
  void GetLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition();
        setState(() {
          widget.lon = position.longitude;
          widget.lat = position.latitude;
        });
      } else {
        print("Could not get location");
      }
    } else {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        widget.lon = position.longitude;
        widget.lat = position.latitude;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
            onPressed: () {
              GetLocation();
            },
            child: Text("Get Location"),
          ),
          Text(widget.lon.toString()),
          Text(widget.lat.toString())
        ]),
      ),
    );
  }
}
