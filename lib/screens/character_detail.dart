import 'package:flutter/material.dart';
import 'package:harry_potter/models/character.dart';
import 'package:harry_potter/providers/hogwarts_data.dart';
import 'package:harry_potter/widgets/rating.dart';
import 'package:provider/provider.dart';

class CharacterDetail extends StatefulWidget {
  const CharacterDetail({super.key, required this.id});

  final int id;

  @override
  State<CharacterDetail> createState() => _CharacterDetailState();
}

class _CharacterDetailState extends State<CharacterDetail> {
  int lastStarClicked = 0;

  @override
  Widget build(BuildContext context) {
    HogwartsData hogwartsData = context.read<HogwartsData>();
    Character character = hogwartsData.getCharacterById(widget.id);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Harry Potter App"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Hero(
            tag: character.name,
            child: Image.network(
              character.imageUrl,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Rating(value: character.averageRating),
              Text("${character.reviews} reviews"),
              InkWell(
                onTap: () {
                  hogwartsData.toggleFavorite(character.id);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Consumer<HogwartsData>(
                      builder: (context, hogwartsData, child) {
                    return Icon(character.favorite
                        ? Icons.favorite
                        : Icons.favorite_border);
                  }),
                ),
              )
            ],
          ),
          Text(
            character.name,
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
                hogwartsData.addReview(character.id, value);
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
                  Text("${character.strenght}"),
                ],
              ),
              Column(
                children: [
                  const Icon(Icons.auto_fix_normal),
                  const Text("Màgia"),
                  Text("${character.magic}"),
                ],
              ),
              Column(
                children: [
                  const Icon(Icons.speed),
                  const Text("Velocitat"),
                  Text("${character.speed}"),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
