import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/src/features/details/models/pokemon_details_model.dart';
import 'package:pokedex/src/features/details/repo/provider/pokemon_details_provider.dart';
import 'package:pokedex/src/features/details/ui/widgets/ability_card.dart';
import 'package:pokedex/src/features/details/ui/widgets/info_row.dart';
import 'package:pokedex/src/features/details/ui/widgets/move_card.dart';
import 'package:pokedex/src/features/details/ui/widgets/stat_bar.dart';
import 'package:pokedex/src/features/home/models/pokemon_model.dart';
import 'package:pokedex/src/features/home/utils/color_desicion.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  final PokemonModel pokemon;

  const DetailsScreen({super.key, required this.pokemon});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    // Fetch the details
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PokemonDetailsProvider>(context, listen: false)
          .fetchPokemonDetails(widget.pokemon.id);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mainColor = getColorForType(widget.pokemon.types[0]);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Image
          Positioned(
            top: -50,
            right: -50,
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                "assets/pokeball_background_image.png",
                height: 200,
              ),
            ),
          ),

          // App Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                widget.pokemon.name,
                style: GoogleFonts.fredoka(
                    fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // Pokemon Image
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Hero(
              tag: 'pokemon_image_${widget.pokemon.id}',
              child: Center(
                child: Image.network(
                  widget.pokemon.imageURL,
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          // Pokemon Number
          Positioned(
            top: 270,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                '#${widget.pokemon.id}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: mainColor,
                ),
              ),
            ),
          ),

          // Type Pills
          Positioned(
            top: 300,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.pokemon.types.map((type) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  decoration: BoxDecoration(
                    color: getColorForType(type),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: getColorForType(type).withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    type,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Main Content
          Positioned(
            top: 350,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Tab Bar
                  TabBar(
                    controller: _tabController,
                    labelColor: mainColor,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: mainColor,
                    tabs: const [
                      Tab(text: 'About'),
                      Tab(text: 'Stats'),
                      Tab(text: 'Abilities'),
                      Tab(text: 'Moves'),
                    ],
                  ),

                  // Tab Bar View
                  Expanded(
                    child: Consumer<PokemonDetailsProvider>(
                      builder: (context, provider, child) {
                        if (provider.isLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: mainColor,
                              strokeWidth: 3,
                            ),
                          );
                        }

                        if (provider.error != null) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    color: Colors.red.shade300,
                                    size: 60,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    provider.error!,
                                    style: TextStyle(
                                      color: Colors.red.shade300,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 24),
                                  ElevatedButton(
                                    onPressed: () {
                                      Provider.of<PokemonDetailsProvider>(
                                        context,
                                        listen: false,
                                      ).fetchPokemonDetails(widget.pokemon.id);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: mainColor,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 12,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: const Text('Try Again'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        final details = provider.pokemonDetails;
                        if (details == null) {
                          return const Center(
                            child: Text('No details available'),
                          );
                        }

                        return TabBarView(
                          controller: _tabController,
                          children: [
                            // About Tab
                            _buildAboutTab(details, mainColor),

                            // Stats Tab
                            _buildStatsTab(details),

                            // Abilities Tab
                            _buildAbilitiesTab(details),

                            // Moves Tab
                            _buildMovesTab(details),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutTab(PokemonDetailsModel details, Color mainColor) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            'Pokémon Data',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: mainColor,
            ),
          ),
          const SizedBox(height: 16),

          // Info rows
          InfoRow(
            title: 'Height',
            value: '${details.height / 10} m',
            icon: Icons.height,
          ),
          InfoRow(
            title: 'Weight',
            value: '${details.weight / 10} kg',
            icon: Icons.monitor_weight,
          ),
          InfoRow(
            title: 'Base Experience',
            value: '${details.baseExperience} XP',
            icon: Icons.star,
          ),
          InfoRow(
            title: 'Primary Type',
            value: details.types[0],
            icon: Icons.category,
          ),
          if (details.types.length > 1)
            InfoRow(
              title: 'Secondary Type',
              value: details.types[1],
              icon: Icons.category_outlined,
            ),

          // Pokemon description - placeholder
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: mainColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: mainColor.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: mainColor,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Pokémon Info',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: mainColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '${details.name} is a ${details.types.join("/")} type Pokémon introduced in Generation I. It has a base experience of ${details.baseExperience} points.',
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsTab(PokemonDetailsModel details) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: details.stats.length,
        itemBuilder: (context, index) {
          final stat = details.stats[index];
          return StatBar(
            statName: stat.name,
            statValue: stat.baseStat,
            color: getColorForType(details.types[0]),
          );
        },
      ),
    );
  }

  Widget _buildAbilitiesTab(PokemonDetailsModel details) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 16),
            child: Text(
              'Abilities',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: getColorForType(details.types[0]),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: details.abilities.length,
              itemBuilder: (context, index) {
                final ability = details.abilities[index];
                return AbilityCard(
                  abilityName: ability.name,
                  isHidden: ability.isHidden,
                  color: getColorForType(details.types[0]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovesTab(PokemonDetailsModel details) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 16),
                child: Text(
                  'Moves',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: getColorForType(details.types[0]),
                  ),
                ),
              ),
              Text(
                '${details.moves.length} total',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: details.moves.length,
              itemBuilder: (context, index) {
                final move = details.moves[index];
                return MoveCard(
                  moveName: move.name,
                  learnMethod: move.learnMethod,
                  levelLearnedAt: move.levelLearnedAt,
                  color: getColorForType(details.types[0]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
