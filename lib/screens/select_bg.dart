import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:riddle/audio_manager.dart';
import 'package:riddle/screens/difficulty.dart';
import 'package:riddle/screens/home.dart';
import 'package:riddle/vibration_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

class SelectBg extends StatefulWidget {
  const SelectBg({super.key});

  @override
  State<SelectBg> createState() => _SelectBgState();
}

class _SelectBgState extends State<SelectBg> {
  final AudioManager audioManager = AudioManager();
  int coins = 10;
  late SharedPreferences prefs;
  List<bool> purchasedBackgrounds = [true, false, false, false];
  final List<int> backgroundCosts = [0, 500, 1000, 1500];

  Future<void> loadPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      coins = prefs.getInt('balance') ?? 10;
      for (int i = 1; i < purchasedBackgrounds.length; i++) {
        purchasedBackgrounds[i] = prefs.getBool('bgPurchased$i') ?? false;
      }
    });
  }

  Future<void> savePreferences() async {
    await prefs.setInt('balance', coins);
    for (int i = 1; i < purchasedBackgrounds.length; i++) {
      await prefs.setBool('bgPurchased$i', purchasedBackgrounds[i]);
    }
  }

  void purchaseBackground(int index) {
    if (coins >= backgroundCosts[index]) {
      setState(() {
        coins -= backgroundCosts[index];
        purchasedBackgrounds[index] = true;
      });
      savePreferences();
    } else {
      audioManager.playClickSound();
    }
  }

  void showPurchaseDialog(int index) {
    audioManager.playClickSound();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Container(
              width: 300,
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
                    Text(
                      "Open a new location?\nfor ${backgroundCosts[index]} points?",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            purchaseBackground(index);
                            Navigator.of(context).pop();
                          },
                          child: Image.asset('assets/images/done.png',
                              fit: BoxFit.cover),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Image.asset('assets/images/close.png',
                              fit: BoxFit.cover),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }

  void handleBackgroundClick(int index) {
    if (purchasedBackgrounds[index]) {
      String assetPath = 'assets/images/bg${index + 1}.png';
      difficulty(assetPath);
    } else {
      showPurchaseDialog(index);
    }
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

  void difficulty(String image) {
    audioManager.playClickSound();
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            child: Difficulty(bgPath: image),
            type: PageTransitionType.leftToRight,
            duration: const Duration(milliseconds: 800)),
        (route) => false);
  }

  @override
  void initState() {
    super.initState();
    loadPreferences();
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
                Image.asset('assets/images/selectTitle.png', fit: BoxFit.cover),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < 2; i++)
                      GestureDetector(
                        onTap: () {
                          if (vibrationSettings.isVibrationEnabled) {
                            Vibration.hasVibrator().then((hasVibrator) {
                              if (hasVibrator == true) {
                                Vibration.vibrate(duration: 50);
                              }
                            });
                          }
                          handleBackgroundClick(i);
                        },
                        child: Container(
                          width: 200,
                          height: 100,
                          margin: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/bg${i + 1}.png'),
                              fit: BoxFit.fill,
                            ),
                            border: purchasedBackgrounds[i]
                                ? Border.all(
                                    color: Colors.yellow,
                                    width: 2.0,
                                  )
                                : null,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 2; i < 4; i++)
                      GestureDetector(
                        onTap: () {
                          if (vibrationSettings.isVibrationEnabled) {
                            Vibration.hasVibrator().then((hasVibrator) {
                              if (hasVibrator == true) {
                                Vibration.vibrate(duration: 50);
                              }
                            });
                          }
                          handleBackgroundClick(i);
                        },
                        child: Container(
                          width: 200,
                          height: 100,
                          margin: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/bg${i + 1}.png'),
                              fit: BoxFit.fill,
                            ),
                            border: purchasedBackgrounds[i]
                                ? Border.all(
                                    color: Colors.pink,
                                    width: 4.0,
                                  )
                                : null,
                          ),
                        ),
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
