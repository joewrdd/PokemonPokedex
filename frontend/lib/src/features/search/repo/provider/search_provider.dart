import 'package:flutter/material.dart';
import 'package:pokedex/src/features/home/repo/repositories/pokemon_repositorie.dart';
import 'package:pokedex/src/features/home/models/pokemon_general_informtion_model.dart';
import 'package:pokedex/src/features/home/models/pokemon_model.dart';

class SearchProvider extends ChangeNotifier {
  PokemonRepositorie repositorie = PokemonRepositorie();
  List<PokemonGeneralInformtionModel> generalPokemonInformations = [];

  Future<void> initialize() async {
    await _loadAllGeneralPokemonInfomrations();
    notifyListeners();
  }

  Future<void> _loadAllGeneralPokemonInfomrations() async {
    generalPokemonInformations = await repositorie
            .getPokemonGeneralInfomrationsWithLimitAndOffset(1500, 0) ??
        [];
    notifyListeners();
  }

  Future<List<PokemonModel>> searchPokemons(String query) async {
    List<PokemonGeneralInformtionModel> results = [];
    for (var pokemon in generalPokemonInformations) {
      if (pokemon.name.toLowerCase().contains(query.toLowerCase())) {
        results.add(pokemon);
      }
    }
    List<PokemonModel> pokeData =
        await repositorie.getPokemonDataByUrlAndName(results);
    return pokeData;
  }

  Future<List<PokemonModel>> searchPokemonThatMatches(
      String pokemonQuery) async {
    List<PokemonGeneralInformtionModel> results = [];
    for (var pokemon in generalPokemonInformations) {
      if (pokemon.name.toLowerCase() == pokemonQuery.toLowerCase()) {
        results.add(pokemon);
      }
    }
    List<PokemonModel> pokeData =
        await repositorie.getPokemonDataByUrlAndName(results);
    return pokeData;
  }
}
