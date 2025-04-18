class PokemonDetailsModel {
  final String id;
  final String name;
  final String imageURL;
  final List<String> types;
  final int weight;
  final int height;
  final int baseExperience;
  final List<StatModel> stats;
  final List<AbilityModel> abilities;
  final List<MoveModel> moves;

  PokemonDetailsModel({
    required this.id,
    required this.name,
    required this.imageURL,
    required this.types,
    required this.weight,
    required this.height,
    required this.baseExperience,
    required this.stats,
    required this.abilities,
    required this.moves,
  });
}

class StatModel {
  final String name;
  final int baseStat;

  StatModel({required this.name, required this.baseStat});
}

class AbilityModel {
  final String name;
  final bool isHidden;

  AbilityModel({required this.name, required this.isHidden});
}

class MoveModel {
  final String name;
  final String learnMethod;
  final int? levelLearnedAt;

  MoveModel({
    required this.name,
    required this.learnMethod,
    this.levelLearnedAt,
  });
}
