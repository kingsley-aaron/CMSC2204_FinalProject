import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DataService {
  FlutterSecureStorage SecureStorage = const FlutterSecureStorage();

  static const String usernameKey = 'username';
  static const String passwordKey = 'password';

  // Retrieve login credentials
  Future<Map<String, String>> getCredentials() async {
    String? username = await SecureStorage.read(key: usernameKey);
    String? password = await SecureStorage.read(key: passwordKey);

    return {'username': username ?? '', 'password': password ?? ''};
  }

  // Save username and password
  Future<void> saveCredentials(String username, String password) async {
    await SecureStorage.write(key: usernameKey, value: username);
    await SecureStorage.write(key: passwordKey, value: password);
  }

  // Check if there are existing credentials
  Future<bool> hasCredentials() async {
    String? storedUsername = await SecureStorage.read(key: usernameKey);
    String? storedPassword = await SecureStorage.read(key: passwordKey);

    return storedUsername != null && storedPassword != null;
  }

  // Clear stored username & password
  Future<void> clearCredentials() async {
    await SecureStorage.delete(key: usernameKey);
    await SecureStorage.delete(key: passwordKey);
  }

  Future<bool> doesUsernameExist(String enteredUsername) async {
    String? storedUsername = await SecureStorage.read(key: usernameKey);
    return storedUsername != null &&
        storedUsername.isNotEmpty &&
        storedUsername == enteredUsername;
  }

  Future<bool> isPasswordCorrect(String username, String password) async {
    String? storedUsername = await SecureStorage.read(key: usernameKey);
    String? storedPassword = await SecureStorage.read(key: passwordKey);

    return username == storedUsername && password == storedPassword;
  }

//   ///Stores a string in secure storage
//   Future<bool> AddItem(String key, String value) async {
//     try {
//       await SecureStorage.write(key: key, value: value);
//       return true;
//     } catch (error) {
//       print(error);
//       return false;
//     }
//   }

//   ///Returns the requested value by key from secure storage
//   Future<String?> TryGetItem(String key) async {
//     try {
//       return await SecureStorage.read(key: key);
//     } catch (error) {
//       print(error);
//       return null;
//     }
//   }
}
