import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPref {
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key));
  }

  Future<dynamic> readSingle(String key) async {
    final prefs = await SharedPreferences.getInstance();
    print("read preference");
    print(prefs.getString(key));
    return prefs.getString(key);
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  saveSingle(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    print("in preference");
    print(value);
    prefs.setString(key, value);
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  removeAll() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<bool> check(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(key)) {
      return true;
    } else {
      return false;
    }
  }
}
