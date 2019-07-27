import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/QnA/answerpage.dart';
import 'package:flutter_app/QnA/questions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'topic.dart';
import 'firestoreservice.dart';
import './QnA/viewanswers.dart';

class QuestionandAnswer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _QuestionandAnswerState();
  }
}

class _QuestionandAnswerState extends State<QuestionandAnswer> {
  List<Topic> items;

  FirestoreService fireServ = new FirestoreService();
  StreamSubscription<QuerySnapshot> togetTopic;

  @override
  void initState() {
    super.initState();

    items=new List();

    togetTopic?.cancel();
    togetTopic=fireServ.getTopicList().listen((QuerySnapshot snapshot){
      final List<Topic> topics=snapshot.documents
          .map((documentSnapshot) => Topic. fromMap(documentSnapshot.data))
          .toList();

      setState(() {
        this.items = topics;
      });

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: Text("Profile"),
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection('questions').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text('Loading...');
            } else
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: <Widget>[
                      Card(
                          elevation: 4.0,
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                title: Column(
                                  children: <Widget>[
                                    Container(
                                        alignment: Alignment.topLeft,
                                        child: Chip(
                                            label: Text("Math")
                                        )
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Expanded(
                                            child: Text(
                                              'username',
                                          style: TextStyle(fontSize: 14.0),
                                        )),
                                        Expanded(child: Text("333")),
                                      ],
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                  '${items[index].question}',
                                  softWrap: false,
                                  overflow: TextOverflow.fade,
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *0.63,
                                      bottom: MediaQuery.of(context).size.height *0.01
                                  ),
                                  child: OutlineButton(
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                      splashColor: Colors.blue,
                                      child: Text("Answer",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.0,
                                          )),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>ViewMode(Topic('${items[index].question}',items[index].question_number))

                                                //AnswerPage(Topic('${items[index].question}',items[index].question_number
                                                //)
                                                //)
                                            )
                                        );
                                      },
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(
                                                  30.0)
                                      )
                                  )
                              ),

                            ],
                          )),
                    ],
                  );
                },
              );
          } //else
          ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.add),
          tooltip: "Add a question",
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => new QuestionPage(Topic('',0))));
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
