import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:plants_app/core/extensions/widget_ext.dart';
import 'package:plants_app/core/utils/helper_methods.dart';
import 'package:plants_app/features/orders/domain/entities/order_data.dart';
import 'package:plants_app/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:plants_app/features/orders/presentation/widgets/product_order_item.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_font_styles.dart';

class OrderItem extends StatelessWidget {
  final OrderData order;

  const OrderItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.withOpacity(0.15))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xffF8F9FB),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: ListTile(
              trailing: IconButton(
                padding: const EdgeInsets.all(0),
                onPressed: () async {
                  await Clipboard.setData(
                    ClipboardData(
                      text: order.id.toString(),
                    ),
                  );

                  Fluttertoast.showToast(
                    msg: "Copied to clipboard",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: AppColors.darkGreen,
                    textColor: Colors.white,
                    fontSize: 16.sp,
                  );
                },
                icon: const Icon(
                  EneftyIcons.copy_bold,
                  color: AppColors.darkGreen,
                  size: 20,
                ),
              ),
              contentPadding: const EdgeInsets.only(left: 16),
              title: Text(
                "Order ID: ${order.id}",
                style: AppFontStyles.readexPro600_14.copyWith(
                  color: AppColors.darkBlueColor,
                ),
              ),
              subtitle: Text(
                "Total Price: \$${order.totalPrice}",
                style: AppFontStyles.readexPro400_14.copyWith(
                  color: AppColors.darkBlueColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          ListView.separated(
            itemCount: order.products.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var product = order.products[index];
              return ProductOrderItem(product: product);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider().setHorizontalPadding();
            },
          ),
          const SizedBox(height: 8),
          Visibility(
            visible: order.status == "pending",
            child: Bounceable(
              onTap: () {
                HelperMethods.showDialogConfirm(
                  context: context,
                  title: "Cancel Order",
                  message: "Are you sure you want to cancel this order?",
                  confirmText: "Yes",
                  cancelText: "no",
                  onTapConfirm: () {
                    context
                        .read<OrdersCubit>()
                        .cancelOrder(order.id.toString());
                    Navigator.pop(context);
                  },
                );
              },
              child: Container(
                width: 100.w,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.9),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                ),
                alignment: Alignment.center,
                child: BlocBuilder<OrdersCubit, OrdersState>(
                  buildWhen: (previous, current) {
                    if (current is CancelOrderLoading) {
                      if (order.id == current.orderId) return true;
                      return false;
                    }
                    return true;
                  },
                  builder: (context, state) {
                    if (state is CancelOrderLoading) {
                      return Center(
                        child: LoadingAnimationWidget.dotsTriangle(
                          color: Colors.white,
                          size: 20,
                        ),
                      );
                    }
                    return Text(
                      "Cancel Order",
                      style: AppFontStyles.readexPro500_14.copyWith(
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
