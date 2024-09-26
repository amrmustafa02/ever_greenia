import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/core/di/di.dart';
import 'package:plants_app/features/home/presentation/widgets/home_page_body.dart';
import '../cubit/home_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    log("HomePage: build");
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..loadProductsAndCategories(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeInitial) {
            return Skeletonizer(
              ignorePointers: true,
              child: HomePageBody(
                key: const ValueKey("HomePageBody"),
                categories: context.read<HomeCubit>().categories,
                curProducts: context.read<HomeCubit>().curProducts,
              ),
            );
          }
          if (state is HomeLoadedSuccess) {
            return HomePageBody(
              key: const ValueKey("HomePageBody"),
              categories: context.read<HomeCubit>().categories,
              curProducts: context.read<HomeCubit>().curProducts,
            );
          }
          return SizedBox.fromSize();
        },
      ),
    );
  }
}
