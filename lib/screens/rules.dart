import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PP extends StatefulWidget {
  final String url;
  const PP({super.key, required this.url});

  @override
  State<PP> createState() => _PPState();
}

class _PPState extends State<PP> with WidgetsBindingObserver {
  static const platform = MethodChannel('com.riddle.paws/open');

  void check() async {
    try {
      setState(() {});
      final result = await platform.invokeMethod('open', {'url': widget.url});
    } on PlatformException catch (e) {
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        check();
      });
    });

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      check();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              LinearProgressIndicator(
                color: Colors.black,
                minHeight: 3.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
