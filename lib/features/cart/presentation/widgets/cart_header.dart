import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/core/cubit/cart/cubit/cart_cubit.dart';
import 'package:plants_app/core/widgets/default_header.dart';

class CartHeader extends StatelessWidget {
  const CartHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        const DefaultHeader(title: "Cart"),
        BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            return Visibility(
              visible: context.read<CartCubit>().isLoading,
              child: const Align(
                alignment: Alignment.bottomCenter,
                child: LinearProgressIndicator(),
              ),
            );
          },
        )
      ],
    );
  }
}
