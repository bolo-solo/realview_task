import 'package:flutter/material.dart';

class AuthorsListItemTopWork extends StatelessWidget {
  const AuthorsListItemTopWork({required this.authorTopWork, super.key});
  final String authorTopWork;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(Icons.book_outlined, size: 16, color: theme.colorScheme.secondary),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            authorTopWork,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              fontStyle: FontStyle.italic,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
