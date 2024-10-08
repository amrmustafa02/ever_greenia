import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:plants_app/core/entities/product_data.dart';
import 'package:plants_app/core/extensions/context_extension.dart';
import 'package:plants_app/core/widgets/my_default_image.dart';
import 'package:plants_app/features/home/presentation/cubit/home_cubit.dart';

class SearchListItem extends StatelessWidget {
  final ProductData product;

  const SearchListItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () {
        context.goToProductDetails(
          product: product,
          categoryName: context.read<HomeCubit>().getCategoryName(product.categoryId),
        );
        // context.read<HomeCubit>().onCloseSearch();
      },
      child: ListTile(
        leading: MyDefaultImage(
          url: product.image,
        ),
        title: Text(product.name),
        subtitle: Text(product.description,
            maxLines: 1, overflow: TextOverflow.ellipsis),
        trailing: Text("${product.price}\$"),
      ),
    );
  }
}
