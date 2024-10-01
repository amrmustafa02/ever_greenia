import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/core/di/di.dart';
import 'package:plants_app/core/extensions/widget_ext.dart';
import 'package:plants_app/core/theme/app_colors.dart';
import 'package:plants_app/core/theme/app_font_styles.dart';
import 'package:plants_app/core/widgets/default_header.dart';
import 'package:plants_app/core/widgets/my_scaffold.dart';
import 'package:plants_app/features/place_order/presentation/widgets/address_form.dart';
import 'package:plants_app/features/place_order/presentation/widgets/maps_section.dart';
import 'package:plants_app/features/place_order/presentation/widgets/payment_details_section.dart';
import 'package:plants_app/features/place_order/presentation/widgets/payment_methods_section.dart';
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
    return MyScaffold(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SafeArea(child: DefaultHeader(title: "Place Order")),
                  const MapsSection(),
                  const SizedBox(height: 16),
                  Divider(color: Colors.grey.withOpacity(0.2), thickness: 7),
                  const SizedBox(height: 16),
                  Text("Payment Method", style: AppFontStyles.readexPro600_16)
                      .setHorizontalPadding(),
                  const SizedBox(height: 8),
                  const PaymentMethodsSection().setHorizontalPadding(),
                  const SizedBox(height: 16),
                  Divider(color: Colors.grey.withOpacity(0.2), thickness: 7),
                  const SizedBox(height: 16),
                  const PaymentDetailsSection().setHorizontalPadding()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
