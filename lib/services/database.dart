import 'package:harry_potter/models/character.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class Database {
  static final Database _instance = Database._internal();
  Database._internal();
  factory Database() => _instance;
  static Database get instance => _instance;

  late Isar isar;

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [CharacterSchema],
      directory: dir.path,
    );
  }

  Future<List<Character>> getAllCharacters() async {
    return isar.characters.where().findAll();
  }

  Future<void> updateCharacter(Character character) async {
    await isar.writeTxn(() async {
      await isar.characters.put(character);
    });
  }
}
