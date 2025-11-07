final class AppRoute {
  const AppRoute({required this.name, required this.path});
  final String name;
  final String path;
}

final class AppRoutes {
  static const authorsView = AppRoute(name: 'authorsView', path: '/');
  static const authorDetails = AppRoute(name: 'authorDetails', path: '/authorDetails');
}
