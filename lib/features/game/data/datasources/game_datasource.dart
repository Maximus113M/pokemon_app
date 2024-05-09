import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokemon_app/features/game/data/models/pokemon_model.dart';
import 'package:http/http.dart' as http;

abstract class GameDatasource {
  Future<List<PokemonModel>?> getPokemons(List<int> pokemonsIds);
}

class GameDatasourceImpl extends GameDatasource {
  @override
  Future<List<PokemonModel>?> getPokemons(List<int> pokemonsIds) async {
    try {
      //lista que se devolvera
      List<PokemonModel> pokemons = [];

      //itera cada pokemonId y realiza la consulta
      await Future.forEach(pokemonsIds, (pokemonId) async {
        final Uri url = Uri.https('pokeapi.co', '/api/v2/pokemon/$pokemonId');
        final response = await http.get(url);

        print(
            '-------------------------------------------------------------------------------------------------');
        print(response.body);
        //agrega el pokemon de cada consulta a la lista
        pokemons.add(
          PokemonModel.fromJson(jsonDecode(response.body)),
        );
      });
      return pokemons;
    } catch (e) {
      debugPrint('getPokemons Error ==> $e');
      //retorna null si hay algun fallo
      return null;
    }
  }
}
