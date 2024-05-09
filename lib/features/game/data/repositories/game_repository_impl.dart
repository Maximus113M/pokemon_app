import 'package:pokemon_app/features/game/data/models/pokemon_model.dart';
import 'package:pokemon_app/features/game/data/datasources/game_datasource.dart';
import 'package:pokemon_app/features/game/domain/respositories/game_repository.dart';

class GameRepositoryImpl extends GameRepository {
  //inyeccion del datasource
  final GameDatasource gameDatasource;

  GameRepositoryImpl({required this.gameDatasource});

  //sobre escritura obligatoria del metodo definido en la interfaz
  @override
  Future<List<PokemonModel>?> getPokemons(List<int> pokemonsIds) async {
    //control de excepciones
    try {
      return await gameDatasource.getPokemons(pokemonsIds);
    } catch (e) {
      return null;
    }
  }
}
