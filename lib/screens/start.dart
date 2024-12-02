import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:riddle/screens/home.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  void loading() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      timer.cancel();
      Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
              child: const Home(),
              type: PageTransitionType.rightToLeft,
              duration: const Duration(milliseconds: 800)),
          (route) => false);
    });
  }

  @override
  void initState() {
    super.initState();
    loading();
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
