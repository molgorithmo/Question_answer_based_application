import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/topic.dart';

class AnswerPage extends StatefulWidget {
  final Topic ques;

  AnswerPage(this.ques);

  @override
  State<StatefulWidget> createState() {
    return _AnswerPageState();
  }
}

class _AnswerPageState extends State<AnswerPage> {
  String answer, question12;
  int num;

  void initState() {
    super.initState();
    question12 = widget.ques.question;
    num = widget.ques.question_number;
  }

  getAnswer(answer) {
    this.answer = answer;
  }

  createData() {
    DocumentReference ds =
        Firestore.instance.collection('answers').document('$num');
    Map<String, dynamic> answer_entry = {
      "username": "username",
      "answer": answer
    };

    if (ds == null) {
      ds.updateData({
        "answer": FieldValue.arrayUnion([answer_entry])
      }).whenComplete(() {
        print("done!");
      });
    } else {
      ds.setData({
        "answer": FieldValue.arrayUnion([answer_entry])
      }).whenComplete(() {
        print("done!");
      });
    }

    /*ds.setData({
        "answer": FieldValue.arrayUnion([answer_entry])
      }).whenComplete(() {
        print("done!");
      });*/
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Answer"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(14.0),
              child: ListView(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                children: <Widget>[
                  Text(
                    "$question12",
                    style: TextStyle(fontSize: 19.0),
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.blueGrey,
            ),
            Container(
              height: 400.0,
              padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
              child: TextField(
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1, color: Colors.blueGrey)
                    ),
                    enabledBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1, color: Colors.blueGrey)
                    ),
                    hintText: 'Enter your answer'),
                onChanged: (String answer) {
                  getAnswer(answer);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        child: RaisedButton(
          onPressed: () {
            createData();
            Navigator.pop(context);
          },
          child: Text("Answer"),
        ),
      ),
    );
  }
}
