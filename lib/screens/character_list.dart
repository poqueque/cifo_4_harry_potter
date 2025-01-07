import 'package:flutter/material.dart';
import 'package:harry_potter/providers/hogwarts_data.dart';
import 'package:harry_potter/screens/character_detail.dart';
import 'package:provider/provider.dart';

class CharacterList extends StatelessWidget {
  const CharacterList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome to Hogwarts"),
      ),
      body: Consumer<HogwartsData>(builder: (context, hogwartsData, child) {
        return ListView(
          children: [
            for (var character in hogwartsData.characters)
              ListTile(
                leading: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Hero(
                    tag: character.name,
                    child: Image.network(character.imageUrl),
                  ),
                ),
                title: Text(character.name),
                subtitle: Text("${character.reviews} reviews"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CharacterDetail(id: character.id),
                    ),
                  );
                },
                trailing: InkWell(
                  onTap: () {
                    hogwartsData.toggleFavorite(character.id);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(character.favorite
                        ? Icons.favorite
                        : Icons.favorite_border),
                  ),
                ),
              )
          ],
        );
      }),
    );
  }
}
