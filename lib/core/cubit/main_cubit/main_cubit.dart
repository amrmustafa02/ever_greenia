import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:plants_app/core/di/di.dart';
import 'package:plants_app/core/entities/user_data.dart';

part 'main_state.dart';

@singleton
class MainCubit extends Cubit<MainState> {
  MainCubit(this._secureStorage) : super(MainInitial());
  final FlutterSecureStorage _secureStorage;

  bool isUserLogged = false;

  checkUserLogged() async {
    var token = await _secureStorage.read(key: 'token');
    isUserLogged = token != null;

    getIt<UserData>().token = token ?? "";
    getIt<UserData>().isLogin = isUserLogged;

    log("Checking user logged: $isUserLogged");
    emit(ConfigLoaded(isUserLogged));
  }

  logout() {
    _secureStorage.delete(key: 'token');
    isUserLogged = false;
  }
}
