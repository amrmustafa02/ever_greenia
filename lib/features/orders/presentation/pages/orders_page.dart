import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/core/extensions/widget_ext.dart';
import 'package:plants_app/core/widgets/default_header.dart';
import 'package:plants_app/core/widgets/my_scaffold.dart';
import 'package:plants_app/features/orders/domain/entities/order_data.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/di/di.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_font_styles.dart';
import '../cubit/orders_cubit.dart';
import '../widgets/order_empty.dart';
import '../widgets/order_item.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<OrdersCubit>()..getOrders(),
      child: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          return const _OrdersPageBody();
        },
      ),
    );
  }
}

class _OrdersPageBody extends StatelessWidget {
  const _OrdersPageBody();

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      child: SafeArea(
        bottom: false,
        child: DefaultTabController(
          length: 4,
          child: Column(
            children: [
              const DefaultHeader(title: 'Orders'),
              SizedBox(
                height: 7.h,
                child: TabBar(
                  indicatorColor: AppColors.darkGreen,
                  labelStyle: AppFontStyles.nunito600_16,
                  isScrollable: true,
                  padding: EdgeInsets.zero,
                  dividerColor: Colors.transparent,
                  tabAlignment: TabAlignment.start,
                  onTap: (value) {
                    context.read<OrdersCubit>().onTabBarPressed(value);
                  },
                  tabs: const [
                    Tab(text: 'Pending'),
                    Tab(text: 'In Progress'),
                    Tab(text: 'Delivered'),
                    Tab(text: 'Cancelled'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<OrdersCubit, OrdersState>(
                  builder: (context, state) {
                    var cubit = context.read<OrdersCubit>();

                    if (state is OrdersInitial) {
                      return Skeletonizer(
                        child: ListView.builder(
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            var order = OrderData.fromFakeData();
                            return OrderItem(order: order);
                          },
                        ),
                      ).setHorizontalPadding();
                    }

                    return Visibility(
                      visible: cubit.orders.isNotEmpty,
                      replacement: const OrderEmpty().setHorizontalPadding(),
                      child: RefreshIndicator(
                        onRefresh: () async {
                          context.read<OrdersCubit>().refresh();
                        },
                        child: ListView.builder(
                          itemCount: cubit.orders.length,
                          itemBuilder: (context, int index) {
                            var order = cubit.orders[index];
                            return FadeInUp(
                              duration:
                                  Duration(milliseconds: 500 + (index + 200)),
                              curve: Curves.easeInOut,
                              child: OrderItem(order: order),
                            );
                          },
                        ),
                      ).setHorizontalPadding(),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

// String _formatDate(String date) {
//   DateFormat formatter = DateFormat('yyyy-MM-dd');
//   return formatter.format(DateTime.parse(date));
// }
}
