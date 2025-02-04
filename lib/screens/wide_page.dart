import 'package:flutter/material.dart';
import 'package:harry_potter/screens/character_detail.dart';
import 'package:harry_potter/screens/character_list.dart';
import 'package:harry_potter/services/preferences.dart';

class WidePage extends StatefulWidget {
  const WidePage({super.key});

  @override
  State<WidePage> createState() => _WidePageState();
}

class _WidePageState extends State<WidePage> {
  int? characterSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Welcome to Hogwarts"),
          actions: [
            Switch(
              value: Preferences.instance.getShowSubtitles(),
              onChanged: (value) {
                Preferences.instance.setShowSubtitles(value);
                setState(() {});
              },
            )
          ],
        ),
        body: Row(
          children: [
            Flexible(
                flex: 1,
                child: CharacterList(
                  isNarrow: false,
                  onCharacterTapped: (int value) {
                    characterSelected = value;
                    setState(() {});
                  },
                )),
            if (characterSelected == null)
              const Flexible(
                  flex: 2,
                  child: Center(
                      child: Text("Si us plau, selecciona un personatge")))
            else
              Flexible(
                flex: 2,
                child: CharacterDetail(isNarrow: false, id: characterSelected!),
              ),
          ],
        ));
  }
}
