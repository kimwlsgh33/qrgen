import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/bloc/license_bloc.dart';
import 'package:todos/bloc/product_bloc.dart';
import 'package:todos/bloc/simple_observer.dart';
import 'package:todos/pages/product_page.dart';
import 'package:todos/repository/license_repository.dart';
import 'package:todos/repository/product_repository.dart';

void main(List<String> args) {
  Bloc.observer = SimpleObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // MultiRepositoryProvider : save repository to context
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (_) => LicenseRepository()),
          RepositoryProvider(create: (_) => ProductRepository()),
        ],
        // MultiBlocProvider : save bloc to context
        child: MultiBlocProvider(
          providers: [
            BlocProvider<LicenseBloc>(
              // initial state - read license from repository
              create: (context) => LicenseBloc(
                context.read<LicenseRepository>(),
              ),
            ),
            BlocProvider<ProductBloc>(
              // initial state - read license from repository
              create: (context) => ProductBloc(
                context.read<ProductRepository>(),
                context.read<LicenseRepository>(),
              ),
            ),
          ],
          child: const ProductPage(),
        ),
      ),
    );
  }
}
