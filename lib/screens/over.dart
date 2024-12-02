import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:riddle/audio_manager.dart';
import 'package:riddle/screens/home.dart';

class Over extends StatefulWidget {
  const Over({super.key});

  @override
  State<Over> createState() => _OverState();
}

class _OverState extends State<Over> {
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
                    top: -35,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      'assets/images/time.png',
                      fit: BoxFit.contain,
                      height: 80,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50),
                        Image.asset(
                          'assets/images/overTitle.png',
                          fit: BoxFit.contain,
                          height: 80,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: -10,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: home,
                      child: Image.asset(
                        'assets/images/menu.png',
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
