import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../bloc/authors_view_bloc.dart';
import '../bloc/authors_view_event.dart';

class AuthorsViewProvider extends StatelessWidget {
  const AuthorsViewProvider({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) =>
        GetIt.I.get<AuthorsViewBloc>()..add(const AuthorsViewEvent.init()),
    child: Scaffold(body: child),
  );
}
