import 'package:flutter/material.dart';
import 'package:plants_app/core/di/di.dart';
import 'package:plants_app/pants_app.dart';

void main() {
  configureDependencies();
  runApp(const PlantsApp());
}
