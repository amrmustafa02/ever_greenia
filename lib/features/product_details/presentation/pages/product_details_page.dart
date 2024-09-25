import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plants_app/core/extensions/context_extension.dart';
import 'package:plants_app/features/home/domain/entities/product_data.dart';
import 'package:plants_app/features/product_details/presentation/widgets/prodcut_image_section.dart';
import 'package:plants_app/features/product_details/presentation/widgets/add_to_cart_section.dart';
import 'package:plants_app/features/product_details/presentation/widgets/counter_section.dart';
import 'package:plants_app/features/product_details/presentation/widgets/product_details_header.dart';

import '../cubit/product_details_cubit.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductData product;
  final String categoryName;

  const ProductDetailsPage({
    super.key,
    required this.product,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailsCubit()..initProduct(product),
      child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          return _ProductDetailsPageBody();
        },
      ),
    );
  }
}

class _ProductDetailsPageBody extends StatelessWidget {
  const _ProductDetailsPageBody();

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ProductDetailsCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ProductDetailsHeader(),
            const Spacer(),
            SizedBox(
              height: context.height * 0.35,
              width: context.width,
              child: ProductImageSection(index: cubit.product.id),
            ),
            const SizedBox(height: 16),
            Text(
              cubit.product.description,
              textAlign: TextAlign.center,
              style: GoogleFonts.readexPro().copyWith(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const Spacer(),
            const CounterSection(),
            const Spacer(),
            const AddToCartSection(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
