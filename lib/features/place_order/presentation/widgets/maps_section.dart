import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plants_app/core/theme/app_colors.dart';
import 'package:plants_app/core/theme/app_font_styles.dart';
import 'package:plants_app/features/place_order/presentation/cubit/place_order_cubit.dart';
import 'package:plants_app/features/place_order/presentation/pages/maps_bottom_sheet.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MapsSection extends StatelessWidget {
  const MapsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceOrderCubit, PlaceOrderState>(
      buildWhen: (c, s) => s is LocationLoading || s is LocationLoadedSuccess,
      builder: (context, state) {
        var cubit = context.read<PlaceOrderCubit>();
        if (state is LocationLoading) {
          return Skeletonizer(
            ignoreContainers: false,
            child: Column(
              children: [
                Container(
                  height: 25.h,
                  width: 100.w,
                  color: Colors.grey.shade300,
                ),
                FadeInLeft(
                  child: ListTile(
                    title: Text(
                      "Delivery Address",
                      style: AppFontStyles.readexPro500_16,
                    ),
                    subtitle: Text(
                      "Test\ntest",
                      style: AppFontStyles.readexPro400_14,
                    ),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.my_location_rounded,
                        color: AppColors.darkGreen,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Column(
          children: [
            SizedBox(
              height: 25.h,
              child: ZoomIn(
                child: GoogleMap(
                  myLocationEnabled: false,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  onMapCreated: (controller) {
                    cubit.googleMapController = controller;
                  },
                  onTap: (argument) {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.white,
                      enableDrag: false,
                      // showDragHandle: true,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      builder: (context) {
                        return FractionallySizedBox(
                          heightFactor: 0.6,
                          child: BlocProvider.value(
                            value: cubit,
                            child: const MapsBottomSheet(),
                          ),
                        );
                      },
                    );
                  },
                  markers: {
                    Marker(
                      markerId: const MarkerId("1"),
                      position: cubit.curLocation,
                    ),
                  },
                  initialCameraPosition: CameraPosition(
                    target: cubit.curLocation,
                    zoom: 15,
                  ),
                ),
              ),
            ),
            FadeInLeft(
              child: ListTile(
                title: Text(
                  "Delivery Address",
                  style: AppFontStyles.readexPro500_16,
                ),
                subtitle: Text(
                  cubit.address,
                  style: AppFontStyles.readexPro400_14,
                ),
                trailing: IconButton(
                  onPressed: cubit.getCurrentLocation,
                  icon: const Icon(
                    Icons.my_location_rounded,
                    color: AppColors.darkGreen,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
