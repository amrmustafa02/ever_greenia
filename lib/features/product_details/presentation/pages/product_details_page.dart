import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plants_app/core/extensions/context_extension.dart';
import 'package:plants_app/core/entities/product_data.dart';
import 'package:plants_app/core/extensions/widget_ext.dart';
import 'package:plants_app/core/utils/herlper_methods.dart';
import 'package:plants_app/features/product_details/presentation/widgets/prodcut_image_section.dart';
import 'package:plants_app/features/product_details/presentation/widgets/add_to_cart_section.dart';
import 'package:plants_app/features/product_details/presentation/widgets/quantity_section.dart';
import 'package:plants_app/features/product_details/presentation/widgets/product_details_header.dart';

import '../../../../core/di/di.dart';
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
      create: (context) =>
          getIt<ProductDetailsCubit>()..initProduct(product, categoryName),
      child: BlocListener<ProductDetailsCubit, ProductDetailsState>(
        child: const _ProductDetailsPageBody(),
        listener: (BuildContext context, ProductDetailsState state) {
          if (state is AddProductToCartLoading) {
            HelperMethods.showLoadingDliaog(context);
          }
          if (state is AddProductToCartSuccess) {
            Navigator.pop(context);
            HelperMethods.showSuccessNotificationToast(
                "Added to cart successfully");
          }
          if (state is AddProductToCartFailure) {
            Navigator.pop(context);
            HelperMethods.showErrorNotificationToast(state.error);
          }
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
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: context.height * 0.35,
                    width: context.width,
                    child: ProductImageSection(tagId: cubit.product.id),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    cubit.product.description,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.readexPro().copyWith(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ).setHorizontalPadding(),
                ],
              ),
            ),
            const Spacer(),
            const QuantitySection(),
            const Spacer(),
            const AddToCartSection(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
