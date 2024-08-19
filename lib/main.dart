import 'features/product/presentation/pages/update_page.dart';

import 'bloc_observer.dart';
import 'injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'features/product/presentation/bloc/create_bloc/create_bloc.dart';
import 'features/product/presentation/bloc/delete_bloc/delete_bloc.dart';
import 'features/product/presentation/bloc/detail_bloc/detail_bloc.dart';
import 'features/product/presentation/bloc/list_products/list_products_bloc.dart';
import 'features/product/presentation/bloc/update_bloc/update_bloc.dart';
import 'features/product/presentation/pages/create_page.dart';
import 'features/product/presentation/pages/List_products_page.dart';
import 'features/product/presentation/pages/serch_page.dart';
import 'features/product/presentation/pages/detail_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure that Flutter's binding is initialized
  Bloc.observer = SimpleBlocObserver();

  await di.init(); // Initializes dependency injection

  runApp(MyApp());
}

// GoRouter configuration
final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const ListProductsPage();
      },
    ),
    GoRoute(
      name: 'detail',
      path: '/detail/:id',
      builder: (context, state) {
        final String id = state.pathParameters['id']!;
        return DetailPage(id: id);
      },
    ),
    GoRoute(
      name: 'create',
      path: '/create',
      builder: (context, state) {
        return CreatePage();
      },
    ),
    GoRoute(
      name: 'update',
      path: '/update/:id',
      builder: (context, state) {
        final String id = state.pathParameters['id']!;
        return AddItemPage(id: id);
      },
    ),
    GoRoute(
      name: 'search',
      path: '/search',
      builder: (context, state) {
        return const SearchPage();
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
