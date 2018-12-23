import 'package:flutter/material.dart';

import '../pages/landing_page.dart';

import 'package:cloud_firestore/cloud_firestore.dart';


// import 'dart:async';

class ScorePage extends StatefulWidget {

  @override
  ScorePageState createState() {
    return new ScorePageState();
  }

  final int _score;

  ScorePage(this._score);

  void submitScore(String username){
      // Submit their score
      Firestore.instance.collection('submissions').add({
          'score': _score,
          'username': username
      });

  }
}

class ScorePageState extends State<ScorePage> {
    String _username;

    void onChanged(String value) {
        setState(() {
            _username = value;
        });
    }

    @override
    Widget build(BuildContext context){


        _showDialog() async {
            await showDialog<String>(
              context: context,
              builder: (_) => new AlertDialog(
                contentPadding: const EdgeInsets.all(16.0),
                content: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new TextField(
                        maxLength: 16,
                        autofocus: true,
                        decoration: new InputDecoration(
                            labelText: 'Submit Score Enter username:\n', hintText: 'eg. Dat boii'),
                        onChanged: (String value){onChanged(value);},
                      ),
                    )
                  ],
                ),
                actions: <Widget>[
                  new FlatButton(
                      child: const Text('CANCEL'),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  new FlatButton(
                      child: const Text('SUBMIT'),
                      onPressed: () {
                        if (_username != null){
                            widget.submitScore(_username);
                            Navigator.pop(context);
                            Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new LandingPage()));
                        }
                      })
                ],
              ),
            );
        }



        return new WillPopScope(
            onWillPop: () async => false,
            child: new Material(
                color: Color(0xFF75CFD6),
                child: new Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                        new Column(
                            mainAxisAlignment: MainAxisAlignment.center ,
                            children:   <Widget>[
                                new Image.asset('./images/UI_images/score_page_banner.png', width: MediaQuery.of(context).size.width*(0.9),),
                                // new Padding


                                new Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: new Text(widget._score.toString(), style: new TextStyle(color: Colors.white, fontSize: 140.0, fontWeight: FontWeight.bold)),
                                ),

                                new Material(
                                    color: Colors.transparent,
                                    child: new Container(
                                        width: 160.0,
                                        child: new Ink.image(
                                            image: new AssetImage('./images/UI_images/home.png'),
                                            height: 70.0,
                                            child: new InkWell(
                                                splashColor: Colors.white54,
                                                onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new LandingPage(), )),
                                            ),
                                        ),
                                    ),
                                ),

                                new Padding(
                                    padding: EdgeInsets.all(10.0),
                                ),

                                new Material(
                                    color: Colors.transparent,
                                    child: new Container(
                                        width: 160.0,
                                        child: new Ink.image(
                                            image: new AssetImage('./images/UI_images/submit.png'),
                                            height: 70.0,
                                            child: new InkWell(
                                                splashColor: Colors.white54,
                                                onTap: () => _showDialog(),
                                            ),
                                        ),
                                    ),
                                ),

                                // new IconButton(
                                //     icon: new Image.asset('./images/UI_images/home.png', width: MediaQuery.of(context).size.width*(0.9),),
                                //     color: Colors.white,
                                //     iconSize: 100.0,
                                //     onPressed: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new LandingPage(), )),
                                //     // onPressed: () => Navigator.pop(context).pop(context),
                                // ),
                                // new IconButton(
                                //     icon: new Icon(Icons.send),
                                //     color: Colors.white,
                                //     iconSize: 50.0,
                                //     onPressed: () => _showDialog(),
                                // ),
                            ]
                        ), // Column
                    ], // <widget>[]
                ) //stack
            )
        );
    }
}
