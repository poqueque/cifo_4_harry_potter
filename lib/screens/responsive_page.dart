import 'package:flutter/material.dart';
import 'package:harry_potter/screens/character_list.dart';
import 'package:harry_potter/screens/wide_page.dart';

class ResponsivePage extends StatelessWidget {
  const ResponsivePage({super.key});

  @override
  Widget build(BuildContext context) {  
    return LayoutBuilder(builder: (context, contraints) {
      if (contraints.maxWidth > 600) {
        return const WidePage();
      } else {
        return const CharacterList();
      }
    });
  }
}
