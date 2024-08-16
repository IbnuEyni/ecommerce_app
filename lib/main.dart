import 'package:ecommerce_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'features/product/presentation/bloc/create_bloc/create_bloc.dart';
import 'features/product/presentation/bloc/delete_bloc/delete_bloc.dart';
import 'features/product/presentation/bloc/detail_bloc/detail_bloc.dart';
import 'features/product/presentation/bloc/list_products/list_products_bloc.dart';
import 'features/product/presentation/bloc/update_bloc/update_bloc.dart';
import 'features/product/presentation/pages/List_products_page.dart';
import 'features/product/presentation/pages/create_page.dart';
import 'features/product/presentation/pages/detail_page.dart';
import 'features/product/presentation/pages/serch_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure that Flutter's binding is initialized
  // Bloc.observer = SimpleBlocObserver();

  await di.init(); // Initializes dependency injection

  runApp(MyApp());
}

// GoRouter configuration
final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'list-products',
      path: '/',
      builder: (context, state) {
        return ListProductsPage();
      },
      routes: <RouteBase>[
        // Add child routes
        GoRoute(
          path:
              'detail', // NOTE: Don't need to specify "/" character for router’s parents
          builder: (context, state) {
            return DetailPage();
          },
          routes: <RouteBase>[
            GoRoute(
              name: 'update',
              path: 'update',
              builder: (context, state) {
                return CreatePage();
              },
            )
          ],
        ),
        GoRoute(
          name: 'create',
          path: 'create',
          builder: (context, state) {
            return CreatePage();
          },
        ),
        GoRoute(
          name: 'search',
          path: 'search',
          builder: (context, state) {
            return SearchPage();
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ListProductsBloc>()),
        BlocProvider(create: (_) => sl<DetailBloc>()),
        BlocProvider(create: (_) => sl<CreateBloc>()),
        BlocProvider(create: (_) => sl<UpdateBloc>()),
        BlocProvider(create: (_) => sl<DeleteBloc>()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
      ),
    );
  }
}
