import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:riddle/audio_manager.dart';
import 'package:riddle/game/easy.dart';
import 'package:riddle/game/extreme.dart';
import 'package:riddle/game/hard.dart';
import 'package:riddle/game/medium.dart';
import 'package:riddle/game/profy.dart';
import 'package:riddle/game/real.dart';
import 'package:riddle/screens/select_bg.dart';
import 'package:riddle/vibration_manager.dart';
import 'package:vibration/vibration.dart';

class Difficulty extends StatefulWidget {
  final String bgPath;

  const Difficulty({super.key, required this.bgPath});

  @override
  State<Difficulty> createState() => _DifficultyState();
}

class _DifficultyState extends State<Difficulty> {
  final AudioManager audioManager = AudioManager();

  void background() {
    audioManager.playClickSound();
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            child: const SelectBg(),
            type: PageTransitionType.leftToRight,
            duration: const Duration(milliseconds: 800)),
        (route) => false);
  }

  void easy() {
    audioManager.playClickSound();
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            child: Easy(image: widget.bgPath),
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 800)),
        (route) => false);
  }

  void medium() {
    audioManager.playClickSound();
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            child: Medium(image: widget.bgPath),
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 800)),
        (route) => false);
  }

  void hard() {
    audioManager.playClickSound();
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            child: Hard(image: widget.bgPath),
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 800)),
        (route) => false);
  }

  void extreme() {
    audioManager.playClickSound();
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            child: Extreme(image: widget.bgPath),
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 800)),
        (route) => false);
  }

  void profy() {
    audioManager.playClickSound();
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            child: Profy(image: widget.bgPath),
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 800)),
        (route) => false);
  }

  void real() {
    audioManager.playClickSound();
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            child: Real(image: widget.bgPath),
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 800)),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final vibrationSettings = Provider.of<VibrationSettings>(context);
    return PopScope(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg1.png'),
                  fit: BoxFit.fill)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 40.0),
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
                          background();
                        },
                        child: Image.asset('assets/images/close.png',
                            fit: BoxFit.cover),
                      ),
                    ],
                  ),
                ),
                Image.asset('assets/images/levelTitle.png', fit: BoxFit.cover),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            easy();
                          },
                          child: Image.asset('assets/images/easy.png',
                              fit: BoxFit.cover),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        GestureDetector(
                          onTap: () {
                            if (vibrationSettings.isVibrationEnabled) {
                              Vibration.hasVibrator().then((hasVibrator) {
                                if (hasVibrator == true) {
                                  Vibration.vibrate(duration: 50);
                                }
                              });
                            }
                            medium();
                          },
                          child: Image.asset('assets/images/middle.png',
                              fit: BoxFit.cover),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        GestureDetector(
                          onTap: () {
                            if (vibrationSettings.isVibrationEnabled) {
                              Vibration.hasVibrator().then((hasVibrator) {
                                if (hasVibrator == true) {
                                  Vibration.vibrate(duration: 50);
                                }
                              });
                            }
                            hard();
                          },
                          child: Image.asset('assets/images/hard.png',
                              fit: BoxFit.cover),
                        ),
                      ],
                    ),
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
                            extreme();
                          },
                          child: Container(
                            width: 170,
                            height: 45,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/tab3.png'),
                                    fit: BoxFit.fill)),
                            child: const Center(
                              child: Text('SAKURA',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        GestureDetector(
                          onTap: () {
                            if (vibrationSettings.isVibrationEnabled) {
                              Vibration.hasVibrator().then((hasVibrator) {
                                if (hasVibrator == true) {
                                  Vibration.vibrate(duration: 50);
                                }
                              });
                            }
                            profy();
                          },
                          child: Container(
                            width: 170,
                            height: 45,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/tab3.png'),
                                    fit: BoxFit.fill)),
                            child: const Center(
                              child: Text('NINJA',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        GestureDetector(
                          onTap: () {
                            if (vibrationSettings.isVibrationEnabled) {
                              Vibration.hasVibrator().then((hasVibrator) {
                                if (hasVibrator == true) {
                                  Vibration.vibrate(duration: 50);
                                }
                              });
                            }
                            real();
                          },
                          child: Container(
                            width: 170,
                            height: 45,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/tab3.png'),
                                    fit: BoxFit.fill)),
                            child: const Center(
                              child: Text('SAMURAI',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Lottie.asset('assets/raw/arrow.json',
                      fit: BoxFit.cover,
                      frameRate: FrameRate.max,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
