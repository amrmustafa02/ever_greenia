import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plants_app/core/cubit/cart/cubit/cart_cubit.dart';
import 'package:plants_app/core/extensions/context_extension.dart';

class CartHeader extends StatelessWidget {
  const CartHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            onPressed: () {
              context.goBack();
            },
            icon: const Icon(Icons.arrow_back_ios_rounded),
          ),
        ),
        Text(
          "Cart",
          style: GoogleFonts.readexPro().copyWith(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: Visibility(
                visible: context.read<CartCubit>().isLoadig,
                child: const Align(
                  alignment: Alignment.bottomCenter,
                  child: LinearProgressIndicator(),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
