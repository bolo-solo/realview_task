import 'package:flutter/material.dart';

import 'search_input_background.dart';
import 'search_input_button.dart';

class AuthorsSearchInput extends StatefulWidget {
  const AuthorsSearchInput({
    required this.onSearch,
    required this.initialValue,
    super.key,
  });

  final ValueChanged<String> onSearch;
  final String initialValue;

  @override
  State<AuthorsSearchInput> createState() => _AuthorsSearchInputState();
}

class _AuthorsSearchInputState extends State<AuthorsSearchInput> {
  late final TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleSearch() {
    widget.onSearch(_controller.text.trim());
    _focusNode.unfocus();
  }

  void _handleClear() {
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SearchInputBackground(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 8),
            child: Icon(
              Icons.search_rounded,
              color: theme.colorScheme.primary,
              size: 24,
            ),
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              onSubmitted: (_) => _handleSearch(),
              textInputAction: TextInputAction.search,
              style: theme.textTheme.bodyLarge,
              decoration: InputDecoration(
                hintText: 'Search authors...',
                hintStyle: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
              ),
            ),
          ),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: _controller,
            builder: (context, value, child) {
              if (value.text.isEmpty) {
                return const SizedBox.shrink();
              }
              return IconButton(
                onPressed: _handleClear,
                icon: Icon(
                  Icons.close_rounded,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
                tooltip: 'Clear',
                splashRadius: 20,
              );
            },
          ),
          SearchInputButton(onClick: _handleSearch),
        ],
      ),
    );
  }
}
