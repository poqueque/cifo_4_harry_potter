import 'package:flutter/material.dart';
import 'package:harry_potter/models/character.dart';
import 'package:harry_potter/screens/character_detail.dart';

class CharacterList extends StatelessWidget {
  const CharacterList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome to Hogwarts"),
      ),
      body: ListView(
        children: [
          for (var character in characters)
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(2),
                child: Hero(
                  tag: character.name,
                  child: Image.network(character.imageUrl),
                ),
              ),
              title: Text(character.name),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CharacterDetail(character: character),
                  ),
                );
              },
            )
        ],
      ),
    );
  }
}
