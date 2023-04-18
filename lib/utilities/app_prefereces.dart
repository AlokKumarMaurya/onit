import 'package:get_storage/get_storage.dart';

class AppPreference{
  static const STORAGE_NAME = 'Onit';
  static const _profile_hash = 'user_profile_hash';
  static const _login = 'login';
  static const _saveRazorpayKey = 'saveRazorpayKey';


  final _storage = GetStorage(STORAGE_NAME);
  Future<bool> init() {
    return _storage.initStorage;
  }


  void saveRazorPayKey(String secretKey) {
    _storage.write(_saveRazorpayKey, secretKey);
  }

  String get razorpayKey {
    try {
      return _storage.read(_saveRazorpayKey);
    } catch (e) {
      return "";
    }
  }void saveProfileHash(String token) {
    _storage.write(_profile_hash, token);
  }

  String get profileHash {
    try {
      return _storage.read(_profile_hash);
    } catch (e) {
      return "";
    }
  }
  void saveLogin(bool loginSave) {
    _storage.write(_login, loginSave);
  }

  bool get savedLogin {
    try {
      return _storage.read(_login)??false;
    } catch (e) {
      return false;
    }
  }

}