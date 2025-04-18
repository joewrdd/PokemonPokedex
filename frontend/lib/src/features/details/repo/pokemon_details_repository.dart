import 'package:dio/dio.dart';
import 'package:pokedex/src/common/utils/utils.dart';
import 'package:pokedex/src/features/details/models/pokemon_details_model.dart';

class PokemonDetailsRepository {
  Future<PokemonDetailsModel?> getPokemonDetails(String pokemonId) async {
    final Response response;

    try {
      final cleanId = pokemonId.trim().replaceAll("#", "");
      final numericId = cleanId.replaceAll(RegExp(r'[^0-9]'), '');

      final intId = int.tryParse(numericId) ?? 1;
      final idToUse = intId.toString();

      try {
        response = await Dio().get(
          "https://pokeapi.co/api/v2/pokemon/$idToUse",
          options: Options(
            responseType: ResponseType.json,
            receiveTimeout: const Duration(seconds: 15),
            sendTimeout: const Duration(seconds: 15),
          ),
        );
      } catch (apiError) {
        rethrow;
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Utils utils = Utils();

        String id =
            utils.transformIdToRightFormat(response.data["id"].toString());
        String name =
            utils.transformTextToRightShape(response.data["name"].toString());

        String imageURL = "";
        if (response.data["sprites"]?["other"]?["home"]?["front_default"] !=
            null) {
          imageURL = response.data["sprites"]["other"]["home"]["front_default"]
              .toString();
        } else if (response.data["sprites"]?["other"]?["official-artwork"]
                ?["front_default"] !=
            null) {
          imageURL = response.data["sprites"]["other"]["official-artwork"]
                  ["front_default"]
              .toString();
        } else if (response.data["sprites"]?["front_default"] != null) {
          imageURL = response.data["sprites"]["front_default"].toString();
        }

        int weight = response.data["weight"] ?? 0;
        int height = response.data["height"] ?? 0;
        int baseExperience = response.data["base_experience"] ?? 0;

        List<String> types = [];
        for (var element in response.data["types"]) {
          types.add(utils
              .transformTextToRightShape(element["type"]["name"].toString()));
        }

        List<StatModel> stats = [];
        for (var stat in response.data["stats"]) {
          String statName =
              utils.transformTextToRightShape(stat["stat"]["name"].toString());
          int baseStat = stat["base_stat"];
          stats.add(StatModel(name: statName, baseStat: baseStat));
        }
        List<AbilityModel> abilities = [];
        for (var ability in response.data["abilities"]) {
          String abilityName = utils
              .transformTextToRightShape(ability["ability"]["name"].toString());
          bool isHidden = ability["is_hidden"];
          abilities.add(AbilityModel(name: abilityName, isHidden: isHidden));
        }

        List<MoveModel> moves = [];
        int moveCount = 0;
        for (var move in response.data["moves"]) {
          if (moveCount >= 10) break;

          String moveName =
              utils.transformTextToRightShape(move["move"]["name"].toString());
          String learnMethod = "";
          int? levelLearnedAt;

          if (move["version_group_details"] != null &&
              move["version_group_details"].isNotEmpty) {
            learnMethod = move["version_group_details"][0]["move_learn_method"]
                    ["name"] ??
                "unknown";
            levelLearnedAt =
                move["version_group_details"][0]["level_learned_at"];
          } else {
            learnMethod = "unknown";
          }

          moves.add(MoveModel(
            name: moveName,
            learnMethod: learnMethod,
            levelLearnedAt: levelLearnedAt,
          ));

          moveCount++;
        }

        final details = PokemonDetailsModel(
          id: id,
          name: name,
          imageURL: imageURL,
          types: types,
          weight: weight,
          height: height,
          baseExperience: baseExperience,
          stats: stats,
          abilities: abilities,
          moves: moves,
        );

        return details;
      } else {}
    } catch (e) {
      print('Error Fetching Pokemon Details: $e');
    }

    return null;
  }
}
