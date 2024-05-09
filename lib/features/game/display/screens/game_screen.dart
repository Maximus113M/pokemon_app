import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:pokemon_app/core/util/app_assests.dart';
import 'package:pokemon_app/core/util/screen_size.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:pokemon_app/features/game/display/providers/game_provider.dart';
import 'package:pokemon_app/features/sign_in/display/providers/sign_in_provider.dart';
import 'package:pokemon_app/features/game/display/screens/widgets/pokemon_options.dart';

import 'package:provider/provider.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          //boton de log out
          IconButton(
              onPressed: () {
                if (context.read<GameProvider>().isLoading) return;
                context.read<SignInProvider>().logOut();
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
        backgroundColor: Colors.red.shade700,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
        centerTitle: true,
        //propiedad que permite un widget en el appbar, Image.asset() renderiza la imagen desde los assets
        title: Image.asset(
          AppAssets.pokemonLogo,
          height: 50,
        ),
      ),
      body: GameScreenBody(
        gameProvider: context.watch(),
      ),
    );
  }
}

class GameScreenBody extends StatelessWidget {
  //propiedad requerida
  final GameProvider gameProvider;
  const GameScreenBody({super.key, required this.gameProvider});

  @override
  Widget build(BuildContext context) {
    //stack permite la superposicion de componentes
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: ScreenSize.width,
          height: ScreenSize.height,
          child: Column(
            children: [
              //widget que permite agregar espacio a un widget en sus ejes X y Y
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  '¿Quién es ese Pokémon?\n${gameProvider.roundCounter}/10', //interpolacion de string
                  style: TextStyle(
                      fontSize: ScreenSize.width * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow.shade700),
                  textAlign: TextAlign.center,
                ),
              ),
              //funcion que retorna el widget que contiene la seccion de la imagen
              pokemonImage(gameProvider),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: ScreenSize.absoluteHeight * 0.035,
                  ),
                  child: Text(
                    //evaluacion logica segun para eligir el texto segun la respuesta dada
                    gameProvider.isShowingPokemon
                        ? gameProvider.isCorrectAnswer
                            ? 'Respuesta correcta!'
                            : 'Upsss... El Pokémon era ${gameProvider.hidenPokemon?.name}' //interpolacion de string
                        : '',
                    style: TextStyle(
                      fontSize: ScreenSize.width * 0.042,
                      color: gameProvider.isCorrectAnswer
                          ? Colors.green.shade600
                          : Colors.red.shade600,
                    ),
                  ),
                ),
              ),
              //widget que contiene la seccion de la opciones
              PokemonOptions(
                gameProvider: gameProvider,
              ),
              //puede utilizarse widgets para dar espacio entre widgets
              SizedBox(
                height: ScreenSize.absoluteHeight * 0.035,
              ),
              TextButton(
                //propiedades del boton
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  backgroundColor: MaterialStatePropertyAll(
                    Colors.red.shade600,
                  ),
                  foregroundColor: const MaterialStatePropertyAll(
                    Colors.white,
                  ),
                  padding: MaterialStatePropertyAll(
                    EdgeInsets.symmetric(
                      vertical: ScreenSize.width * 0.035,
                      horizontal: gameProvider.roundCounter == 10 &&
                              gameProvider.isShowingPokemon
                          ? ScreenSize.width * 0.20
                          : ScreenSize.width * 0.23,
                    ),
                  ),
                ),
                onPressed: () {
                  //si cumple la condicion, carga la siguiente ronda
                  if (gameProvider.roundCounter == 10 &&
                      !gameProvider.isNewGame) return;
                  gameProvider.loadNextRound();
                },
                child: Text(
                  //evaluacion logica segun para eligir el texto segun la ronda actual
                  gameProvider.roundCounter == 10 &&
                          gameProvider.isShowingPokemon
                      ? 'NUEVO JUEGO'
                      : 'CONTINUAR',
                  style: TextStyle(
                    fontSize: ScreenSize.width * 0.04,
                  ),
                ),
              )
            ],
          ),
        ),
        //animacion de carga
        if (gameProvider.isLoading)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
            child: Transform.scale(
              scale: 0.8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppAssets.loadingLottie,
                  Text(
                    'Cargando...',
                    style: TextStyle(fontSize: ScreenSize.width * 0.055),
                  ),
                ],
              ),
            ),
          )
      ],
    );
  }
}

SizedBox pokemonImage(GameProvider gameProvider) {
  return SizedBox(
    height: ScreenSize.absoluteHeight * 0.35,
    width: ScreenSize.width,
    child: Stack(
      alignment: Alignment.center,
      children: [
        //fondo circular azul del componente
        CircleAvatar(
          backgroundColor: Colors.blue.shade50,
          radius: ScreenSize.absoluteHeight * 0.15,
        ),
        //permited modificar el color e iluminacion de una imagen
        ColorFiltered(
          colorFilter: ColorFilter.mode(
              Colors.black,
              //segun la evalucion logica la imagen toma sus colores u oscurese
              gameProvider.isShowingPokemon ? BlendMode.dst : BlendMode.srcIn),
          child: Image(
            height: ScreenSize.absoluteHeight * 0.25,
            //el paquete Svg renderiza la imagen que se obtiene desde la url
            image: Svg(
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/${gameProvider.imageId}.svg', //se envia el id del pokemon
              source: SvgSource.network,
            ),
          ),
        ),
        //posiciona el elemento en un lugar especifico del Stack
        Positioned(
          right: ScreenSize.width * 0.15,
          bottom: 0,
          child: Image.asset(
            AppAssets.pokemonTitle,
            height: ScreenSize.absoluteHeight * 0.15,
          ),
        ),
      ],
    ),
  );
}
