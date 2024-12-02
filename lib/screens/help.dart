import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:riddle/audio_manager.dart';
import 'package:riddle/screens/home.dart';
import 'package:riddle/vibration_manager.dart';
import 'package:vibration/vibration.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  final AudioManager audioManager = AudioManager();

  void home() {
    audioManager.playClickSound();
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            child: const Home(),
            type: PageTransitionType.bottomToTop,
            duration: const Duration(milliseconds: 800)),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final vibrationSettings = Provider.of<VibrationSettings>(context);
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg1.png'),
                  fit: BoxFit.fill)),
          child: Center(
            child: Container(
              width: 340,
              height: 240,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/tab2.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -20,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      'assets/images/infoTitle.png',
                      fit: BoxFit.contain,
                      height: 80,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 50),
                        Text(
                          "Guess all the\nspeed words.\nEven faster, more points",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: -10,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
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
                      child: Image.asset(
                        'assets/images/close.png',
                        fit: BoxFit.contain,
                        alignment: Alignment.bottomCenter,
                        height: 50,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
