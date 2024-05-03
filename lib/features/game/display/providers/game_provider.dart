import 'package:flutter/material.dart';
import 'package:pokemon_app/core/util/app_functions.dart';
import 'package:pokemon_app/features/game/data/models/pokemon_model.dart';
import 'package:pokemon_app/features/game/domain/use_cases/get_pokemons_use_case.dart';

class GameProvider with ChangeNotifier {
  final GetPokemonsUseCase getPokemonsUseCase;
  List<PokemonModel> pokemons = [];
  bool isShowingPokemon = false;
  bool isLoading = false;
  int successAttemptsCounter = 0;
  int roundCounter = 0;
  PokemonModel? currentPokemon;
  GameProvider({required this.getPokemonsUseCase});

  Future<void> gameInit() async {
    successAttemptsCounter = 0;
    roundCounter = 1;
    await getPokemons();
  }

  Future<void> getPokemons() async {
    if (isLoading) return;
    isLoading = true;
    final List<int> pokemonsIds = [...AppFunctions.getRandomNumbers()];
    print(pokemonsIds);
    final response = await getPokemonsUseCase.call(pokemonsIds);
    if (response == null) {
      //Error Notificar
      return;
    }
    pokemons = [...response];
    currentPokemon = pokemons.first;
    print(currentPokemon!.id);
    print(currentPokemon!.name);
    isLoading = false;
    notifyListeners();
  }
}
