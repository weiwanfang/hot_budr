import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class HighScoreBoard extends StatefulWidget {

  @override
  HighScoreBoardState createState() {
    return new HighScoreBoardState();
  }
  HighScoreBoard();
}

class HighScoreBoardState extends State<HighScoreBoard> {

    Widget _buildListItem(BuildContext context, DocumentSnapshot document, int index){
        return ListTile(
            title: Row(
                children: [
                    Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                            (index+1).toString() + '.',
                            style: new TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
                        ), // Text
                    ), // Expanded
                    Expanded(
                        child: Material(
                            // color: Color(0xFFFCEC97),
                            child: Text(
                                document['username'],
                                style: new TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
                            ), // Text
                        ),
                    ), // Expanded
                    Container(
                        decoration: const BoxDecoration(
                            color: Color(0xFFFCEC97),
                        ), // BoxDecoration
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                            document['score'].toString(),
                            style: new TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
                        )
                    ), // Container
                ]
            )
        );
    }


    @override
    Widget build(BuildContext context){

        return new Material(
            child: Scaffold(
                appBar: AppBar(
                    backgroundColor: Color(0xFF75CFD6),
                    title: Text('TOP 15 HIGH SCORES', style: new TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24.0))
                ),
                body: StreamBuilder(
                    stream: Firestore.instance.collection('submissions').orderBy('score', descending: true).snapshots(),
                    builder: (context, snapshot) {
                        if (!snapshot.hasData) return const Text('Loading...');
                        return ListView.builder(
                            itemExtent: 80.0,
                            itemCount: snapshot.data.documents.length > 15 ? 15 : snapshot.data.documents.length,
                            itemBuilder: (context, index) =>
                                _buildListItem(context, snapshot.data.documents[index], index),
                        );
                    }
                )
            ) // scaffold

        );
    }
}
