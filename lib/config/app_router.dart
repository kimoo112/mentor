import 'package:go_router/go_router.dart';
import 'package:mentor/presentation/views/news.dart';

import '../presentation/views/home.dart';
import 'routes.dart';

class AppRouter {
 static final appRouter = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: news,
        builder: (context, state) => const NewsScreen(),
      ),
    ],
  );
}
