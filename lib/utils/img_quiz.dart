import './image.dart';

class ImageQuiz{
    List<ImageData> _images;
    int _currentImageIndex = -1;
    int _score = 0;

    ImageQuiz(this._images){
        _images.shuffle();
    } // constructor

    int get score => _score;
    int get length => _images.length;
    int get image_number => _currentImageIndex+1;
    List<ImageData> get images => _images;

    ImageData get nextQuestion{
        _currentImageIndex++;
        if (_currentImageIndex >= length) {
            _images.shuffle();
            // return null;
        }
        return _images[_currentImageIndex % length];
    }

    void answer(bool isCorrect){
        if (isCorrect) {
            _score++;
        } else {
            if (_score > 1) _score = _score-2;
        }
    }


}
