import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:riddle/audio_manager.dart';
import 'package:riddle/screens/home.dart';
import 'package:riddle/vibration_manager.dart';
import 'package:vibration/vibration.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  final AudioManager audioManager = AudioManager();

  void home() {
    audioManager.playClickSound();
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            child: const Home(),
            type: PageTransitionType.rightToLeft,
            duration: const Duration(milliseconds: 800)),
        (route) => false);
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
                width: 420,
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.deepOrangeAccent.shade200,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.brown, width: 3.0)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('1.0:',
                              style: TextStyle(
                                  color: Colors.white54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0)),
                          Text(' Release, 2 gameplays',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0)),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('1.1:',
                              style: TextStyle(
                                  color: Colors.white54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0)),
                          Text(' Push notifications, daily rewards',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
