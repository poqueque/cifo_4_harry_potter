import 'package:flutter/material.dart';
import 'package:harry_potter/models/character.dart';
import 'package:harry_potter/widgets/rating.dart';

class CharacterDetail extends StatefulWidget {
  const CharacterDetail({super.key, required this.character});

  final Character character;

  @override
  State<CharacterDetail> createState() => _CharacterDetailState();
}

class _CharacterDetailState extends State<CharacterDetail> {

  int lastStarClicked = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Harry Potter App"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Hero(
            tag: widget.character.name,
            child: Image.network(
              widget.character.imageUrl,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Rating(value: widget.character.averageRating),
              Text("${widget.character.reviews} reviews"),
            ],
          ),
          Text(
            widget.character.name,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          Rating(
            value: lastStarClicked.toDouble(),
            color: Colors.deepPurple,
            onValueClicked: (int value) {
              setState(() {
                lastStarClicked = value;
                widget.character.addReview(value);
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Icon(Icons.fitness_center),
                  const Text("Força"),
                  Text("${widget.character.strenght}"),
                ],
              ),
              Column(
                children: [
                  const Icon(Icons.auto_fix_normal),
                  const Text("Màgia"),
                  Text("${widget.character.magic}"),
                ],
              ),
              Column(
                children: [
                  const Icon(Icons.speed),
                  const Text("Velocitat"),
                  Text("${widget.character.speed}"),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
