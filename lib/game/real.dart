import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:riddle/data/word2.dart';
import 'package:riddle/screens/over.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Real extends StatefulWidget {
  final String image;

  const Real({super.key, required this.image});

  @override
  State<Real> createState() => _RealState();
}

class _RealState extends State<Real> {
  int coins = 0;
  late SharedPreferences prefs;
  int countdown = 40;
  Timer? timer;
  bool hintUsed = false;

  WordDescription2 currentWord = wordsList[0];
  List<String> selectedLetters = [];

  Future<void> loadPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      coins = prefs.getInt('balance') ?? 0;
    });
  }

  void startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        setState(() {
          countdown--;
        });
      } else {
        timer.cancel();
        onCountdownComplete();
      }
    });
  }

  void onCountdownComplete() {
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            child: const Over(),
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 800)),
            (route) => false);
  }

  @override
  void initState() {
    super.initState();
    loadPreferences();
    selectedLetters = List.filled(currentWord.word.length, '');
    startCountdown();
  }

  void nextWord() {
    setState(() {
      currentWord = wordsList[Random().nextInt(wordsList.length)];
      selectedLetters = List.filled(currentWord.word.length, '');
    });
  }

  void checkWord() async {
    if (selectedLetters.join() == currentWord.word.toUpperCase()) {
      setState(() {
        coins += 50;
        countdown += 15;
        nextWord();
      });
      await prefs.setInt('balance', coins);
    }
  }

  void selectLetter(int index) {
    for (int i = 0; i < selectedLetters.length; i++) {
      if (selectedLetters[i] == '') {
        setState(() {
          selectedLetters[i] = currentWord.letters[index];
          currentWord.letters[index] = '';
        });
        break;
      }
    }
  }

  void resetLetter(int index) {
    setState(() {
      currentWord.letters[currentWord.letters.indexOf('')] =
      selectedLetters[index];
      selectedLetters[index] = '';
    });
  }

  void useHint() {
    if (coins >= 100 && !hintUsed) {
      setState(() {
        hintUsed = true;
        coins -= 100;
        prefs.setInt('balance', coins);

        for (int i = 0; i < selectedLetters.length; i++) {
          if (selectedLetters[i] == '') {
            setState(() {
              selectedLetters[i] = currentWord.word[i].toUpperCase();
            });
            break;
          }
        }
      });
    } else if (hintUsed) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
            backgroundColor: Colors.transparent,
            content: Container(
              width: 340,
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/tab2.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "WARNING!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    const Text(
                      "you have already used the hint",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Image.asset('assets/images/done.png',
                          fit: BoxFit.cover),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  ],
                ),
              ),
            )),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
            backgroundColor: Colors.transparent,
            content: Container(
              width: 340,
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/tab2.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Use the hint?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    const Text(
                      "You need 100 paws\n to use the hint.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Image.asset('assets/images/done.png',
                          fit: BoxFit.cover),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  ],
                ),
              ),
            )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(widget.image), fit: BoxFit.fill)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 140,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(24.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/coin.png',
                                    fit: BoxFit.cover, height: 40),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(coins.toString(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 140,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(24.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/time.png',
                                    fit: BoxFit.cover, height: 40),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('00:$countdown',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
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
                            height: MediaQuery.of(context).size.height * 0.04),
                        Text(
                          currentWord.description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 60.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: checkWord,
                        child: Image.asset('assets/images/done.png',
                            fit: BoxFit.cover),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.height * 0.04),
                      GestureDetector(
                        onTap: useHint,
                        child: Image.asset('assets/images/hint.png',
                            fit: BoxFit.cover),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(selectedLetters.length, (index) {
                    return GestureDetector(
                      onTap: selectedLetters[index] != ''
                          ? () => resetLetter(index)
                          : null,
                      child: Container(
                        margin: const EdgeInsets.all(4.0),
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              selectedLetters[index] != ''
                                  ? 'assets/images/word.png'
                                  : 'assets/images/word.png',
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Text(
                          selectedLetters[index],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  alignment: WrapAlignment.center,
                  children: List.generate(currentWord.letters.length, (index) {
                    return GestureDetector(
                      onTap: currentWord.letters[index] != ''
                          ? () => selectLetter(index)
                          : null,
                      child: Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              currentWord.letters[index] != ''
                                  ? 'assets/images/wordNo.png'
                                  : 'assets/images/wordYes.png',
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Text(
                          currentWord.letters[index],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange.shade900,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
