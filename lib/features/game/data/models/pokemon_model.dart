class PokemonModel {
  final int id;
  final String name;

  PokemonModel({
    required this.id,
    required this.name,
  });

  //crea el modelo apartir del json
  factory PokemonModel.fromJson(json) => PokemonModel(
        id: json['id'],
        name: json['name'],
      );
}
