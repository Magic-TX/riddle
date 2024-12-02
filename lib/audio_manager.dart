import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioManager {
  static final AudioManager _instance = AudioManager._internal();
  final AudioPlayer clickPlayer = AudioPlayer();
  final AudioPlayer backgroundPlayer = AudioPlayer();

  double clickVolume = 0.5;
  double backgroundVolume = 0.5;

  factory AudioManager() {
    return _instance;
  }

  AudioManager._internal();

  Future<void> init() async {
    await _loadVolumeSettings();
    await backgroundPlayer.setAsset('assets/audio/fon.wav');
    backgroundPlayer.setVolume(backgroundVolume);
    backgroundPlayer.setLoopMode(LoopMode.all);
    backgroundPlayer.play();
  }

  Future<void> playClickSound() async {
    await clickPlayer.setAsset('assets/audio/click.wav');
    clickPlayer.setVolume(clickVolume);
    clickPlayer.play();
  }

  void setClickVolume(double volume) {
    clickVolume = volume;
    clickPlayer.setVolume(clickVolume);
    _saveVolumeSettings();
  }

  void setBackgroundVolume(double volume) {
    backgroundVolume = volume;
    backgroundPlayer.setVolume(backgroundVolume);
    _saveVolumeSettings();
  }

  Future<void> _saveVolumeSettings() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('clickVolume', clickVolume);
    prefs.setDouble('backgroundVolume', backgroundVolume);
  }

  Future<void> _loadVolumeSettings() async {
    final prefs = await SharedPreferences.getInstance();
    clickVolume = prefs.getDouble('clickVolume') ?? 0.5;
    backgroundVolume = prefs.getDouble('backgroundVolume') ?? 0.5;
  }

  void dispose() {
    clickPlayer.dispose();
    backgroundPlayer.dispose();
  }
}
