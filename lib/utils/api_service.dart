import 'package:personality_checker/models/question.dart';

class ApiService {
  Future<List<Question>> fetchQuestions() async {
    await Future.delayed(const Duration(seconds: 5));
    return questions;
  }

  Future<String> fetchDescription(String personalityType) async {
    await Future.delayed(const Duration(milliseconds: 500));
    switch (personalityType) {
      case 'introvert':
        return introvertDescription;
      case 'extrovert':
        return extrovertDescription;
      case 'ambivert':
        return ambivertDescription;
      default:
        return "No description available";
    }
  }

  Future finalizePersonality(List<Question> questions) async {
    int introvertCount = 0;
    int extrovertCount = 0;

    for (var question in questions) {
      if (question.selectedOption != null) {
        final selectedOptionKey =
            question.options.keys.toList()[question.selectedOption!];
        final selectedOptionValue = question.options[selectedOptionKey];

        if (selectedOptionValue == 'introvert') {
          introvertCount++;
        } else if (selectedOptionValue == 'extrovert') {
          extrovertCount++;
        }
      }
    }

    if (introvertCount > extrovertCount) {
      return 'introvert';
    } else if (extrovertCount > introvertCount) {
      return 'extrovert';
    } else {
      return 'ambivert';
    }
  }

  final List<Question> questions = [
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
    Question(
      title: 'You can’t find your car keys.\n\nYou:',
      options: {
        'Don’t want anyone to find out, so you take the bus instead':
            'introvert',
        'Panic and search madly without asking anyone for help': 'introvert',
        'Grumble without telling your family why you’re in a bad mood':
            'introvert',
        'Accuse those around you for misplacing them': 'extrovert'
      },
    ),
  ];

  final introvertDescription =
      "You feel that living alone is to live happily, and you prefer hiding in a crowd rather than standing out in one. You are perpetually tormented by the idea of doing things wrong, not understanding or not being alert enough or intelligent enough to do what others expect of you. You lack in self-confidence and you seem to believe that others are better than you. While in a conversation, for example, you would be more likely to go along with the other’s points of view as you don’t fully respect your own opinions.";

  final extrovertDescription =
      "You thrive on being the center of attention and enjoy standing out in a crowd. You feel energized when interacting with others and are always eager to share your thoughts and ideas. You have a natural confidence in your abilities and rarely worry about making mistakes or falling short of others' expectations. You believe strongly in your own viewpoints and aren't afraid to express them, even if they differ from the majority. In conversations, you tend to lead, guiding discussions with enthusiasm and passion, and you find great satisfaction in inspiring or persuading others to see things your way.";

  final ambivertDescription =
      "You possess a balance of both introverted and extroverted traits. You are adaptable and can thrive in a variety of social situations, whether it involves solitude or interaction with others. Depending on the context, you may enjoy the company of others and seek out social engagement, while at other times, you value your personal space and need moments of quiet reflection. Ambiverts are comfortable navigating between the two extremes of social behaviour, finding energy from both solitude and interaction. Your versatility allows you to strike a balance, making you both approachable and introspective.";
}
