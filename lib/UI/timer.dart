import 'package:flutter/material.dart';
// import 'dart:math';
// import 'dart:async';

class TimerUI extends StatefulWidget {


    final VoidCallback _handleTimeout;

    TimerUI(this._handleTimeout);

    @override
    State createState() => new TimerUIState();

    void onZero(double val){
        if (val == 1.0) {
            _handleTimeout();
        }
    }
}

class TimerUIState extends State<TimerUI> with TickerProviderStateMixin {

    Animation<double> _iconAnimation; // 0, 0.1, 0.2, 0.3... 1
    AnimationController _iconAnimationController;

    @override
    void initState(){
        super.initState();
        _iconAnimationController = new AnimationController(duration: new Duration(seconds: 30), vsync: this);
        _iconAnimation = new CurvedAnimation(parent: _iconAnimationController, curve: Curves.linear);
        _iconAnimation.addListener(() => this.setState(() {})); //re-renders text everytime font sz changes

        _iconAnimation.addListener(
            () => widget.onZero(_iconAnimation.value)
        );

        _iconAnimationController.forward();
    }

    @override
    Widget build(BuildContext context) {
        return new Material(
            color: Colors.transparent,
                child: new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                            new Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: new Text((30 - _iconAnimation.value*30).round().toString(), style: new TextStyle(color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold)),
                            ),
                        ]
                ),

        );
    }

}
