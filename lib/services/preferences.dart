import 'package:shared_preferences/shared_preferences.dart';

class Preferences {

  static final Preferences _instance = Preferences._internal();
  Preferences._internal();
  factory Preferences() => _instance;
  static Preferences get instance => _instance;

  late SharedPreferences prefs;

  init() async {
    prefs = await SharedPreferences.getInstance(); 
  }

  bool getShowSubtitles() {
    return prefs.getBool('showSubtitles') ?? false;
  }

  setShowSubtitles(bool value) {
    prefs.setBool('showSubtitles', value);
  }
}