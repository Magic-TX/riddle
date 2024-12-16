import 'dart:async';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:riddle/screens/home.dart';
import 'package:riddle/screens/rules.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  String rewardUser = '';

  Future<void> checkReward() async {
    final reward = FirebaseRemoteConfig.instance;
    await reward.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 5),
      minimumFetchInterval: const Duration(hours: 5),
    ));

    await reward.setDefaults(const {
      "daily": "",
    });

    await reward.fetchAndActivate();

    rewardUser = reward.getString("daily");
    await sReward();
    if (rewardUser != '') {
      gW();
    } else {
      startLoading();
      sReward();
    }
  }

  Future<void> sReward() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('reward', rewardUser.toString());
  }

  void gW() {
    Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute(
        builder: (context) => PP(url: rewardUser),
      ),
          (route) => false,
    );
  }

  void startLoading() async {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
              child: const Home(),
              type: PageTransitionType.leftToRight,
              duration: const Duration(milliseconds: 800)),
              (route) => false);
      timer.cancel();
    });
  }

  Future<void> checkFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFL = prefs.getBool('isFL') ?? true;
    if (isFL) {
      await checkReward();
      await prefs.setBool('isFL', false);
    } else {
      startLoading();
    }
  }

  @override
  void initState() {
    super.initState();
    checkFirstLaunch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bg1.png'), fit: BoxFit.fill)),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', fit: BoxFit.cover),
            Lottie.asset('assets/raw/loading.json',
                fit: BoxFit.cover, frameRate: FrameRate.max, height: 80)
          ],
        )),
      ),
    );
  }
}
