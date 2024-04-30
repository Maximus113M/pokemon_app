import 'package:flutter/material.dart';
import 'package:pokemon_app/features/game/data/models/pokemon_model.dart';
import 'package:pokemon_app/features/game/domain/use_cases/get_pokemons_use_case.dart';

class GameProvier with ChangeNotifier {
  final GetPokemonsUseCase getPokemonsUseCase;
  List<PokemonModel> pokemons = [];

  GameProvier({required this.getPokemonsUseCase});

  Future<void> getPokemons() async {
    final List<int> pokemonsIds = [];
    final response = await getPokemonsUseCase.call(pokemonsIds);
    if (response == null) {
      //Error
      return;
    }
    pokemons = [...response];
  }
}
