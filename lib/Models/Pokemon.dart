class Pokemon {
  int id;
  int height;
  String name;
  List<Stat> stats;
  List<Type> types;
  List<Ability> abilities;
  int weight;

  Pokemon({
    required this.id,
    required this.height,
    required this.name,
    required this.stats,
    required this.types,
    required this.abilities,
    required this.weight,
  });

  String get imageUrl {
    return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png";
  }

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      height: json['height'],
      name: json['name'],
      stats: (json['stats'] as List<dynamic>)
          .map((stat) => Stat.fromJson(stat))
          .toList(),
      types: (json['types'] as List<dynamic>)
          .map((type) => Type.fromJson(type))
          .toList(),
      abilities: (json['abilities'] as List<dynamic>)
          .map((ability) => Ability.fromJson(ability))
          .toList(),
      weight: json['weight'],
    );
  }
}

class Ability {
  AbilityDetails ability;
  bool isHidden;
  int slot;

  Ability({
    required this.ability,
    required this.isHidden,
    required this.slot,
  });

  factory Ability.fromJson(Map<String, dynamic> json) {
    return Ability(
      ability: AbilityDetails.fromJson(json['ability']),
      isHidden: json['is_hidden'],
      slot: json['slot'],
    );
  }
}

class AbilityDetails {
  String name;
  String url;

  AbilityDetails({
    required this.name,
    required this.url,
  });

  factory AbilityDetails.fromJson(Map<String, dynamic> json) {
    return AbilityDetails(
      name: json['name'],
      url: json['url'],
    );
  }
}

class Stat {
  int baseStat;
  int effort;
  StatDetails stat;

  Stat({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  factory Stat.fromJson(Map<String, dynamic> json) {
    return Stat(
      baseStat: json['base_stat'],
      effort: json['effort'],
      stat: StatDetails.fromJson(json['stat']),
    );
  }
}

class StatDetails {
  String name;
  String url;

  StatDetails({
    required this.name,
    required this.url,
  });

  factory StatDetails.fromJson(Map<String, dynamic> json) {
    return StatDetails(
      name: json['name'],
      url: json['url'],
    );
  }
}

class Type {
  int slot;
  TypeDetails type;

  Type({
    required this.slot,
    required this.type,
  });

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
      slot: json['slot'],
      type: TypeDetails.fromJson(json['type']),
    );
  }
}

class TypeDetails {
  String name;
  String url;

  TypeDetails({
    required this.name,
    required this.url,
  });

  factory TypeDetails.fromJson(Map<String, dynamic> json) {
    return TypeDetails(
      name: json['name'],
      url: json['url'],
    );
  }
}
