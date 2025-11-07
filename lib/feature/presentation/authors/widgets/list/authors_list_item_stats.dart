import 'package:flutter/material.dart';

import '../../../../domain/model/author.dart';
import 'stat_chip.dart';

class AuthorsListItemStats extends StatelessWidget {
  const AuthorsListItemStats({required this.author, super.key});

  final Author author;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Wrap(
      spacing: 12,
      runSpacing: 6,
      children: [
        StatChip(
          icon: Icons.star_rounded,
          label: author.ratingsAverage.toStringAsFixed(1),
          color: Colors.amber,
        ),
        StatChip(
          icon: Icons.menu_book_rounded,
          label: '${author.workCount} works',
          color: theme.colorScheme.primary,
        ),
        if (author.currentlyReading > 0)
          StatChip(
            icon: Icons.people_outline_rounded,
            label: '${author.currentlyReading} reading',
            color: Colors.green,
          ),
      ],
    );
  }
}
