import 'package:flutter/material.dart';

import '../router/app_router.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    routerConfig: appRouter,
    title: 'Flutter Demo',
    //todo wrap with responsivnesss/theme if time will allow
    builder: (context, child) => child!,
    debugShowCheckedModeBanner: false,
  );
}
