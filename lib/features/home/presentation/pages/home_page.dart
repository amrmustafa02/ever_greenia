import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/core/di/di.dart';
import 'package:plants_app/core/utils/herlper_methods.dart';
import 'package:plants_app/features/home/presentation/widgets/home_page_body.dart';
import 'package:plants_app/features/home/presentation/widgets/home_page_error.dart';
import '../cubit/home_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    log("HomePage: build");
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..loadProductsAndCategories(),
      child: BlocConsumer<HomeCubit, HomeState>(
        buildWhen: (previous, current) =>
            current is HomeInitial ||
            current is HomeLoadedSuccess ||
            current is HomeLoadedFailure,
        listenWhen: (previous, current) =>
            current is AddToCartLoadingState ||
            current is AddToCartSuccessState ||
            current is AddToCartFailureState,
        builder: (context, state) {
          if (state is HomeLoadedFailure) {
            return RefreshIndicator(
              onRefresh: () async {
                await context.read<HomeCubit>().refresh();
              },
              child: const HomePageError(),
            );
          }

          var cub = context.read<HomeCubit>();

          return Skeletonizer(
            // shade: cub.isLoading,
            enabled: cub.isLoading,
            key: const ValueKey("HomePageSkeleton"),
            // ignorePointers: cub.isLoading,
            // enabled: cub.isLoading,
            child: HomePageBody(
              key: const ValueKey("HomePageBody"),
              categories: context.read<HomeCubit>().categories,
              curProducts: context.read<HomeCubit>().curProducts,
            ),
          );
        },
        listener: (BuildContext context, HomeState state) {
          log("HomePage: listener");
          if (state is AddToCartLoadingState) {
            HelperMethods.showLoadingDliaog(context);
          }
          if (state is AddToCartSuccessState) {
            Navigator.pop(context);
            HelperMethods.showSuccessNotificationToast(
              "Added to cart successfully",
            );
          }
          if (state is AddToCartFailureState) {
            Navigator.pop(context);
            HelperMethods.showErrorNotificationToast(
              state.error,
            );
          }
        },
      ),
    );
  }
}
