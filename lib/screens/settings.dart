import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:riddle/audio_manager.dart';
import 'package:riddle/screens/home.dart';
import 'package:riddle/vibration_manager.dart';
import 'package:vibration/vibration.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final AudioManager audioManager = AudioManager();
  double clickVolume = 0.5;
  double backgroundVolume = 0.5;

  @override
  void initState() {
    super.initState();
    audioManager.init().then((_) {
      setState(() {
        clickVolume = audioManager.clickVolume;
        backgroundVolume = audioManager.backgroundVolume;
      });
    });
  }

  void home() {
    audioManager.playClickSound();
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            child: const Home(),
            type: PageTransitionType.leftToRight,
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
          child: Container(
            color: Colors.black45,
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
                            home();
                          },
                          child: Image.asset('assets/images/close.png',
                              fit: BoxFit.cover),
                        ),
                      ],
                    ),
                  ),
                  Image.asset('assets/images/options.png', fit: BoxFit.cover),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("MUSIC",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Slider(
                        value: backgroundVolume,
                        thumbColor: Colors.black,
                        activeColor: Colors.black,
                        inactiveColor: Colors.black45,
                        onChanged: (value) {
                          setState(() {
                            backgroundVolume = value;
                            audioManager.setBackgroundVolume(backgroundVolume);
                          });
                        },
                        min: 0.0,
                        max: 1.0,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("SOUND",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Slider(
                        value: clickVolume,
                        thumbColor: Colors.black,
                        activeColor: Colors.black,
                        inactiveColor: Colors.black45,
                        onChanged: (value) {
                          setState(() {
                            clickVolume = value;
                            audioManager.setClickVolume(clickVolume);
                          });
                        },
                        min: 0.0,
                        max: 1.0,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("VIBRATION",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                      Switch(
                        value: vibrationSettings.isVibrationEnabled,
                        onChanged: (value) {
                          vibrationSettings.setVibration(value);
                        },
                        activeColor: Colors.black,
                        inactiveThumbColor: Colors.black,
                        inactiveTrackColor: Colors.black45,
                      ),
                    ],
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
