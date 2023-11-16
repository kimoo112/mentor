import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../logic/cubit/fetch_data_cubit.dart';
import '../presentation/views/home.dart';
import '../presentation/views/news.dart';
import 'utils/routes.dart';

class AppRouter {
  static final appRouter = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(
        path: home,
        builder: (context, state) => BlocProvider(
          create: (context) => FetchDataCubit(),
          child: const HomeScreen(),
        ),
      ),
      GoRoute(
        path: news,
        builder: (context, state) => const NewsScreen(),
      ),
    ],
  );
}
