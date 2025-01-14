import 'package:isar/isar.dart';

part 'character.g.dart';

@collection
class Character {
  Id id = Isar.autoIncrement;
  final String name;
  final String imageUrl;
  final int strenght;
  final int magic;
  final int speed;
  int reviews = 0;
  int totalStars = 0;
  bool favorite = false;

  double get averageRating => (reviews == 0) ? 0 : totalStars / reviews;

  void addReview(int value) {
    reviews++;
    totalStars = totalStars + value;
  }

  Character({
    required this.name,
    required this.imageUrl,
    required this.strenght,
    required this.magic,
    required this.speed,
  });
}
