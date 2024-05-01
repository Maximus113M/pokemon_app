import 'package:pokemon_app/features/game/data/models/pokemon_model.dart';
import 'package:pokemon_app/features/game/domain/respositories/game_repository.dart';

class GetPokemonsUseCase {
  final GameRepository gameRepository;

  GetPokemonsUseCase({required this.gameRepository});

  Future<List<PokemonModel>?> call(List<int> pokemonsIds) async {
    return gameRepository.getPokemons(pokemonsIds);
  }
}
