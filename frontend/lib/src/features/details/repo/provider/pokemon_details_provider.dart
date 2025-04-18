import 'package:flutter/material.dart';
import 'package:pokedex/src/features/details/models/pokemon_details_model.dart';
import 'package:pokedex/src/features/details/repo/pokemon_details_repository.dart';

class PokemonDetailsProvider extends ChangeNotifier {
  final PokemonDetailsRepository _repository = PokemonDetailsRepository();

  PokemonDetailsModel? _pokemonDetails;
  bool _isLoading = false;
  String? _error;

  PokemonDetailsModel? get pokemonDetails => _pokemonDetails;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchPokemonDetails(String pokemonId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      if (pokemonId.isEmpty) {
        _error = "Invalid Pokemon ID";
        _isLoading = false;
        notifyListeners();
        return;
      }

      final details = await _repository.getPokemonDetails(pokemonId);
      if (details != null) {
        _pokemonDetails = details;
        print('Successfully loaded details for ${details.name}');
      } else {
        _error =
            "Failed to load Pokemon details. Please check network connection and try again.";
      }
    } catch (e) {
      _error = "Error: ${e.toString()}";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
