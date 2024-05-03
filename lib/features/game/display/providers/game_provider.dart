import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pokemon_app/core/util/app_functions.dart';
import 'package:pokemon_app/features/game/data/models/pokemon_model.dart';
import 'package:pokemon_app/features/game/data/datasources/game_datasource.dart';
import 'package:pokemon_app/features/game/data/repositories/game_repository_impl.dart';
import 'package:pokemon_app/features/game/domain/use_cases/get_pokemons_use_case.dart';

class GameProvider with ChangeNotifier {
  final GetPokemonsUseCase getPokemonsUseCase;
  List<PokemonModel> pokemons = [];
  bool isShowingPokemon = false;
  bool isLoading = false;
  int successAttemptsCounter = 0;
  int roundCounter = 0;
  int imageId = 1;
  PokemonModel? currentPokemon;
  GameProvider({required this.getPokemonsUseCase});

  Future<void> initGame() async {
    if (isLoading) return;
    isLoading = true;
    successAttemptsCounter = 0;
    roundCounter = 1;
    await getPokemons();
    isLoading = false;
  }

  Future<void> getPokemons() async {
    final List<int> pokemonsIds = [...AppFunctions.getRandomNumbers()];
    final int selectedIndex = AppFunctions.getRandomIndex();
    imageId = pokemonsIds[selectedIndex];
    print(pokemonsIds);
    notifyListeners();

    final response = await getPokemonsUseCase.call(pokemonsIds);

    if (response == null) {
      return;
    }
    pokemons = [...response];
    currentPokemon = pokemons[selectedIndex];
    print(currentPokemon!.id);
    print(currentPokemon!.name);
    notifyListeners();
  }

  void checkAnswer(BuildContext context, PokemonModel selectedPokemon) {
    if (currentPokemon!.id != selectedPokemon.id) {}
  }
}
