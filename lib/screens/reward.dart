import 'dart:math';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:riddle/audio_manager.dart';
import 'package:riddle/screens/home.dart';
import 'package:riddle/vibration_manager.dart';
import 'package:scratcher/scratcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

class Reward extends StatefulWidget {
  const Reward({super.key});

  @override
  State<Reward> createState() => _RewardState();
}

class _RewardState extends State<Reward> {
  final AudioManager audioManager = AudioManager();
  final Random _random = Random();
  late SharedPreferences prefs;
  int coins = 0;
  List<int> rewards = [];
  List<bool> revealed = List.filled(6, false);

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  Future<void> _initializeGame() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      coins = prefs.getInt('balance') ?? 0;
      rewards = List.generate(6, (_) => 10 + _random.nextInt(91));
    });
  }

  void _addCoins(int reward, int index) {
    setState(() {
      coins += reward;
      revealed[index] = true;
    });
    prefs.setInt('balance', coins);
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
                padding: const EdgeInsets.only(right: 40.0, left: 40.0, top: 20.0),
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
              SizedBox(
                width: 400,
                height: 360,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 6,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                  ),
                  itemBuilder: (context, index) {
                    return revealed[index]
                        ? Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          '+${rewards[index]}',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                        : Scratcher(
                      brushSize: 50,
                      threshold: 50,
                      color: Colors.grey.shade300,
                      onThreshold: () => _addCoins(rewards[index], index),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const Center(
                          child: Text(
                            'Reward',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
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
