import 'package:flutter/material.dart';

class StatBar extends StatelessWidget {
  final String statName;
  final int statValue;
  final Color color;

  const StatBar({
    super.key,
    required this.statName,
    required this.statValue,
    required this.color,
  });

  String _getStatAbbreviation(String statName) {
    switch (statName.toLowerCase()) {
      case 'hp':
        return 'HP';
      case 'attack':
        return 'ATK';
      case 'defense':
        return 'DEF';
      case 'special-attack':
        return 'SP.ATK';
      case 'special-defense':
        return 'SP.DEF';
      case 'speed':
        return 'SPD';
      default:
        return statName.substring(0, 3).toUpperCase();
    }
  }

  Color _getStatColor(String statName) {
    switch (statName.toLowerCase()) {
      case 'hp':
        return Colors.red.shade400;
      case 'attack':
        return Colors.orange.shade400;
      case 'defense':
        return Colors.blue.shade400;
      case 'special-attack':
        return Colors.purple.shade400;
      case 'special-defense':
        return Colors.green.shade400;
      case 'speed':
        return Colors.pink.shade400;
      default:
        return color;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Maximum base stat is typically 255
    final percentage = (statValue / 255) * 100;
    final statColor = _getStatColor(statName);
    final abbreviation = _getStatAbbreviation(statName);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: statColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        abbreviation,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: statColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      statName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    statValue.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: statColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Stack(
              children: [
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Container(
                  height: 8,
                  width: (MediaQuery.of(context).size.width - 70) *
                      (percentage / 100),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        statColor.withOpacity(0.7),
                        statColor,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: statColor.withOpacity(0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
