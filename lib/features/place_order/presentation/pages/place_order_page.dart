import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/core/di/di.dart';
import 'package:plants_app/core/extensions/context_extension.dart';
import 'package:plants_app/core/extensions/widget_ext.dart';
import 'package:plants_app/core/theme/app_font_styles.dart';
import 'package:plants_app/core/widgets/default_button.dart';
import 'package:plants_app/core/widgets/default_header.dart';
import 'package:plants_app/core/widgets/my_scaffold.dart';
import 'package:plants_app/features/place_order/presentation/widgets/maps_section.dart';
import 'package:plants_app/features/place_order/presentation/widgets/payment_details_section.dart';
import 'package:plants_app/features/place_order/presentation/widgets/payment_methods_section.dart';
import '../../../../core/cubit/cart/cubit/cart_cubit.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/utils/helper_methods.dart';
import '../cubit/place_order_cubit.dart';
import '../widgets/contact_info_form.dart';

class PlaceOrderPage extends StatelessWidget {
  final num totalPrice;

  const PlaceOrderPage({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PlaceOrderCubit>()
        ..initPrice(totalPrice)
        ..getCurrentLocation(),
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
                  Text("Contact Info", style: AppFontStyles.readexPro600_16)
                      .setHorizontalPadding(),
                  const SizedBox(height: 16),
                  const ContactInfoForm().setHorizontalPadding(),
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
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                child: DefaultButton(
                  enableButton: enableButton,
                  onTap: () => context
                      .read<PlaceOrderCubit>()
                      .placeOrder(context.read<CartCubit>()),
                  label: 'Place Order',
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
              if (state is FailedOrderState) {
                HelperMethods.showErrorNotificationToast(state.error);
              }
            },
          )
        ],
      ),
    );
  }
}
