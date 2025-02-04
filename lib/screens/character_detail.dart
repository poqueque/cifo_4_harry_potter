import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:harry_potter/models/character.dart';
import 'package:harry_potter/providers/hogwarts_data.dart';
import 'package:harry_potter/widgets/rating.dart';
import 'package:provider/provider.dart';

class CharacterDetail extends StatefulWidget {
  const CharacterDetail({super.key, required this.id, this.isNarrow = true});

  final int id;
  final bool isNarrow;

  @override
  State<CharacterDetail> createState() => _CharacterDetailState();
}

class _CharacterDetailState extends State<CharacterDetail> {
  int lastStarClicked = 0;

  @override
  Widget build(BuildContext context) {
    var l = AppLocalizations.of(context)!;
    HogwartsData hogwartsData = context.read<HogwartsData>();
    Character character = hogwartsData.getCharacterById(widget.id);

    return Scaffold(
      appBar: widget.isNarrow
          ? AppBar(
              title: Text(l.characterDetails(character.name)),
            )
          : null,
      body: SingleChildScrollView(
        child: Column(
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
                Flexible(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(l.nReviews(character.reviews)),
                )),
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
                    Text(l.strenght),
                    Text("${character.strenght}"),
                  ],
                ),
                Column(
                  children: [
                    const Icon(Icons.auto_fix_normal),
                    Text(l.magic),
                    Text("${character.magic}"),
                  ],
                ),
                Column(
                  children: [
                    const Icon(Icons.speed),
                    Text(l.speed),
                    Text("${character.speed}"),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
