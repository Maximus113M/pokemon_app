import 'package:pokemon_app/features/game/data/models/pokemon_model.dart';
import 'package:pokemon_app/features/game/data/datasources/game_datasource.dart';
import 'package:pokemon_app/features/game/domain/respositories/game_repository.dart';

class GameRepositoryImpl extends GameRepository {
  final GameDatasource gameDatasource;

  GameRepositoryImpl({required this.gameDatasource});

  @override
  Future<List<PokemonModel>?> getPokemons(List<int> pokemonsIds) async {
    try {
      return await getPokemons(pokemonsIds);
    } catch (e) {
      return null;
    }
  }
}
