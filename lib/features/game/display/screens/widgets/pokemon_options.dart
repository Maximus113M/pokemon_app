import 'package:flutter/material.dart';

import 'package:pokemon_app/core/util/screen_size.dart';
import 'package:pokemon_app/features/game/data/models/pokemon_model.dart';
import 'package:pokemon_app/features/game/display/providers/game_provider.dart';

import 'package:provider/provider.dart';

class PokemonOptions extends StatelessWidget {
  //parametro requerido
  final GameProvider gameProvider;
  const PokemonOptions({super.key, required this.gameProvider});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.15),
      child: Column(
        //metodo que genenera una lista(iteracion) pueden ser widgets
        children: List.generate(
          gameProvider.pokemons.length,
          (index) => responseOption(context, gameProvider.pokemons[index]),
        ),
      ),
    );
  }

  //metodo que devuelve el widget que construye cada opcion, pide context y el pokemon por parametro
  Widget responseOption(BuildContext context, PokemonModel pokemon) {
    //widget que permite que otro widget adquiera algun comportamiento segun los gestos...
    return GestureDetector(
      onTap: () {
        //llamado al GameProvider par verificar la opcion selecionada
        context.read<GameProvider>().checkAnswer(context, pokemon);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: ScreenSize.absoluteHeight * 0.01),
        padding: EdgeInsets.symmetric(
            horizontal: ScreenSize.width * 0.005,
            vertical: ScreenSize.absoluteHeight * 0.002),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: gameProvider.selectedPokemon?.id == pokemon.id
                ? Colors.amber
                : Colors.grey.shade300,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          color: gameProvider.isShowingPokemon
              ? gameProvider.hidenPokemon?.id == pokemon.id
                  ? Colors.green.shade50
                  : Colors.red.shade50
              : Colors.white24,
        ),
        //contruye widgets en horizontal
        child: Row(
          children: [
            Icon(
              Icons.arrow_circle_right,
              color: Colors.yellow.shade700,
              size: ScreenSize.absoluteHeight * 0.04,
            ),
            SizedBox(
              width: ScreenSize.width * 0.5,
              child: Text(
                pokemon.name,
                style: TextStyle(
                  fontSize: ScreenSize.width * 0.04,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
