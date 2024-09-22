import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

part 'main_state.dart';

@singleton
class MainCubit extends Cubit<MainState> {
  MainCubit(this._secureStorage) : super(MainInitial());
  final FlutterSecureStorage _secureStorage;

  bool isUserLogged = false;
  bool isFirstRun = false;

  checkUserLogged() {
    log("Checking user logged");
    _secureStorage.read(key: 'token').then((value) {
      if (value != null) {
        isUserLogged = true;
      } else {
        isUserLogged = false;
      }
      log("Checking user logged: $isUserLogged");
      emit(ConfigLoaded(isUserLogged));
    });
  }

  logout() {
    _secureStorage.delete(key: 'token');
    isUserLogged = false;
  }
}
