import 'package:flutter/material.dart';
import 'package:harry_potter/models/character.dart';
import 'package:harry_potter/services/database.dart';

class HogwartsData extends ChangeNotifier {
  List<Character> initialCharacters = [
    Character(
      name: "Hermione Granger",
      imageUrl:
          "https://static.wikia.nocookie.net/warnerbros/images/3/3e/Hermione.jpg/revision/latest/scale-to-width-down/1000?cb=20120729103114&path-prefix=es",
      strenght: 7,
      magic: 10,
      speed: 9,
    ),
    Character(
      name: "Ron Weasley",
      imageUrl:
          "https://static.wikia.nocookie.net/esharrypotter/images/6/69/P7_promo_Ron_Weasley.jpg/revision/latest/scale-to-width-down/1000?cb=20150523213430",
      strenght: 8,
      magic: 8,
      speed: 7,
    ),
    Character(
      name: "Harry Potter",
      imageUrl:
          "https://static.wikia.nocookie.net/esharrypotter/images/8/8d/PromoHP7_Harry_Potter.jpg/revision/latest/scale-to-width-down/1000?cb=20160903184919",
      strenght: 6,
      magic: 9,
      speed: 8,
    ),
  ];

  List<Character> characters = [];

  Future<void> init() async {
    characters = await Database.instance.getAllCharacters();
    if (characters.isEmpty) {
      characters.addAll(initialCharacters);
      for (var character in characters) {
        Database.instance.updateCharacter(character);
      }
    }
  }

  Character getCharacterById(int id) {
    return characters.firstWhere((element) => element.id == id);
  }

  void addReview(int id, int value) {
    Character character = getCharacterById(id);
    character.addReview(value);
    Database.instance.updateCharacter(character);
    notifyListeners();
  }

  void toggleFavorite(int id) {
    Character character = getCharacterById(id);
    character.favorite = !character.favorite;
    Database.instance.updateCharacter(character);
    notifyListeners();
  }
}
