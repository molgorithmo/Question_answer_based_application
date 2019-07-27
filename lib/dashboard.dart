import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DashBoard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _dashBoardState();
  }
}

class _dashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
        stream: Firestore.instance.collection('post').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text('Loading...');
          } else {
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot myPost = snapshot.data.documents[index];
                  return Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Card(
                              elevation: 18.0,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 200.0,
                                    child: Image.network('${myPost['image']}',
                                        fit: BoxFit.fill),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.height * .01),
                                    child: Column(
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '${myPost['title']}',
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text('${myPost['subtitle']}',
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blueGrey))),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * .36 ,
                          left: MediaQuery.of(context).size.width * .81,
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: CircleAvatar(
                            backgroundColor: Color(0xff543B7A),
                            child: Icon(Icons.share, color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  );
                });
          }
        });
  }
}
