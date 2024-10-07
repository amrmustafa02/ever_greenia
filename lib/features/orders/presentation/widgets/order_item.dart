
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:plants_app/core/extensions/widget_ext.dart';
import 'package:plants_app/core/utils/helper_methods.dart';
import 'package:plants_app/features/orders/domain/entities/order_data.dart';
import 'package:plants_app/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:plants_app/features/orders/presentation/widgets/product_order_item.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_font_styles.dart';
import 'order_info_dialog.dart';

class OrderItem extends StatefulWidget {
  final OrderData order;

  const OrderItem({super.key, required this.order});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  final GlobalKey iconButtonKey = GlobalKey(); // Key for the icon button

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.withOpacity(0.15)),
      ),
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
                key: iconButtonKey, // Assign the key to IconButton
                padding: const EdgeInsets.all(0),
                onPressed: () async {
                  var result = AwesomeDialog(
                    context: context,
                    padding: const EdgeInsets.all(0),
                    body: OrderInfoDialog(order: widget.order)
                        .setHorizontalPadding(),
                    dialogType: DialogType.noHeader,
                    animType: AnimType.scale,
                    title: 'Order ID: ${widget.order.id}',
                    desc: 'phone: ${widget.order.phone}',
                    btnOkOnPress: () {},
                    barrierColor: Colors.black.withOpacity(0.2),
                    dialogBackgroundColor: Colors.white,
                    btnOkColor: AppColors.darkGreen,
                  );
                  result.show();
                },
                icon: const Icon(
                  EneftyIcons.information_bold,
                  color: AppColors.darkGreen,
                  size: 20,
                ),
              ),
              contentPadding: const EdgeInsets.only(left: 16),
              title: Text(
                "Order ID: ${widget.order.id}",
                style: AppFontStyles.readexPro600_14.copyWith(
                  color: AppColors.darkBlueColor,
                ),
              ),
              subtitle: Text(
                "Total Price: \$${widget.order.totalPrice}",
                style: AppFontStyles.readexPro400_14.copyWith(
                  color: AppColors.darkBlueColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          ListView.separated(
            itemCount: widget.order.products.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var product = widget.order.products[index];
              return ProductOrderItem(product: product);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider().setHorizontalPadding();
            },
          ),
          const SizedBox(height: 8),
          Visibility(
            visible: widget.order.status == "pending",
            child: Bounceable(
              onTap: () {
                HelperMethods.showDialogConfirm(
                  context: context,
                  title: "Cancel Order",
                  message: "Are you sure you want to cancel this order?",
                  confirmText: "Yes",
                  cancelText: "No",
                  onTapConfirm: () {
                    context
                        .read<OrdersCubit>()
                        .cancelOrder(widget.order.id.toString());
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
                      return widget.order.id == current.orderId;
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
          ),
        ],
      ),
    );
  }
}
