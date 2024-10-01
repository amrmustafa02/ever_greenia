import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plants_app/core/di/di.dart';
import 'package:plants_app/core/extensions/widget_ext.dart';
import 'package:plants_app/core/theme/app_font_styles.dart';
import 'package:plants_app/core/widgets/default_header.dart';
import 'package:plants_app/core/widgets/my_scaffold.dart';
import 'package:plants_app/features/place_order/presentation/widgets/maps_section.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../cubit/place_order_cubit.dart';

class PlaceOrderPage extends StatelessWidget {
  const PlaceOrderPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PlaceOrderCubit>()..getCurrentLocation(),
      child: const _PlaceOrderPageBody(),
    );
  }
}

class _PlaceOrderPageBody extends StatelessWidget {
  const _PlaceOrderPageBody();

  @override
  Widget build(BuildContext context) {
    return const MyScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: DefaultHeader(
              title: "Place Order",
            ),
          ),
          SizedBox(height: 16),
          MapsSection() 
        ],
      ),
    );
  }
}
