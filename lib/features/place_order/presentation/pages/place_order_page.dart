import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:plants_app/core/di/di.dart';
import 'package:plants_app/core/extensions/context_extension.dart';
import 'package:plants_app/core/extensions/widget_ext.dart';
import 'package:plants_app/core/theme/app_colors.dart';
import 'package:plants_app/core/theme/app_font_styles.dart';
import 'package:plants_app/core/widgets/default_header.dart';
import 'package:plants_app/core/widgets/my_scaffold.dart';
import 'package:plants_app/features/place_order/presentation/widgets/maps_section.dart';
import 'package:plants_app/features/place_order/presentation/widgets/payment_details_section.dart';
import 'package:plants_app/features/place_order/presentation/widgets/payment_methods_section.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/routing/app_router.dart';
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
          const SafeArea(child: DefaultHeader(title: "Place Order")),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MapsSection(),
                  Divider(color: Colors.grey.withOpacity(0.2), thickness: 7),
                  const SizedBox(height: 16),
                  Text("Payment Method", style: AppFontStyles.readexPro600_16)
                      .setHorizontalPadding(),
                  const SizedBox(height: 16),
                  const PaymentMethodsSection().setHorizontalPadding(),
                  const SizedBox(height: 16),
                  Divider(color: Colors.grey.withOpacity(0.2), thickness: 7),
                  const SizedBox(height: 16),
                  const PaymentDetailsSection().setHorizontalPadding()
                ],
              ),
            ),
          ),
          BlocBuilder<PlaceOrderCubit, PlaceOrderState>(
            buildWhen: (previous, current) =>
                current is UpdateLinerProgressState,
            builder: (context, state) {
              return Visibility(
                visible: context.read<PlaceOrderCubit>().isLinerProgressEnabled,
                child: const LinearProgressIndicator(),
              );
            },
          ),
          BlocConsumer<PlaceOrderCubit, PlaceOrderState>(
            buildWhen: (previous, current) =>
                current is PlaceOrderInitial ||
                current is UpdatePlaceOrderState,
            builder: (context, state) {
              var enableButton =
                  context.read<PlaceOrderCubit>().isPlaceOrderEnabled;
              return Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(8),
                width: 100.w,
                height: 8.h,
                child: Bounceable(
                  onTap: enableButton
                      ? context.read<PlaceOrderCubit>().placeOrder
                      : null,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: enableButton
                          ? AppColors.darkGreen
                          : AppColors.darkGreen.withOpacity(0.3),
                    ),
                    child: Text(
                      "Place Order",
                      style: AppFontStyles.readexPro600_16.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            },
            listener: (BuildContext context, PlaceOrderState state) {
              if (state is SuccessOrderState) {
                context.goBackUntilAndPush(
                  RoutesName.successOrder,
                  RoutesName.home,
                );
              }
            },
          )
        ],
      ),
    );
  }
}
