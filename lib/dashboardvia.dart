import 'package:flutter/material.dart';
import 'package:flutter_app/dashboard.dart';

class DashBoardvia extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _DashBoardState();
  }
}

class _DashBoardState extends State<DashBoardvia>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        title: Text("TSEC Posts!"),
      ),
      body: DashBoard(),
    );
  }
}