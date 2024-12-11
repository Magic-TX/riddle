import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:riddle/audio_manager.dart';
import 'package:riddle/screens/game.dart';
import 'package:riddle/screens/help.dart';
import 'package:riddle/screens/news.dart';
import 'package:riddle/screens/reward.dart';
import 'package:riddle/screens/select_bg.dart';
import 'package:riddle/screens/settings.dart';
import 'package:riddle/vibration_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AudioManager audioManager = AudioManager();
  bool isActive = false;
  Duration remainingTime = Duration.zero;

  Future<void> updateRemainingTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? lastPressedTime = prefs.getInt('lastPressedTime');
    if (lastPressedTime != null) {
      DateTime lastPressedDateTime =
          DateTime.fromMillisecondsSinceEpoch(lastPressedTime);
      DateTime now = DateTime.now();
      Duration difference =
          lastPressedDateTime.add(const Duration(hours: 24)).difference(now);
      if (difference.isNegative) {
        setState(() {
          remainingTime = Duration.zero;
          isActive = true;
        });
      } else {
        setState(() {
          remainingTime = difference;
          isActive = false;
        });
      }
    } else {
      setState(() {
        remainingTime = Duration.zero;
        isActive = true;
      });
    }
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime == Duration.zero && isActive) {
        timer.cancel();
      } else {
        updateRemainingTime();
      }
    });
  }

  void settings() {
    audioManager.playClickSound();
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            child: const Settings(),
            type: PageTransitionType.rightToLeft,
            duration: const Duration(milliseconds: 800)),
        (route) => false);
  }

  void help() {
    audioManager.playClickSound();
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            child: const Help(),
            type: PageTransitionType.rightToLeft,
            duration: const Duration(milliseconds: 800)),
        (route) => false);
  }

  void background() {
    audioManager.playClickSound();
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            child: const SelectBg(),
            type: PageTransitionType.topToBottom,
            duration: const Duration(milliseconds: 800)),
        (route) => false);
  }

  void game() {
    audioManager.playClickSound();
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            child: const Games(),
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 1000)),
        (route) => false);
  }

  void news() {
    audioManager.playClickSound();
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            child: const News(),
            type: PageTransitionType.leftToRight,
            duration: const Duration(milliseconds: 1000)),
        (route) => false);
  }

  void reward() {
    audioManager.playClickSound();
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            child: const Reward(),
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 1000)),
        (route) => false);
  }

  Future<void> checkButtonStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? lastPressedTime = prefs.getInt('lastPressedTime');

    if (lastPressedTime == null) {
      setState(() {
        isActive = true;
      });
    } else {
      DateTime lastPressedDateTime =
          DateTime.fromMillisecondsSinceEpoch(lastPressedTime);
      DateTime now = DateTime.now();
      if (now.difference(lastPressedDateTime).inHours >= 24) {
        setState(() {
          isActive = true;
        });
      } else {
        setState(() {
          isActive = false;
        });
      }
    }
  }

  Future<void> dayReward() async {
    if (!isActive) return;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
        'lastPressedTime', DateTime.now().millisecondsSinceEpoch);
    setState(() {
      isActive = false;
    });
  }

  @override
  void initState() {
    super.initState();
    audioManager.init();
    checkButtonStatus();
    updateRemainingTime();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final vibrationSettings = Provider.of<VibrationSettings>(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bg1.png'), fit: BoxFit.fill)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 40.0, left: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                            news();
                          },
                          child: Lottie.asset('assets/raw/new.json',
                              fit: BoxFit.cover,
                              frameRate: FrameRate.max,
                              height: 80),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: isActive
                                ? () {
                                    if (vibrationSettings.isVibrationEnabled) {
                                      Vibration.hasVibrator()
                                          .then((hasVibrator) {
                                        if (hasVibrator == true) {
                                          Vibration.vibrate(duration: 50);
                                        }
                                      });
                                    }
                                    reward();
                                    dayReward();
                                  }
                                : null,
                            child: Opacity(
                              opacity: isActive ? 1.0 : 0.7,
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.deepOrange,
                                    borderRadius: BorderRadius.circular(12.0),
                                    border: Border.all(
                                        width: 2.0, color: Colors.brown)),
                                child: const Center(
                                  child: Icon(Icons.add_business_outlined,
                                      color: Colors.white, size: 32),
                                ),
                              ),
                            )),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        if (!isActive)
                          Text(
                            "${remainingTime.inHours.toString().padLeft(2, '0')}:${(remainingTime.inMinutes % 60).toString().padLeft(2, '0')}:${(remainingTime.inSeconds % 60).toString().padLeft(2, '0')}",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (vibrationSettings.isVibrationEnabled) {
                    Vibration.hasVibrator().then((hasVibrator) {
                      if (hasVibrator == true) {
                        Vibration.vibrate(duration: 50);
                      }
                    });
                  }
                  background();
                },
                child: Image.asset('assets/images/play.png', fit: BoxFit.cover),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                      settings();
                    },
                    child: Image.asset('assets/images/settings.png',
                        fit: BoxFit.cover),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  GestureDetector(
                    onTap: () {
                      if (vibrationSettings.isVibrationEnabled) {
                        Vibration.hasVibrator().then((hasVibrator) {
                          if (hasVibrator == true) {
                            Vibration.vibrate(duration: 50);
                          }
                        });
                      }
                      help();
                    },
                    child: Image.asset('assets/images/tutorial.png',
                        fit: BoxFit.cover),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  GestureDetector(
                    onTap: () {
                      if (vibrationSettings.isVibrationEnabled) {
                        Vibration.hasVibrator().then((hasVibrator) {
                          if (hasVibrator == true) {
                            Vibration.vibrate(duration: 50);
                          }
                        });
                      }
                      game();
                    },
                    child: Lottie.asset('assets/raw/bonus.json',
                        fit: BoxFit.cover,
                        frameRate: FrameRate.max,
                        height: 80),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
