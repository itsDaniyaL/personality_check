import 'package:flutter/material.dart';
import 'package:personality_checker/models/question.dart';

class AppState extends ChangeNotifier {
  final List<Question> _questions = [
    Question(
      title:
          'You’re really busy at work and a colleague is telling you their life story and personal woes.\n\nYou:',
      options: {
        'Don’t dare to interrupt them': 'introvert',
        'Think it’s more important to give them some of your time; work can wait':
            'extrovert',
        'Listen, but with only with half an ear': 'introvert',
        'Interrupt and explain that you are really busy at the moment':
            'extrovert'
      },
    ),
    Question(
      title:
          'You’ve been sitting in the doctor’s waiting room for more than 25 minutes.\n\nYou:',
      options: {
        'Look at your watch every two minutes': 'introvert',
        'Bubble with inner anger, but keep quiet': 'introvert',
        'Explain to other equally impatient people in the room that the doctor is always running late':
            'extrovert',
        'Complain in a loud voice, while tapping your foot impatiently':
            'extrovert'
      },
    ),
    Question(
      title:
          'You’re having an animated discussion with a colleague regarding a project that you’re in charge of.\n\nYou:',
      options: {
        'Don’t dare contradict them': 'introvert',
        'Think that they are obviously right': 'introvert',
        'Defend your own point of view, tooth and nail': 'extrovert',
        'Continuously interrupt your colleague': 'extrovert'
      },
    ),
    Question(
      title: 'You are taking part in a guided tour of a museum.\n\nYou:',
      options: {
        'Are a bit too far towards the back so don’t really hear what the guide is saying':
            'introvert',
        'Follow the group without question': 'introvert',
        'Make sure that everyone is able to hear properly': 'extrovert',
        'Are right up the front, adding your own comments in a loud voice':
            'extrovert'
      },
    ),
    Question(
      title:
          'During dinner parties at your home, you have a hard time with people who:\n',
      options: {
        'Ask you to tell a story in front of everyone else': 'introvert',
        'Talk privately between themselves': 'introvert',
        'Hang around you all evening': 'extrovert',
        'Always drag the conversation back to themselves': 'extrovert'
      },
    ),
    Question(
      title:
          'You crack a joke at work, but nobody seems to have noticed.\n\nYou:',
      options: {
        'Think it’s for the best — it was a lame joke anyway': 'introvert',
        'Wait to share it with your friends after work': 'introvert',
        'Try again a bit later with one of your colleagues': 'extrovert',
        'Keep telling it until they pay attention': 'extrovert'
      },
    ),
    Question(
      title: 'This morning, your agenda seems to be free.\n\nYou:',
      options: {
        'Know that somebody will find a reason to come and bother you':
            'introvert',
        'Heave a sigh of relief and look forward to a day without stress':
            'introvert',
        'Question your colleagues about a project that’s been worrying you':
            'extrovert',
        'Pick up the phone and start filling up your agenda with meetings':
            'extrovert'
      },
    ),
    Question(
      title:
          'During dinner, the discussion moves to a subject about which you know nothing at all.\n\nYou:',
      options: {
        'Don’t dare show that you don’t know anything about the subject':
            'introvert',
        'Barely follow the discussion': 'introvert',
        'Ask lots of questions to learn more about it': 'extrovert',
        'Change the subject of discussion': 'extrovert'
      },
    ),
    Question(
      title:
          'You’re out with a group of friends and there’s a person who’s quite shy and doesn’t talk much.\n\nYou:',
      options: {
        'Notice that they’re alone, but don’t go over to talk with them':
            'introvert',
        'Go and have a chat with them': 'extrovert',
        'Shoot some friendly smiles in their direction': 'extrovert',
        'Hardly notice them at all': 'introvert'
      },
    ),
  ];

  int _currentQuestionIndex = 0;

  List<Question> get questions => _questions;

  int get currentQuestionIndex => _currentQuestionIndex;

  Question get currentQuestion => _questions[_currentQuestionIndex];

  // Select an answer for the current question
  void selectAnswer(int index) {
    _questions[_currentQuestionIndex].selectedOption = index;
    notifyListeners();
  }

  bool checkSelected() {
    return _questions[currentQuestionIndex].selectedOption == null;
  }

  // Move to the next question
  void nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      notifyListeners();
    }
  }

  // Move to the previous question
  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      notifyListeners();
    }
  }

  // Reset the quiz (optional)
  void reset() {
    _currentQuestionIndex = 0;
    for (var question in _questions) {
      question.selectedOption = -1;
    }
    notifyListeners();
  }

  // Check if this is the last question
  bool get isLastQuestion => _currentQuestionIndex == _questions.length - 1;

  // Return the progess to show for progress indicator
  double get progress {
    int answeredQuestions =
        _questions.where((q) => q.selectedOption != null).length;
    return answeredQuestions / _questions.length;
  }
}
