import 'package:flutter/material.dart';

import 'package:pokemon_app/core/util/app_assests.dart';
import 'package:pokemon_app/core/util/screen_size.dart';
import 'package:pokemon_app/core/util/app_functions.dart';
import 'package:pokemon_app/features/game/data/models/pokemon_model.dart';
import 'package:pokemon_app/features/game/domain/use_cases/get_pokemons_use_case.dart';

import 'package:go_router/go_router.dart';

class GameProvider with ChangeNotifier {
  final GetPokemonsUseCase getPokemonsUseCase;
  List<PokemonModel> pokemons = [];
  bool isShowingPokemon = false;
  bool isLoading = false;
  bool isCorrectAnswer = false;
  bool isNewGame = false;
  int successAttemptsCounter = 0;
  int roundCounter = 1;
  int imageId = 1;
  String endMessage = '';
  //modelo creado para mapear la informacion obtenida desde la respuesta de la Api
  PokemonModel? hidenPokemon;
  PokemonModel? selectedPokemon;

  GameProvider({required this.getPokemonsUseCase});

  //hace la primera configuracion del juego despues de hacer el logIn
  Future<void> initGame() async {
    if (isLoading) return;
    isLoading = true;
    successAttemptsCounter = 0;
    roundCounter = 1;
    await getPokemons();
    isLoading = false;
    notifyListeners();
  }

  //ejecuta el caso de uso que hace el llamado de la PokeApi
  Future<void> getPokemons() async {
    final List<int> pokemonsIds = [
      ...AppFunctions.getRandomNumbers()
    ]; //Clase que contiene funciones, como la de obtener numero random
    final int selectedIndex = AppFunctions.getRandomIndex();
    imageId = pokemonsIds[selectedIndex];
    pokemons.clear();
    isShowingPokemon = false;
    notifyListeners();

    final response = await getPokemonsUseCase.call(pokemonsIds);

    if (response == null) {
      return;
    }
    pokemons = [...response];
    hidenPokemon = pokemons[selectedIndex];
    //Respuestas
    // debugPrint('${hidenPokemon!.id}');
    // debugPrint(hidenPokemon!.name);
  }

  //evalua y gestiona si la respuesta es correcta o no
  void checkAnswer(BuildContext context, PokemonModel pokemon) async {
    if (isShowingPokemon) return;
    selectedPokemon = pokemon;

    if (hidenPokemon!.id != selectedPokemon!.id) {
      isCorrectAnswer = false;
    } else {
      isCorrectAnswer = true;
      successAttemptsCounter++;
    }
    isShowingPokemon = true;

    //Cuando se este seleccionando la 10 respuesta esta funcion muestra el dialogo de fin
    if (roundCounter == 10) {
      finishGame(context);
    }
    notifyListeners();
  }

  //carga la siguiente ronda en el juego
  void loadNextRound() async {
    if (isLoading) return;
    isLoading = true;
    isShowingPokemon = false;
    isNewGame = false;
    selectedPokemon = null;

    if (roundCounter < 10) {
      roundCounter++;
    } else {
      roundCounter = 1;
      successAttemptsCounter = 0;
    }
    await getPokemons();
    isLoading = false;
    notifyListeners();
  }

  //evalua el dialogo a mostrar segun el puntaje y muestra el dialogo final
  void finishGame(BuildContext context) {
    endMessage = 'Tu puntaje ha sido $successAttemptsCounter de 10... ';
    switch (successAttemptsCounter) {
      case <= 3:
        endMessage += 'Sigue Intentando ☺.';
        break;
      case <= 7:
        endMessage += 'Muy bien, vas en camino a ser un Maestro Pokémon.';
        break;
      case >= 8:
        endMessage += 'Eres un Maestro Pokémon.';
        break;
      default:
    }
    //funcion que muestra el dialogo
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        //widget de flutter
        surfaceTintColor: Colors.white,
        title: Row(
          children: [
            const Text(
              'Juego Terminado',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            SizedBox(
              width: ScreenSize.width * 0.05,
            ),
            Image.asset(
              AppAssets.pokeBall,
              height: 40,
            ),
          ],
        ),
        content: Text(endMessage),
        actions: [
          TextButton(
            onPressed: () => {
              context.pop(),
              isNewGame = true,
              notifyListeners(),
            },
            child: const Text(
              'Ok',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          )
        ],
      ),
    );
  }
}
