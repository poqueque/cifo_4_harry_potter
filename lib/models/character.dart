class Character {
  final int id;
  final String name;
  final String imageUrl;
  final int strenght;
  final int magic;
  final int speed;
  int _reviews = 0;
  int _totalStars = 0;
  bool favorite = false;

  int get reviews => _reviews;

  double get averageRating => (_reviews == 0) ? 0 : _totalStars / _reviews;

  void addReview(int value) {
    _reviews++;
    _totalStars = _totalStars + value;
  }

  Character({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.strenght,
    required this.magic,
    required this.speed,
  });
}