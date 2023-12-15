class PokemonList {
  String name;
  String url;

  PokemonList({required this.name, required this.url});

  factory PokemonList.fromJson(Map<String, dynamic> json) {
    return PokemonList(
      name: json['name'],
      url: json['url'],
    );
  }
}
