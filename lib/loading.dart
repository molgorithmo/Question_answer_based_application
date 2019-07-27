import 'package:flutter/material.dart';

class Loading extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _LoadingState();
  }
}

class _LoadingState extends State<Loading>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.5, left: MediaQuery.of(context).size.width *0.5),
      child: Text("Loading..."),),
    );
  }
}