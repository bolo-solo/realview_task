import 'package:flutter/material.dart';

import '../../../../domain/model/author.dart';
import 'authors_list_item_avatar.dart';
import 'authors_list_item_details.dart';

class AuthorsListItem extends StatelessWidget {
  const AuthorsListItem({
    required this.author,
    required this.onClick,
    super.key,
  });

  final Author author;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onClick,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuthorsListItemAvatar(authorName: author.authorName),
              const SizedBox(width: 16),
              Expanded(child: AuthorsListItemDetails(author: author)),
              Icon(
                Icons.chevron_right_rounded,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
