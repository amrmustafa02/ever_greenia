import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/core/widgets/default_header.dart';
import 'package:plants_app/core/widgets/my_scaffold.dart';
import '../cubit/profile_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return const _ProfilePageBody();
        },
      ),
    );
  }
}

class _ProfilePageBody extends StatelessWidget {
  const _ProfilePageBody();

  @override
  Widget build(BuildContext context) {
    return const MyScaffold(
      child: SafeArea(
        child: Column(
          children: [
            DefaultHeader(title: "Profile"),
          ],
        ),
      ),
    );
  }
}
