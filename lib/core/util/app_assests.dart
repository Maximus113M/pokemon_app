import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pokemon_app/core/util/screen_size.dart';

class AppAssets {
  AppAssets._();

  static const String pokemonTitle = 'assets/images/pokemon.png';
  static const String pokemonLogo = 'assets/images/pokemon-logo.png';
  static const String pokeBall = 'assets/images/pokeball.png';
  static const String bigPokeBall = 'assets/images/pokeballBig.png';

  static Widget loadingLottie = Lottie.asset("assets/images/loading.json",
      frameRate: FrameRate.max, height: ScreenSize.absoluteHeight * 0.2);
}
