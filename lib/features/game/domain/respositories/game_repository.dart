import 'package:pokemon_app/features/game/data/models/pokemon_model.dart';

abstract class GameRepository {
  Future<List<PokemonModel>?> getPokemons(List<int> pokemonsIds);
}
