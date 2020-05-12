import 'package:shared_preferences/shared_preferences.dart';

Future<void> setHighScore(int score) async {
  SharedPreferences instance = await SharedPreferences.getInstance();
  final key = 'highScore';
  instance.setInt(key, score);
}

Future<int> getHighScore() async {
  SharedPreferences instance = await SharedPreferences.getInstance();
  final key = 'highScore';
  int value = instance.getInt(key) ?? 0;
  return value;
}
