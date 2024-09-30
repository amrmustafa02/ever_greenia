import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plants_app/features/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:plants_app/features/product_details/presentation/widgets/counter_button.dart';

class CounterSection extends StatelessWidget {
  const CounterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      buildWhen: (_, state) =>
          state is ProductDetailsInitial || state is UpdateQuantitySectionState,
      builder: (context, state) {
        var cubit = context.read<ProductDetailsCubit>();
        return Stack(
          alignment: Alignment.center,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: CounterButton(
                isRight: false,
                onPressed: cubit.decreaseQuantity,
              ),
            ),
            cubit.curClickIsRight
                ? AnimatedSwitcherPlus.translationLeft(
                    switchInCurve: Curves.easeInCubic,
                    key: cubit.switcherKey,
                    duration: const Duration(milliseconds: 750),
                    child: _buildText(cubit),
                  )
                : AnimatedSwitcherPlus.translationRight(
                    key: cubit.switcherKey,
                    switchInCurve: Curves.easeInCubic,
                    duration: const Duration(milliseconds: 750),
                    child: _buildText(cubit),
                  ),
            Align(
              alignment: Alignment.topRight,
              child: CounterButton(
                isRight: true,
                onPressed: cubit.increaseQuantity,
              ),
            )
          ],
        );
      },
    );
  }

  Text _buildText(ProductDetailsCubit cubit) {
    return Text(
      cubit.quantity.toString(),
      key: ValueKey<int>(cubit.quantity),
      style: GoogleFonts.readexPro().copyWith(
        color: Colors.black,
        fontSize: 62,
      ),
    );
  }
}
