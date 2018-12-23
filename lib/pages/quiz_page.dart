import 'package:flutter/material.dart';

// import '../utils/question.dart';
import '../utils/image.dart';
// import '../utils/quiz.dart';
import '../utils/img_quiz.dart';

import '../UI/answer_button.dart';
// import '../UI/question_text.dart';
import '../UI/image_feed.dart';
import '../UI/right_or_wrong_overlay.dart';
import '../UI/timer.dart';

import '../pages/score_page.dart';

class QuizPage extends StatefulWidget {
    @override
    State createState() => new QuizPageState();
}

class QuizPageState extends State<QuizPage> {

    ImageData currQuestion;
    ImageQuiz quiz = new ImageQuiz([
        // Hot budr
        ImageData('./images/hot_budr/1.png', true),
        ImageData('./images/hot_budr/2.png', true),
        ImageData('./images/hot_budr/3.png', true),
        ImageData('./images/hot_budr/4.png', true),
        ImageData('./images/hot_budr/5.png', true),
        ImageData('./images/hot_budr/6.png', true),
        ImageData('./images/hot_budr/7.png', true),
        ImageData('./images/hot_budr/8.png', true),
        ImageData('./images/hot_budr/9.png', true),
        ImageData('./images/hot_budr/10.png', true),
        ImageData('./images/hot_budr/11.png', true),
        ImageData('./images/hot_budr/12.png', true),
        ImageData('./images/hot_budr/13.png', true),

        // Not budr
        ImageData('./images/not_budr/01.png', false),
        ImageData('./images/not_budr/02.png', false),
        ImageData('./images/not_budr/03.png', false),
        ImageData('./images/not_budr/04.png', false),
        ImageData('./images/not_budr/05.png', false),
        ImageData('./images/not_budr/06.png', false),
        ImageData('./images/not_budr/07.png', false),
    ]);
    String questionText;
    int questionNum;
    bool isCorrect;

    @override
    void initState(){
        super.initState();
        currQuestion = quiz.nextQuestion;
        questionText = currQuestion.link;
        questionNum = quiz.image_number;
    }

    bool overlayOn = false;

    void handleAnswer(bool answer){
        isCorrect = (currQuestion.answer == answer);
        quiz.answer(isCorrect);
        this.setState(() {
            overlayOn = true;
        });
    }


    @override
    Widget build(BuildContext context) {
        return new WillPopScope(
            onWillPop: () async => false,
            child: new Stack(
                fit: StackFit.expand,
                children: <Widget>[
                    new Column(
                        children: <Widget>[
                            new AnswerButton(true, () => handleAnswer(true)),
                            new AnswerButton(false, () => handleAnswer(false))
                        ]
                    ), // Column

                    // Images
                    new IgnorePointer(
                        child: new ImageFeed(questionText, questionNum)
                    ),


                    new IgnorePointer(
                        child: new SafeArea(
                            child: new TimerUI(() => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new ScorePage(quiz.score)))),
                        )
                    ),



                    overlayOn ? new RightOrWrongOverlay(
                        isCorrect,
                        () {
                                currQuestion = quiz.nextQuestion;
                                this.setState(() {
                                    overlayOn = false;
                                    questionText = currQuestion.link;
                                    questionNum = quiz.image_number;

                                });
                            }
                    ) : new Container()
                ], // <widget>[]
            ) //stack
        );
    }
}
