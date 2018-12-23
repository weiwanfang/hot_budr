import 'package:flutter/material.dart';

class QuestionText extends StatefulWidget {

    final String _question;
    final int _questionNum;

    QuestionText(this._question, this._questionNum);

    @override
    State createState() => new QuestionTextState();
}

class QuestionTextState extends State<QuestionText> with SingleTickerProviderStateMixin {

    Animation<double> _fontSizeAnimation; // 0, 0.1, 0.2, 0.3... 1
    AnimationController _fontSizeAnimationController;

    @override
    void initState(){
        super.initState();
        _fontSizeAnimationController = new AnimationController(duration: new Duration(milliseconds: 500), vsync: this);
        _fontSizeAnimation = new CurvedAnimation(parent: _fontSizeAnimationController, curve: Curves.bounceOut);
        _fontSizeAnimation.addListener(() => this.setState(() {})); //re-renders text everytime font sz changes
        _fontSizeAnimationController.forward();
    }

    @override
    void didUpdateWidget(QuestionText oldWidget){
        super.didUpdateWidget(oldWidget);
        if (oldWidget._questionNum != widget._questionNum)
        {
            _fontSizeAnimationController.reset();
            _fontSizeAnimationController.forward();
        }
    }

    @override
    Widget build(BuildContext context) {
        return new Material(
            color: Colors.white,
            child: new Padding(
                padding: new EdgeInsets.symmetric(vertical: 20.0),
                child: new Center(
                    child: new Text("Question #" + widget._questionNum.toString() + ": " + widget._question,
                        style: new TextStyle(fontSize: _fontSizeAnimation.value * 15),
                    )
                )
            ),
        );
    }
}
