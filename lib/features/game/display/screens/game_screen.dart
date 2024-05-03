import 'package:flutter/material.dart';
import 'package:pokemon_app/core/util/app_assests.dart';
import 'package:pokemon_app/core/util/screen_size.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:pokemon_app/features/game/display/providers/game_provider.dart';
import 'package:pokemon_app/features/game/display/screens/widgets/pokemon_options.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {},
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.pokemonLogo,
              height: 50,
            ),
            /*Image.asset(
              AppAssets.pokeBall,
              height: 40,
            ),*/
          ],
        ),
      ),
      body: GameScreenBody(
        gameProvider: context.read(),
      ),
    );
  }
}

class GameScreenBody extends StatelessWidget {
  final GameProvider gameProvider;
  const GameScreenBody({super.key, required this.gameProvider});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSize.width,
      height: ScreenSize.height,
      decoration: BoxDecoration(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'Quien es ese Pokemon?\n1/10',
              style: TextStyle(
                fontSize: ScreenSize.width * 0.05,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          pokemonImage(gameProvider),
          SizedBox(
            height: ScreenSize.absoluteHeight * 0.1,
          ),
          PokemonOptions(
            gameProvider: gameProvider,
          ),
        ],
      ),
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
        CircleAvatar(
          backgroundColor: Colors.blue.shade50,
          radius: ScreenSize.absoluteHeight * 0.15,
        ),
        ColorFiltered(
          colorFilter: ColorFilter.mode(Colors.black,
              gameProvider.isShowingPokemon ? BlendMode.dst : BlendMode.srcIn),
          child: Image(
            height: ScreenSize.absoluteHeight * 0.25,
            image: const Svg(
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/${180}.svg',
              source: SvgSource.network,
            ),
          ),
        ),
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
