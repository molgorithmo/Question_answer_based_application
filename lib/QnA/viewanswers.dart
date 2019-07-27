import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/QnA/answerpage.dart';
import 'package:flutter_app/QnA/questions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/topic.dart';
import 'package:flutter_app/firestoreservice.dart';

class ViewMode extends StatefulWidget {
  final Topic ques;

  ViewMode(this.ques);

  @override
  State<StatefulWidget> createState() {
    return _ViewModeState();
  }
}

class _ViewModeState extends State<ViewMode> {
  var items = new List();
  String answer, question12;
  int num;

  @override
  void initState() {
    super.initState();

    question12 = widget.ques.question;
    num = widget.ques.question_number;
  }

  /*readData(int len)
  {
    DocumentReference ds = Firestore.instance.collection('answers').document('32');
    ds.get().then((datasnapshot) {
      for(var j=0;j<len;j++) {
        var data = datasnapshot.data['answer'][0];
        var entryList = data.entries.toList();
          for(var i=0;i<entryList.length;i++){
            print(entryList[i]);
            items.add('${entryList[i].value}');
          }
      }
    });
    print(items);
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Answers")
      ),
      body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.all(14.0),
                child: ListView(
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  children: <Widget>[
                    Text("$question12",style: TextStyle(fontSize: 19.0)
                    ),

                    Divider(
                      color: Colors.blueGrey,
                    ),

                    Container(
                      height: 630.0,
                      child: ListView.builder(
                        itemCount: 90,
                          itemBuilder: (context, index){
                            return Card(
                              elevation: 8.0,
                              child : Padding(padding: EdgeInsets.all(20.0),
                                  child : Wrap(children:<Widget>[Text("Answer!",)] ))
                            );
                          }
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(

            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.72,
                right: MediaQuery.of(context).size.width *0.04),
          child: OutlineButton(
              borderSide:
              BorderSide(color: Colors.blue),
              splashColor: Colors.blue,
              child: Text("Answer",
                  style: TextStyle(
                    color: Colors.black,
                  )),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>

                      AnswerPage(Topic('$question12',num))
                    )
                );
              },
              shape: new RoundedRectangleBorder(
                  borderRadius:
                  new BorderRadius.circular(
                      30.0)
              )
          ),
        )
      ),
    );


  }
}
