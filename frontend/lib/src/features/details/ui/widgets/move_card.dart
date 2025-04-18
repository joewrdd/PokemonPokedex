import 'package:flutter/material.dart';

class MoveCard extends StatelessWidget {
  final String moveName;
  final String learnMethod;
  final int? levelLearnedAt;
  final Color color;

  const MoveCard({
    super.key,
    required this.moveName,
    required this.learnMethod,
    this.levelLearnedAt,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    IconData methodIcon;
    String methodText;
    Color methodColor;

    // Determine icon and text based on learn method
    switch (learnMethod) {
      case 'level-up':
        methodIcon = Icons.arrow_upward;
        methodText =
            levelLearnedAt != null ? 'Level ${levelLearnedAt}' : 'Level up';
        methodColor = Colors.green;
        break;
      case 'machine':
        methodIcon = Icons.disc_full;
        methodText = 'TM/HM';
        methodColor = Colors.blue;
        break;
      case 'egg':
        methodIcon = Icons.egg_alt;
        methodText = 'Breeding';
        methodColor = Colors.amber;
        break;
      case 'tutor':
        methodIcon = Icons.school;
        methodText = 'Move Tutor';
        methodColor = Colors.purple;
        break;
      default:
        methodIcon = Icons.videogame_asset;
        methodText = 'Special';
        methodColor = Colors.grey;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {}, // Optional tap effect
            splashColor: color.withOpacity(0.1),
            highlightColor: color.withOpacity(0.05),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  // Left part with icon
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: methodColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      methodIcon,
                      color: methodColor,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Move details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          moveName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: methodColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                methodText,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: methodColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Right arrow icon
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey[400],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
