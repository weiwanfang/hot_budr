import './question.dart';

class Quiz{
    List<Question> _questions;
    int _currentQuestionIndex = -1;
    int _score = 0;

    Quiz(this._questions){
        _questions.shuffle();
    } // constructor

    int get score => _score;
    int get length => _questions.length;
    int get question_number => _currentQuestionIndex+1;
    List<Question> get questions => _questions;

    Question get nextQuestion{
        _currentQuestionIndex++;
        if (_currentQuestionIndex >= length) {
            _questions.shuffle();
            // return null;
        }
        return _questions[_currentQuestionIndex%length];
    }

    void answer(bool isCorrect){
        if (isCorrect) _score++;
    }


}
