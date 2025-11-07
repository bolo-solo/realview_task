import 'package:flutter/material.dart';

import '../../../../domain/model/author.dart';
import 'authors_list_item_stats.dart';
import 'authors_list_item_top_work.dart';

class AuthorsListItemDetails extends StatelessWidget {
  const AuthorsListItemDetails({required this.author, super.key});

  final Author author;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          author.authorName,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        if (author.topWork.isNotEmpty) ...[
          AuthorsListItemTopWork(authorTopWork: author.topWork),
          const SizedBox(height: 8),
        ],
        AuthorsListItemStats(author: author),
      ],
    );
  }
}
