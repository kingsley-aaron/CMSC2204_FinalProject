import 'package:flutter/material.dart';

import '../Models/Pokemon.dart'; // Import your Pokemon model
import '../Repositories/UserClient.dart';
import 'PokemonDetails.dart'; // Import your PokemonClient

class PokemonView extends StatefulWidget {
  final List<Pokemon> inPokemon;
  final UserClient userClient = UserClient();
  PokemonView({Key? key, required this.inPokemon}) : super(key: key);

  @override
  State<PokemonView> createState() => _PokemonViewState(inPokemon);

  void getPokemon() {}
}

bool _loading = false;

class _PokemonViewState extends State<PokemonView> {
  _PokemonViewState(pokemon);

  late List<Pokemon> pokemonList = widget.inPokemon;

  void getPokemon() {
    // Load page and set results from GetPokemonAsync to the list
    setState(() {
      _loading = true;
      widget.userClient.GetPokemonAsync().then((newPokemonList) {
        if (newPokemonList != null) {
          pokemonList = newPokemonList;
        }
        _loading = false;
      });
    });
  }

  void onReloadButtonPress() {
    setState(() {
      _loading = true;
      getPokemon();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Page Reloaded"),
        ),
      );
    });
  }

  // Method to capitalize the types returned from the calls and join if multiple types
  String getPokemonTypes(Pokemon pokemon) {
    List<String> capitalizedTypes = pokemon.types.map((type) {
      return type.type.name.capitalize();
    }).toList();

    return capitalizedTypes.join(", ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("View Pokemon"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Colors.red,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: pokemonList.map((pokemon) {
                return Padding(
                  padding: EdgeInsets.all(3),
                  // Set the card to be able to be tapped to load details
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PokemonDetailsPage(
                            pokemon: pokemon,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Text(
                              "#${pokemon.id}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            title: Text(
                              "Name: ${pokemon.name.capitalize()}",
                              style: TextStyle(fontSize: 16),
                            ),
                            subtitle: Text("Type: ${getPokemonTypes(pokemon)}"),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onReloadButtonPress,
        child: Icon(Icons.refresh),
      ),
    );
  }
}

//Method to capitalize the names returned from the API call
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
