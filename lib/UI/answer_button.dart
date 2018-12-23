import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {

    final bool _answer;
    final VoidCallback _onTap;

    AnswerButton(this._answer, this._onTap); // constructor

    @override
    Widget build(BuildContext context) {
        return new Expanded(
            child: new Material(
                color: _answer == true ? Color(0xFFFF6542) : Color(0xFF75CFD6),
                child: new InkWell(
                    onTap: () => _onTap(),
                    child: new Center(
                        child: new Container(
                            decoration: new BoxDecoration(
                                border: new Border.all(color: Colors.white, width: 8.0)
                            ),
                            padding: new EdgeInsets.all(20.0),
                            child: Text(_answer == true ? 'HOT_BUDR' : 'NOT_BUDR',
                                style: new TextStyle(color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)
                            )
                        ),
                    )
                ),
            )
        );
    }
}
