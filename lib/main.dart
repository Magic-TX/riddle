import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:riddle/screens/start.dart';
import 'package:riddle/vibration_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
  OneSignal.initialize("9cdbc227-67a1-4829-baa6-c04972da3978");
  OneSignal.Notifications.requestPermission(true);
  runApp(
      MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => VibrationSettings()),
    ],
    child: const Game(),
  ));
}

class Game extends StatelessWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Start(),
    );
  }
}
