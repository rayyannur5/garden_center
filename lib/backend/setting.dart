import 'package:shared_preferences/shared_preferences.dart';

class DataSetting {
  void setNotifikasi(bool value) async {
    SharedPreferences.setMockInitialValues({});

    SharedPreferences pref = await SharedPreferences.getInstance();
    print('masuk set');
    pref.setBool('notifikasi', false);
  }

  static getNotifikasi() async {
    SharedPreferences.setMockInitialValues({});

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (!sharedPreferences.containsKey('notifikasi')) {
      sharedPreferences.setBool('notifikasi', false);
    }
    return sharedPreferences.getBool('notifikasi');
  }
}
