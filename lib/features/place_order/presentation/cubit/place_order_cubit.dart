import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart';

part 'place_order_state.dart';

@injectable
class PlaceOrderCubit extends Cubit<PlaceOrderState> {
  PlaceOrderCubit() : super(PlaceOrderInitial());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late LatLng curLocation;

  late GoogleMapController googleMapController;

  String address = "";

  bool isLocationLoaded = false;
  bool isPlaceOrderEnabled = false;
  bool isLinerProgressEnabled = false;

  Future<bool> checkLocationServiceEnabled() async {
    var serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      var status = await Permission.location.request();
      serviceEnabled = (status != PermissionStatus.permanentlyDenied &&
          status != PermissionStatus.denied);
    }
    return serviceEnabled;
  }

  Future<bool> checkLocationPermission() async {
    var isGranted = false;

    var permission = await Geolocator.checkPermission();

    isGranted = (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always);

    if (!isGranted) {
      permission = await Geolocator.requestPermission();

      isGranted = (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always);
    }
    return isGranted;
  }

  Future<void> getCurrentLocation() async {
    emit(LocationLoading());
    bool serviceEnabled;

    var isGranted = await checkLocationPermission();

    if (!isGranted) {
      // Todo: handle if permission not granted
      return;
    }

    serviceEnabled = await checkLocationServiceEnabled();

    if (!serviceEnabled) {
      // Todo: handle if location service not enabled
      return;
    }

    var position = await Geolocator.getCurrentPosition();

    curLocation = LatLng(position.latitude, position.longitude);

    isLocationLoaded = true;

    isPlaceOrderEnabled = true;

    log("current location: $curLocation");

    await getAddressFromLocation(curLocation);

    await Future.delayed(const Duration(seconds: 1));

    emit(LocationLoadedSuccess());

    emit(UpdatePlaceOrderState());
  }

  Future<void> getAddressFromLocation(LatLng location) async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(
      location.latitude,
      location.longitude,
    );

    if (placeMarks.isNotEmpty) {
      Placemark place = placeMarks[0];
      address =
          "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
      log("address: $address");
    }
  }

  Future<void> changeLocation(LatLng location) async {
    if (curLocation == location) return;

    curLocation = location;

    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: curLocation,
          zoom: 15,
        ),
      ),
    );

    await getAddressFromLocation(curLocation);

    log("new address: $address");

    emit(LocationLoadedSuccess());
  }

  Future<void> placeOrder() async {
    isLinerProgressEnabled = true;
    isPlaceOrderEnabled = false;

    emit(UpdatePlaceOrderState());
    emit(UpdateLinerProgressState());
    await Future.delayed(const Duration(seconds: 2));

    isLinerProgressEnabled = false;
    isPlaceOrderEnabled = true;

    emit(UpdatePlaceOrderState());
    emit(UpdateLinerProgressState());
  }
}
