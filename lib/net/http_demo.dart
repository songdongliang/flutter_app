import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class HttpPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _HttpPageState();

}

class _HttpPageState extends State<HttpPage> {

  var _ipAddress = "Unknown";

  _getIpAddress() async {
    var url = 'https://httpbin.org/ip';
    var httpClient = HttpClient();

    String result ;

    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var json = await response.transform(utf8.decoder).join();
        var data = jsonDecode(json);
        result = data['origin'];
      } else {
        result = "Error getting IP address: \nHttp status ${response.statusCode}";
      }
    } catch (exception) {
      result = "Failed getting IP address";
    }

    if (!mounted) return;

    setState(() {
      _ipAddress = result;
    });
  }

  @override
  Widget build(BuildContext context) {

    var spacer = SizedBox(height: 20,);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Your current ip address is: "),
          Text("$_ipAddress"),
          spacer,
          RaisedButton(
            child: Text("Get IP address"),
            onPressed: _getIpAddress,
          )
        ],
      ),
    );
  }

}