import 'package:shared_preferences/shared_preferences.dart';

class UserManager {
  static const String _userIdKey = 'userId';
  static const String _phoneNumberKey = 'phoneNumber';
  static const String _countKey = 'count';

  // Save user data to SharedPreferences
  Future<void> saveUserData(String userId, String phoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, userId);
    await prefs.setString(_phoneNumberKey, phoneNumber);
    await prefs.setInt(_countKey, 0); // Initialize count with 0
  }

  // Get user ID from SharedPreferences
  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  // Get phone number from SharedPreferences
  Future<String?> getPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_phoneNumberKey);
  }

  // Get count from SharedPreferences
  Future<int> getCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_countKey) ?? 0;
  }

  // Increment count in SharedPreferences
  Future<void> incrementCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentCount = prefs.getInt(_countKey) ?? 0;
    await prefs.setInt(_countKey, currentCount + 1);
  }

  // Clear user data from SharedPreferences
  Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userIdKey);
    await prefs.remove(_phoneNumberKey);
    await prefs.remove(_countKey);
  }
}
