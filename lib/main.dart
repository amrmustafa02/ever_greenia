
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/core/cubit/app_bloc_observer.dart';
import 'package:plants_app/core/di/di.dart';
import 'package:plants_app/my_app.dart';
import 'package:flutter/widgets.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

// void main(){
//   configureDependencies();
//   Bloc.observer = AppBlocObserver();
//   runApp(const PlantsApp());
// }

Future<void> main() async {
  configureDependencies();
  Bloc.observer = AppBlocObserver();

  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://8cee87bb835beba5a8070ebd269a5aa5@o4508046819655680.ingest.us.sentry.io/4508046954528768';
      options.debug = true;
      options.beforeSend = (event, hint) {
        log(event.toString());
        return event;
      };
    },
    appRunner: () => runApp(const MyApp()),
  );

}
