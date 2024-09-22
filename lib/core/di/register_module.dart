import 'package:injectable/injectable.dart';
import 'package:plants_app/core/api/my_dio.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  MyDio get myDio => MyDio.getInstance();
}
