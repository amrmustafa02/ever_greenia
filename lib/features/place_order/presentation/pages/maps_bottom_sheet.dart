import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plants_app/core/theme/app_colors.dart';
import 'package:plants_app/features/place_order/presentation/cubit/place_order_cubit.dart';

class MapsBottomSheet extends StatefulWidget {
  const MapsBottomSheet({super.key});

  @override
  State<MapsBottomSheet> createState() => _MapsBottomSheetState();
}

class _MapsBottomSheetState extends State<MapsBottomSheet> {
  late LatLng curLocation;
  @override
  void initState() {
    super.initState();
    curLocation = context.read<PlaceOrderCubit>().curLocation;
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<PlaceOrderCubit>();
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GoogleMap(
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            onTap: (argument) {
              curLocation = argument;
              setState(() {});
            },
            markers: {
              Marker(
                markerId: const MarkerId("current_location"),
                position: curLocation,
              )
            },
            initialCameraPosition: CameraPosition(
              target: curLocation,
              zoom: 15,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircleAvatar(
                backgroundColor: AppColors.darkGreen.withOpacity(1),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkGreen,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
              onPressed: () async {
                cubit.changeLocation(curLocation);
                Navigator.pop(context);
              },
              child: const Text(
                "Confirm Location",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
