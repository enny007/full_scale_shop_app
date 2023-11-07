import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(false) {
    _init();
  }

  late SharedPreferences prefs;

  Future<void> _init() async {
    prefs = await SharedPreferences.getInstance();
    final darkMode = prefs.getBool('DarkMode');
    state = darkMode ?? false;
  }

  void toggleTheme() async {
    state = !state;
    prefs.setBool('DarkMode', state);
  }

  
}

final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  return ThemeNotifier();
});
