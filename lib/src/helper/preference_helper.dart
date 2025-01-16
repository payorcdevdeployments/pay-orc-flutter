import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final SharedPreferences preferences;

  PreferencesHelper(this.preferences);

  // Keys
  static const String PREF_MERCHANT_KEY = "merchant_key";
  static const String PREF_MERCHANT_SECRET = "merchant_secret";

  // Getters and Setters

  Future<String?> getMerchantKey() {
    return Future<String?>.sync(() => preferences.getString(PREF_MERCHANT_KEY));
  }

  Future<void> saveMerchantKey(String content) async {
    await preferences.setString(PREF_MERCHANT_KEY, content);
  }

  Future<String?> getMerchantSecret() {
    return Future<String?>.sync(
        () => preferences.getString(PREF_MERCHANT_SECRET));
  }

  Future<void> saveMerchantSecret(String content) async {
    await preferences.setString(PREF_MERCHANT_SECRET, content);
  }

  Future<void> clear() async {
    await preferences.clear();
  }
}
