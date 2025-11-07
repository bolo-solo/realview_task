import 'package:go_router/go_router.dart';

import '../feature/presentation/author_details/view/author_details_view.dart';
import '../feature/presentation/authors/view/authors_view.dart';
import 'app_routes.dart';

final appRouter = GoRouter(
  initialLocation: AppRoutes.authorsView.path,
  routes: [
    GoRoute(
      path: AppRoutes.authorsView.path,
      name: AppRoutes.authorsView.name,
      builder: (context, state) => const AuthorsView(),
    ),
    GoRoute(
      path: AppRoutes.authorDetails.path,
      name: AppRoutes.authorDetails.name,
      builder: (context, state) => const AuthorDetailsView(),
    ),
  ],
);
