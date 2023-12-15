import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:kingsley_final_project/Models/PokemonList.dart';
import '../Models/LoginStructure.dart';
import '../Models/Pokemon.dart';
import 'DataService.dart';

const String BaseUrl = "https://pokeapi.co/api/v2/";
String endpoint = "pokemon?offset=0&limit=20";
String loadUrl = "https://pokeapi.co/api/v2/pokemon?offset=0&limit=20";

class UserClient {
  final _dio = Dio(BaseOptions(baseUrl: BaseUrl));
  final _dioPokemonLoad = Dio(BaseOptions(baseUrl: loadUrl));
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

  Future<List<Pokemon>?> GetPokemonAsync() async {
    try {
      var response = await _dioPokemonLoad.get("");

      //Build out in future to load more than 20 pokemon using scroll
      // loadUrl = response.data['next'];

      List<PokemonList> pokemonResults =
          parsePokemonList(json.encode(response.data));

      List<Pokemon> pokemonList = [];

      for (PokemonList result in pokemonResults) {
        var pokemonDetails = await _dio.get("pokemon/${result.name}");
        Pokemon pokemon = parsePokemon(json.encode(pokemonDetails.data));
        pokemonList.add(pokemon);
      }

      return pokemonList;
    } catch (error) {
      print(error);
      return null;
    }
  }

  // Parse out list of returned pokemon from first API call
  List<PokemonList> parsePokemonList(String apiResponse) {
    Map<String, dynamic> jsonResponse = json.decode(apiResponse);
    List<dynamic> results = jsonResponse['results'];

    return results.map((result) => PokemonList.fromJson(result)).toList();
  }

  //Parse out individual pokemon information returned from subsequent API calls
  Pokemon parsePokemon(String apiResponse) {
    Map<String, dynamic> result = json.decode(apiResponse);
    return Pokemon.fromJson(result);
  }
}
