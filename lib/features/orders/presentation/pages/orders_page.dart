import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/core/widgets/default_header.dart';
import 'package:plants_app/core/widgets/my_scaffold.dart';
import '../cubit/orders_cubit.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersCubit(),
      child: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          return const _OrdersPageBody();
        },
      ),
    );
  }
}

class _OrdersPageBody extends StatelessWidget {
  const _OrdersPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyScaffold(
      child: SafeArea(
        child: Column(
          children: [
            DefaultHeader(
              title: "My Orders",
            ),
          ],
        ),
      ),
    );
  }
}
