import 'package:flutter/material.dart';
import 'package:pokedex/src/features/details/repo/provider/pokemon_details_provider.dart';
import 'package:pokedex/src/features/home/repo/provider/pokemon_provider.dart';
import 'package:pokedex/src/features/home/ui/home_screen.dart';
import 'package:pokedex/src/features/search/repo/provider/search_provider.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SearchProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PokemonProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PokemonDetailsProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: Color.fromARGB(255, 205, 53, 53),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
