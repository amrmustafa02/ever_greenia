import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/onboarding_cubit.dart';
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: BlocBuilder<OnboardingCubit,
          OnboardingState>(
        builder: (context, state) {
          return const _OnboardingPageBody();
        },
      ),
    );
  }
}
class _OnboardingPageBody extends StatelessWidget {
  const _OnboardingPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

