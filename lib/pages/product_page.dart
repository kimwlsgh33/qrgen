import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/bloc/license_bloc.dart';
import 'package:todos/bloc/product_bloc.dart';
import 'package:todos/components/buy_btn.dart';
import 'package:todos/components/loading.dart';
import 'package:todos/components/lock_widget.dart';
import 'package:todos/components/products_widget.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    // watch() : refresh build() when state change (from BlocBuilder)
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            _DefaultItems(),
            SizedBox(height: 50),
            _PayItems(),
          ],
        ),
      ),
    );
  }
}

class _DefaultItems extends StatelessWidget {
  const _DefaultItems();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProductBloc>().state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'Default Products',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        const SizedBox(height: 16),
        // observe state & show widget
        if (state is LoadingProductState) const Loading(),
        if (state is LoadedProductState)
          ProductsWidget(
              items: List.generate(state.defaultItems?.length ?? 0,
                  (index) => state.defaultItems![index])),
      ],
    );
  }
}

class _PayItems extends StatelessWidget {
  const _PayItems();
  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProductBloc>().state;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          'Pay Products',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
      const SizedBox(height: 16),
      // observe state & show widget
      if (state is LoadingProductState) const Loading(),
      if (state is LoadedProductState && state.payItems == null)
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const LockWidget(),
            BuyBtn(
              onTap: () => context.read<LicenseBloc>().add(BuyLicenseEvent()),
            ),
          ],
        ),
      if (state is LoadedProductState && state.payItems != null)
        ProductsWidget(
            items: List.generate(state.payItems?.length ?? 0,
                (index) => state.payItems![index])),
    ]);
  }
}

        //======================================================================
        // control multiple blocs - From UI
        //======================================================================
        // Listener, handle multiple blocs
        // child: BlocListener<LicenseBloc, LicenseState>(
        //   listener: (context, state) {
        //     if (state.hasLicense) {
        //       context
        //           .read<ProductBloc>()
        //           .add(PayLoadProductEvent(state.hasLicense));
        //     }
        //   },
