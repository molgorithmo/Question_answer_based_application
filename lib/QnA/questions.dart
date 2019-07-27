import 'package:flutter/material.dart';
import 'package:flutter_app/firestoreservice.dart';
import 'package:flutter_app/topic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionPage extends StatefulWidget{
  final Topic topic;
  QuestionPage(this.topic);
  @override
  State<StatefulWidget> createState() {
    return _QuestionPageState();
  }
}

class _QuestionPageState extends State<QuestionPage>{

  String question,answer;
  static int question_number = 0;

  FirestoreService fireServ = new FirestoreService();

  TextEditingController _questionController;

  getQuestion(question){this.question = question; question_number +=1;}

  createData(){
    DocumentReference ds = Firestore.instance.collection('questions').document('$question_number');
    Map<String, dynamic> question_entry={
      "question":question
    };
    ds.setData(question_entry).whenComplete((){
      print("done!");
    });
  }

  void initState(){
    super.initState();

    _questionController = new TextEditingController(text: widget.topic.question);

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Ask"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 5.0,left: 10.0, right:10.0),
            child: TextField(
              controller: _questionController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter your question...'
              ),
              onChanged: (String question){
              getQuestion(question);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        child: RaisedButton(onPressed: (){
          fireServ.createTopic(_questionController.text, question_number);
          Navigator.pop(context);
        },
          child: Text("Submit"),
        ),
      ),
    );
  }
}