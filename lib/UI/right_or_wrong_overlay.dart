import 'package:flutter/material.dart';
import 'dart:math';

class RightOrWrongOverlay extends StatefulWidget {

    final bool _isCorrect;
    final VoidCallback _onTap;

    RightOrWrongOverlay(this._isCorrect, this._onTap());

    @override
    State createState() => new RightOrWrongOverlayState();
}

class RightOrWrongOverlayState extends State<RightOrWrongOverlay> with SingleTickerProviderStateMixin {

    Animation<double> _iconAnimation; // 0, 0.1, 0.2, 0.3... 1
    AnimationController _iconAnimationController;

    @override
    void initState(){
        super.initState();
        _iconAnimationController = new AnimationController(duration: new Duration(seconds: 2), vsync: this);
        _iconAnimation = new CurvedAnimation(parent: _iconAnimationController, curve: Curves.elasticOut);
        _iconAnimation.addListener(() => this.setState(() {})); //re-renders text everytime font sz changes
        _iconAnimationController.forward();
    }

    void onTapWithDispose(){ // Otherwise I get a bunch of errors if I dont dispose animation controller
        widget._onTap();
        _iconAnimationController.dispose();
    }
    // @override
    // void dispose() {
    //   assert(() {
    //     if (_iconAnimation == null || !_iconAnimationController.isActive)
    //       return true;
    //     throw FlutterError(
    //       '$this was disposed with an active Ticker.\n'
    //       '$runtimeType created a Ticker via its SingleTickerProviderStateMixin, but at the time '
    //       'dispose() was called on the mixin, that Ticker was still active. The Ticker must '
    //       'be disposed before calling super.dispose(). Tickers used by AnimationControllers '
    //       'should be disposed by calling dispose() on the AnimationController itself. '
    //       'Otherwise, the ticker will leak.\n'
    //       'The offending ticker was: ${_ticker.toString(debugIncludeStack: true)}'
    //     );
    //   }());
    //   super.dispose();
    // }

    @override
    Widget build(BuildContext context) {
        return new Material(
            color: Colors.black54,
            child: new InkWell(
                onTap: () => onTapWithDispose(),
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        new Container(
                            decoration: new BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle
                            ),
                            child: new Transform.rotate(
                                angle: _iconAnimation.value * 2 * pi,
                                child: new Icon(widget._isCorrect ? Icons.check : Icons.clear, size: _iconAnimation.value*80.0, color: Colors.black,)
                            )
                            // new Icon(widget._isCorrect ? Icons.check : Icons.clear, size: _iconAnimation.value*100, color: Colors.black,),
                        ),
                        new Padding(
                            padding: new EdgeInsets.only(bottom: 30.0)
                        ),
                        new Text(widget._isCorrect ? 'Ayy! Correct!': 'WRONG',
                            style: new TextStyle(color: Colors.white, fontSize: 60.0)
                        )
                    ],
                )
            )
        );
    }

}
