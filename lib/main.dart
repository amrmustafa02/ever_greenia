import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/core/cubit/app_bloc_observer.dart';
import 'package:plants_app/core/di/di.dart';
import 'package:plants_app/pants_app.dart';

void main() {
  configureDependencies();
  Bloc.observer = AppBlocObserver();
  runApp(const PlantsApp());
}
