import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:riddle/data/data.dart';
import 'package:riddle/reward_manager.dart';
import 'package:riddle/screens/rules.dart';
import 'package:riddle/screens/start.dart';
import 'package:riddle/vibration_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  OneSignal.initialize("9cdbc227-67a1-4829-baa6-c04972da3978");
  OneSignal.Notifications.requestPermission(true);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.ios,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => VibrationSettings()),
    ],
    child: Game(),
  ));
}

class Game extends StatelessWidget {
  late String l = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder<bool>(
            future: cL(),
            builder: (context, snapshot) {
              return l.isEmpty ? const Start() : PP(url: l.toString().trim());
            }));
  }

  Future<bool> cL() async {
    const plat = MethodChannel(GameData.m);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    l = prefs.getString('reward') ?? '';
    if (l.isNotEmpty) {
      try {
        final res = await plat.invokeMethod('open', {'url': l});
      } on PlatformException catch (e) {}
      return l.isNotEmpty;
    } else {
      return false;
    }
  }
}
