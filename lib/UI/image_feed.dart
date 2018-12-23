import 'package:flutter/material.dart';

class ImageFeed extends StatefulWidget {

    final String _link;
    final int _imgNum;

    ImageFeed(this._link, this._imgNum);

    @override
    State createState() => new ImageFeedState();
}

class ImageFeedState extends State<ImageFeed> with SingleTickerProviderStateMixin {

    Animation<double> _imageSizeAnimation; // 0, 0.1, 0.2, 0.3... 1
    AnimationController _imageSizeAnimationController;

    @override
    void initState(){
        super.initState();
        _imageSizeAnimationController = new AnimationController(duration: new Duration(milliseconds: 500), vsync: this);
        _imageSizeAnimation = new CurvedAnimation(parent: _imageSizeAnimationController, curve: Curves.bounceOut);
        _imageSizeAnimation.addListener(() => this.setState(() {})); //re-renders text everytime image sz changes
        _imageSizeAnimationController.forward();
    }

    @override
    void didUpdateWidget(ImageFeed oldWidget){
        super.didUpdateWidget(oldWidget);
        if (oldWidget._imgNum != widget._imgNum)
        {
            _imageSizeAnimationController.reset();
            _imageSizeAnimationController.forward();
        }
    }

    @override
    Widget build(BuildContext context) {
        return new ClipPath(
            child: new Container(
                alignment: Alignment.center,

                child: new Image.asset(
                        widget._link,
                        height: _imageSizeAnimation.value * 180,
                        fit: BoxFit.cover
                ),

            )
        );

    }
}
