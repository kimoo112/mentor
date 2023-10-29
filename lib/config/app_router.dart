import 'package:go_router/go_router.dart';
import 'package:mentor/presentation/views/news.dart';

import '../presentation/views/home.dart';
import 'utils/routes.dart';

class AppRouter {
 static final appRouter = GoRouter(
    initialLocation:home,
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
