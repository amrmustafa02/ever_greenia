import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/core/widgets/default_header.dart';
import 'package:plants_app/core/widgets/my_scaffold.dart';
import '../cubit/place_order_cubit.dart';

class PlaceOrderPage extends StatelessWidget {
  const PlaceOrderPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlaceOrderCubit(),
      child: BlocBuilder<PlaceOrderCubit, PlaceOrderState>(
        builder: (context, state) {
          return const _PlaceOrderPageBody();
        },
      ),
    );
  }
}

class _PlaceOrderPageBody extends StatelessWidget {
  const _PlaceOrderPageBody();

  @override
  Widget build(BuildContext context) {
    return const MyScaffold(
      child: Column(
        children: [
          SafeArea(
            child: DefaultHeader(
              title: "Place Order",
            ),
          ),
      
        ],
      ),
    );
  }
}
