import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart';
import 'package:plants_app/core/api/api_result.dart';
import 'package:plants_app/core/constants/app_constants.dart';
import 'package:plants_app/core/cubit/cart/cubit/cart_cubit.dart';
import 'package:plants_app/core/entities/user_data.dart';
import 'package:plants_app/features/place_order/domain/repo/place_order_repo.dart';

import '../../../../core/di/di.dart';
import '../../../../core/utils/regex_utils.dart';

part 'place_order_state.dart';

@injectable
class PlaceOrderCubit extends Cubit<PlaceOrderState> {
  PlaceOrderCubit(this._orderRepo) : super(PlaceOrderInitial());

  final PlaceOrderRepo _orderRepo;

  late LatLng curLocation;
  late GoogleMapController googleMapController;

  String address = "";

  bool isLocationLoaded = false;
  bool isPlaceOrderEnabled = false;
  bool isLinerProgressEnabled = false;

  num totalPrice = 0;
  num itemsPrice = 0;

  TextEditingController phoneController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  void initPrice(num itemsPrice) {
    this.itemsPrice = itemsPrice;
    totalPrice = itemsPrice + AppConstants.deliveryFee;
  }

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

    checkEnableToPlaceOrder();

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

  Future<void> placeOrder(CartCubit cartCubit) async {
    HapticFeedback.heavyImpact();
    isLinerProgressEnabled = true;
    isPlaceOrderEnabled = false;

    emit(UpdatePlaceOrderState());
    emit(UpdateLinerProgressState());

    var result = await _orderRepo.placeOrder(
      curLocation: curLocation,
      address: address,
      phone: phoneController.text,
      token: getIt<UserData>().token,
      note: noteController.text,
      paymentMethod: "cash",
    );

    switch (result) {
      case SuccessRequest<bool>():
        isLinerProgressEnabled = false;
        isPlaceOrderEnabled = true;
        cartCubit.getCart();

        emit(SuccessOrderState());
        break;
      case FailedRequest<bool>():
        isLinerProgressEnabled = false;
        isPlaceOrderEnabled = true;
        emit(FailedOrderState(result.exception.errorMessage));
        break;
    }
    emit(UpdatePlaceOrderState());
    emit(UpdateLinerProgressState());
  }

  void checkEnableToPlaceOrder() {
    var newEnablePlaceOrder = isLocationLoaded &&
        phoneController.text.isNotEmpty &&
        RegexUtils.checkPhone(phoneController.text);
    if (newEnablePlaceOrder != isPlaceOrderEnabled) {
      isPlaceOrderEnabled = newEnablePlaceOrder;

      emit(UpdatePlaceOrderState());
    }
  }
}
