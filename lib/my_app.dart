import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/core/cubit/cart/cubit/cart_cubit.dart';
import 'package:plants_app/core/cubit/main_cubit/main_cubit.dart';
import 'package:plants_app/core/di/di.dart';
import 'package:plants_app/core/routing/app_router.dart';
import 'package:plants_app/core/theme/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:toastification/toastification.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<MainCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<CartCubit>()..getCart(),
        ),
      ],
      child: BlocBuilder<MainCubit, MainState>(
        buildWhen: (context, state) => state is MainInitial,
        builder: (context, state) {
          return ResponsiveSizer(
            builder: (context, o, s) {
              return ToastificationWrapper(
                child: MaterialApp(
                  title: 'Plants App',
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    scaffoldBackgroundColor: Colors.white,
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: AppColors.lightGreen,
                    ),
                    useMaterial3: true,
                  ),
                  onGenerateRoute: (settings) =>
                      AppRouter.generateRoute(settings),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
