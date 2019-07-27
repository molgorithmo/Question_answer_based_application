import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'topic.dart';

final CollectionReference myCollection = Firestore.instance.collection("questions");

class FirestoreService{
  Future<Topic> createTopic(String question, int question_number) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(myCollection.document('$question_number'));

      final Topic topic = Topic(question, question_number);
      final Map<String, dynamic> data = topic.toMap();
      await tx.set(ds.reference, data);
      return data;
    };
    return Firestore.instance.runTransaction(createTransaction).then((mapData){
      return Topic.fromMap(mapData);
    }).catchError((error){
      print('error:$error');
    });
  }

  Stream<QuerySnapshot> getTopicList({int offset, int limit}){
    Stream<QuerySnapshot> snapshots = myCollection.snapshots();
    if(offset != null){
      snapshots = snapshots.skip(offset);
    }
    if(limit != null){
      snapshots = snapshots.take(limit);
    }
    return snapshots;
  }
}