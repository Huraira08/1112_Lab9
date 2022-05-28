import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MaterialApp(
    home: MyLocator(),
  ));
}

class MyLocator extends StatefulWidget {
  MyLocator({Key? key}) : super(key: key);
  dynamic per = "Unknown";
  @override
  State<MyLocator> createState() => _MyLocatorState();
}

class _MyLocatorState extends State<MyLocator> {
  void CheckPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        setState(() {
          widget.per = "Permission denied";
          print(permission.toString());
        });
      } else {
        setState(() {
          widget.per = "Permission Given";
          print(permission.toString());
        });
      }
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
              CheckPermission();
            },
            child: Text("Get Location"),
          ),
          Text(widget.per),
        ]),
      ),
    );
  }
}
