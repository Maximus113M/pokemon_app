import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokemon_app/features/game/data/models/pokemon_model.dart';
import 'package:http/http.dart' as http;

abstract class GameDatasource {
  Future<List<PokemonModel>?> getPokemons(List<int> pokemonsIds);
}

class GameDatasourceImpl extends GameDatasource {
  //https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/${pokemonId}.svg
  @override
  Future<List<PokemonModel>?> getPokemons(List<int> pokemonsIds) async {
    try {
      List<PokemonModel> pokemons = [];

      Future.forEach(pokemonsIds, (pokemonId) async {
        final Uri url =
            Uri.https('https://pokeapi.co/api/v2/pokemon/$pokemonId');
        final response = await http.get(url);
        pokemons.add(
          PokemonModel.fromJson(jsonDecode(response.body)),
        );
      });
      return pokemons;
    } catch (e) {
      debugPrint('getPokemons Error ==> $e');
      return null;
    }
  }
}
