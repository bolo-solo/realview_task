import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/consts/name_consts.dart';
import '../../../../router/app_routes.dart';
import '../bloc/authors_view_bloc.dart';
import '../bloc/authors_view_event.dart';
import '../bloc/authors_view_state.dart';
import '../widgets/list/authors_list_item.dart';
import '../widgets/search_input/authors_search_input.dart';
import 'authors_view_provider.dart';

class AuthorsView extends StatelessWidget {
  const AuthorsView({super.key});

  @override
  Widget build(BuildContext context) => AuthorsViewProvider(
    child: BlocBuilder<AuthorsViewBloc, AuthorsViewState>(
      builder: (context, state) => SafeArea(bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: AuthorsSearchInput(
                onSearch: (query) {
                  context.read<AuthorsViewBloc>().add(
                    AuthorsViewEvent.queryChanged(query),
                  );
                },
                initialValue: NameConsts.initialInputValue,
              ),
            ),
            Expanded(
              child: state.when(
                initial: () => const Center(child: Text('Initial State')),
                loading: () => const Center(child: CircularProgressIndicator()),
                loaded: (authors, query) => ListView.builder(
                  itemCount: authors.length,
                  itemBuilder: (context, index) => AuthorsListItem(
                    author: authors[index],
                    onClick: () {
                      context.push(AppRoutes.authorDetails.path);
                    },
                  ),
                ),
                loadingError: (message) =>
                    Center(child: Text('Error: $message')),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
