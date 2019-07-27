import 'package:flutter/material.dart';
import 'package:flutter_app/questionsandanswers.dart';
import './profile.dart';
import './dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/dashboardvia.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _myAppState();
  }
}

class _myAppState extends State<MyApp> with SingleTickerProviderStateMixin {

  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "TSEC",
        home: Scaffold(
            body: TabBarView(
              children: [DashBoardvia(), QuestionandAnswer(),Profile()],
              controller: tabController,
            ),

            bottomNavigationBar: Container(
              child: TabBar(
                controller: tabController,
                tabs: [
                  Tab(icon: Icon(Icons.dashboard, color: Colors.black,)),
                  Tab(icon: Icon(Icons.search, color: Colors.black,)),
                  Tab(icon: Icon(Icons.account_circle, color: Colors.black,)),
                ],
              ),
            )
        ));
  }
}