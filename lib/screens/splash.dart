import 'package:flutter/material.dart';
import 'package:harry_potter/providers/hogwarts_data.dart';
import 'package:harry_potter/screens/responsive_page.dart';
import 'package:harry_potter/services/database.dart';
import 'package:harry_potter/services/preferences.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String status = "Inicialitzant l'applicació";

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 1));
    status = "Carregant objecte de Preferències";
    setState(() {});
    await Preferences.instance.init();
    status = "Preferències carregades";
    setState(() {});
    await Database.instance.init();
    status = "Base de dades inicialitzada";
    setState(() {});
    if (!mounted) return;
    HogwartsData hogwartsData = context.read<HogwartsData>();
    await hogwartsData.init();
    status = "Dades carregades";
    setState(() {});
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const ResponsivePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(status),
          ],
        ),
      ),
    );
  }
}
