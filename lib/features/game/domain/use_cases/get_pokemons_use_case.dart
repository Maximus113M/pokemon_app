import 'package:pokemon_app/features/game/data/models/pokemon_model.dart';
import 'package:pokemon_app/features/game/domain/respositories/game_repository.dart';

class GetPokemonsUseCase {
  //inyeccion de la clase GameRepository
  final GameRepository gameRepository;

  GetPokemonsUseCase({required this.gameRepository});

  //devulve una Lista del modelo Pokemon que puede ser nula, y recibe una lista de numeros(ids)
  Future<List<PokemonModel>?> call(List<int> pokemonsIds) async {
    return await gameRepository.getPokemons(pokemonsIds);
  }
}
