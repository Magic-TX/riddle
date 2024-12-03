import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:riddle/audio_manager.dart';
import 'package:riddle/screens/end.dart';
import 'package:riddle/screens/home.dart';
import 'package:riddle/screens/win.dart';
import 'package:riddle/vibration_manager.dart';
import 'package:vibration/vibration.dart';

class Games extends StatefulWidget {
  const Games({super.key});

  @override
  State<Games> createState() => _GamesState();
}

class _GamesState extends State<Games> {
  final AudioManager audioManager = AudioManager();

  int currentQuestionIndex = 0;
  int lives = 3;
  int? selectedOption;
  bool isAnswered = false;

  final List<Map<String, dynamic>> questions = [
    {
      "question": "Which mountain is the highest in Asia?",
      "options": ["Elbrus", "Kilimanjaro", "Everest", "Fuji"],
      "correctAnswer": 2
    },
    {
      "question": "Which animal is the symbol of China?",
      "options": ["Tiger", "Panda", "Elephant", "Lion"],
      "correctAnswer": 1
    },
    {
      "question": "What is the largest desert in Asia?",
      "options": ["Sahara", "Gobi", "Thar", "Karakum"],
      "correctAnswer": 1
    },
    {
      "question": "Which is the longest river in Asia?",
      "options": ["Yangtze", "Mekong", "Ganges", "Indus"],
      "correctAnswer": 0
    },
    {
      "question": "Which Asian country is known as the Land of the Rising Sun?",
      "options": ["China", "Japan", "South Korea", "Thailand"],
      "correctAnswer": 1
    },
    {
      "question": "What is the capital of South Korea?",
      "options": ["Seoul", "Tokyo", "Bangkok", "Hanoi"],
      "correctAnswer": 0
    },
    {
      "question": "Which Asian country is famous for the Great Wall?",
      "options": ["India", "China", "Mongolia", "Japan"],
      "correctAnswer": 1
    },
    {
      "question":
          "Which festival is celebrated as the Festival of Lights in India?",
      "options": ["Holi", "Diwali", "Eid", "Vesak"],
      "correctAnswer": 1
    },
    {
      "question": "What is the primary religion of Thailand?",
      "options": ["Islam", "Hinduism", "Buddhism", "Christianity"],
      "correctAnswer": 2
    },
    {
      "question":
          "Which Asian country is the world's largest producer of rice?",
      "options": ["India", "Vietnam", "China", "Indonesia"],
      "correctAnswer": 2
    },
    {
      "question": "Which city is known as the Pearl of the Orient in Asia?",
      "options": ["Bangkok", "Manila", "Hong Kong", "Singapore"],
      "correctAnswer": 2
    },
    {
      "question": "What is the traditional Japanese garment called?",
      "options": ["Kimono", "Sari", "Hanbok", "Ao Dai"],
      "correctAnswer": 0
    },
    {
      "question": "Which Asian country has the most islands?",
      "options": ["Indonesia", "Japan", "Philippines", "Malaysia"],
      "correctAnswer": 0
    },
    {
      "question": "Which is the highest plateau in Asia?",
      "options": [
        "Tibetan Plateau",
        "Deccan Plateau",
        "Altai Plateau",
        "Mongolian Plateau"
      ],
      "correctAnswer": 0
    },
    {
      "question": "Which Asian country is famous for its tea culture?",
      "options": ["India", "China", "Japan", "All of the above"],
      "correctAnswer": 3
    },
    {
      "question": "What is the capital of Vietnam?",
      "options": ["Hanoi", "Ho Chi Minh City", "Bangkok", "Phnom Penh"],
      "correctAnswer": 0
    },
    {
      "question": "What is the largest lake in Asia?",
      "options": ["Lake Baikal", "Caspian Sea", "Lake Balkhash", "Aral Sea"],
      "correctAnswer": 1
    },
    {
      "question": "Which Asian country is known for Mount Fuji?",
      "options": ["China", "Japan", "Nepal", "South Korea"],
      "correctAnswer": 1
    },
    {
      "question": "Which Asian country hosted the 2008 Summer Olympics?",
      "options": ["South Korea", "Japan", "China", "India"],
      "correctAnswer": 2
    },
    {
      "question": "What is the main language spoken in Iran?",
      "options": ["Arabic", "Turkish", "Persian", "Kurdish"],
      "correctAnswer": 2
    }
  ];

  void handleAnswer(int selectedIndex) {
    if (isAnswered) return;
    setState(() {
      selectedOption = selectedIndex;
      isAnswered = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (questions[currentQuestionIndex]["correctAnswer"] == selectedIndex) {
        setState(() {
          currentQuestionIndex++;
          isAnswered = false;
          selectedOption = null;
        });

        if (currentQuestionIndex >= questions.length) {
          Navigator.pushReplacement(
            context,
            PageTransition(
              child: const Win(),
              type: PageTransitionType.fade,
            ),
          );
        }
      } else {
        setState(() {
          lives--;
          isAnswered = false;
        });

        if (lives <= 0) {
          Navigator.pushReplacement(
            context,
            PageTransition(
              child: const End(),
              type: PageTransitionType.fade,
            ),
          );
        }
      }
    });
  }

  void home() {
    audioManager.playClickSound();
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            child: const Home(),
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 1000)),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final vibrationSettings = Provider.of<VibrationSettings>(context);
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bg4.png'),
                    fit: BoxFit.fill)),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 40.0, top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (vibrationSettings.isVibrationEnabled) {
                            Vibration.hasVibrator().then((hasVibrator) {
                              if (hasVibrator == true) {
                                Vibration.vibrate(duration: 50);
                              }
                            });
                          }
                          home();
                        },
                        child: Image.asset('assets/images/close.png',
                            fit: BoxFit.cover),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  width: 600,
                  height: 120,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/tab1.png'),
                          fit: BoxFit.fill)),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        Text(
                          "Question: ${currentQuestionIndex + 1} / ${questions.length}",
                          style: const TextStyle(
                            fontFamily: 'Mogra',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange,
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        Text(
                          questions[currentQuestionIndex]["question"],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ...List.generate(
                      4,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedOption == null
                                ? Colors.deepOrangeAccent
                                : (selectedOption == index
                                    ? (questions[currentQuestionIndex]
                                                ["correctAnswer"] ==
                                            index
                                        ? Colors.green
                                        : Colors.red)
                                    : Colors.deepOrangeAccent),
                            foregroundColor: Colors.white,
                          ),
                          onPressed:
                              isAnswered ? null : () => handleAnswer(index),
                          child: Text(
                            questions[currentQuestionIndex]["options"][index],
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  width: 320,
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(color: Colors.white54, width: 2.0)),
                  child: Center(
                    child: Text(
                      "Attempts: $lives",
                      style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ))));
  }
}
