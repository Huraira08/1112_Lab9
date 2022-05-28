import 'package:http/http.dart';
import 'dart:convert';

class NetworkHelper {
  String uri;
  NetworkHelper(this.uri);

  Future getData() async {
    Response response = await get(Uri.parse(uri));

    if (response.statusCode == 200) {
      dynamic body = response.body;
      return jsonDecode(body);
    } else {
      print(response.statusCode);
    }
  }

  // Future getIcon(Uri) async {
  //   Response response = await get(Uri.parse(uri));
  //   return response;

  //   // if (response.statusCode == 200) {
  //   //   dynamic body = response.body;
  //   //   return jsonDecode(body);
  //   // } else {
  //   //   print(response.statusCode);
  //   // }
  // }
}
