import 'package:flutter/material.dart';
import 'package:plants_app/core/routing/app_router.dart';
import 'package:plants_app/core/theme/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PlantsApp extends StatelessWidget {
  const PlantsApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, o, s) {
        return MaterialApp(
          title: 'Plants App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.lightGreen,
            ),
            useMaterial3: true,
          ),
          onGenerateRoute: (settings) => AppRouter.generateRoute(settings),
          // initialRoute: RoutesName.onboarding,
          
        );
      },
    );
  }
}
