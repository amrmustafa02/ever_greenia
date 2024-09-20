import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/splash_cubit.dart';
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(),
      child: BlocBuilder<SplashCubit,
          SplashState>(
        builder: (context, state) {
          return const _SplashPageBody();
        },
      ),
    );
  }
}
class _SplashPageBody extends StatelessWidget {
  const _SplashPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

