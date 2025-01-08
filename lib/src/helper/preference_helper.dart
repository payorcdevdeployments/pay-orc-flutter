import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final SharedPreferences preferences;

  PreferencesHelper(this.preferences);

  // Keys
  static const String PREF_MERCHENT_KEY = "merchant_key";
  static const String PREF_MERCHENT_SECRET = "merchant_secret";

  // Getters and Setters
  String get merchantKey => preferences.getString(PREF_MERCHENT_KEY) ?? "";
  set merchantKey(String value) => preferences.setString(PREF_MERCHENT_KEY, value);

  String get merchantSecret => preferences.getString(PREF_MERCHENT_SECRET) ?? "";
  set merchantSecret(String value) => preferences.setString(PREF_MERCHENT_SECRET, value);

  Future<void> clear() async {
    await preferences.clear();
  }
}