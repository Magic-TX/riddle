import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:riddle/audio_manager.dart';
import 'package:riddle/screens/game.dart';
import 'package:riddle/screens/help.dart';
import 'package:riddle/screens/select_bg.dart';
import 'package:riddle/screens/settings.dart';
import 'package:riddle/vibration_manager.dart';
import 'package:vibration/vibration.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AudioManager audioManager = AudioManager();

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

  @override
  void initState() {
    super.initState();
    audioManager.init();
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
