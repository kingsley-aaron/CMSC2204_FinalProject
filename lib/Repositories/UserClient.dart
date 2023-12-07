import 'package:dio/dio.dart';
import '../Models/LoginStructure.dart';
import 'DataService.dart';

const String BaseUrl = "https://pokeapi.co/api/v2/";

class UserClient {
  final _dio = Dio(BaseOptions(baseUrl: BaseUrl));
  DataService _dataService = DataService();

  Future<String?> Login(LoginStructure user) async {
    try {
      String enteredUsername = user.username;
      String enteredPassword = user.password;

      // Check if the entered username exists
      bool doesUsernameExist =
          await _dataService.doesUsernameExist(enteredUsername);

      if (doesUsernameExist) {
        // If the username exists, check if the password is correct
        bool isPasswordCorrect = await _dataService.isPasswordCorrect(
            enteredUsername, enteredPassword);

        if (isPasswordCorrect) {
          // Valid user and correct password
          return "Login Success";
        } else {
          // Incorrect password
          return "Incorrect Password";
        }
      } else {
        // Username does not exist
        return "User does not exist";
      }
    } catch (error) {
      print(error);
      return "Error: $error";
    }
  }
}
