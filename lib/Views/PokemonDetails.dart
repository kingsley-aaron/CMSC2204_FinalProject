import 'package:flutter/material.dart';
import 'package:kingsley_final_project/Views/PokemonView.dart';
import '../Models/Pokemon.dart';

class PokemonDetailsPage extends StatelessWidget {
  final Pokemon pokemon;

  PokemonDetailsPage({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(pokemon.name.capitalize() + ' - Details'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Display the Pokemon image at the top
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Center(
                      child: Image.network(
                        pokemon.imageUrl,
                        width: 250,
                        height: 250,
                      ),
                    ),
                    // Display the Pokemon ID at the top right
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '#${pokemon.id}',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  pokemon.name.capitalize(),
                  style: TextStyle(fontSize: 48),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Display the Pokemon Height
                    Column(
                      children: [
                        Text(
                          '${pokemon.height / 10} M',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text('Height', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    SizedBox(width: 42),
                    // Display the Pokemon Weight
                    Column(
                      children: [
                        Text(
                          '${pokemon.weight / 10} KG',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text('Weight', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
                // Display the Pokemon Types in a centered box
                Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Type(s)',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        getPokemonTypes(pokemon),
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                // Display the Pokemon Abilities in a centered box
                Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Abilities',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        getPokemonAbilities(pokemon),
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: SizedBox(
          width: 200,
          child: FloatingActionButton(
            onPressed: () {
              // Navigate back to the PokemonView page
              Navigator.pop(context);
            },
            child: Text("Return to Pokemon List"),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

String getPokemonTypes(Pokemon pokemon) {
  List<String> capitalizedTypes = pokemon.types.map((type) {
    return type.type.name.capitalize();
  }).toList();

  return capitalizedTypes.join("\n");
}

String getPokemonAbilities(Pokemon pokemon) {
  List<String> abilities = pokemon.abilities.map((ability) {
    String abilityName = ability.isHidden
        ? '${ability.ability.name.capitalize()} (Hidden)'
        : ability.ability.name.capitalize();

    return abilityName;
  }).toList();

  return abilities.join('\n');
}
