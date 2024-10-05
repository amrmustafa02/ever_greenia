/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsAudioGen {
  const $AssetsAudioGen();

  /// File path: assets/audio/Flora Bot.wav
  String get floraBot => 'assets/audio/Flora Bot.wav';

  /// List of all assets
  List<String> get values => [floraBot];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/bag.svg
  String get bag => 'assets/icons/bag.svg';

  /// File path: assets/icons/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/icons/logo.png');

  /// List of all assets
  List<dynamic> get values => [bag, logo];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/and_logo.png
  AssetGenImage get andLogo =>
      const AssetGenImage('assets/images/and_logo.png');

  /// File path: assets/images/appName.png
  AssetGenImage get appName => const AssetGenImage('assets/images/appName.png');

  /// File path: assets/images/arrow.svg
  String get arrow => 'assets/images/arrow.svg';

  /// File path: assets/images/arrow_2.svg
  String get arrow2 => 'assets/images/arrow_2.svg';

  /// File path: assets/images/arrow_back.png
  AssetGenImage get arrowBack =>
      const AssetGenImage('assets/images/arrow_back.png');

  /// File path: assets/images/base_item.svg
  String get baseItem => 'assets/images/base_item.svg';

  /// File path: assets/images/cart_rectancle.svg
  String get cartRectancle => 'assets/images/cart_rectancle.svg';

  /// File path: assets/images/circle_1.png
  AssetGenImage get circle1 =>
      const AssetGenImage('assets/images/circle_1.png');

  /// File path: assets/images/circle_2.png
  AssetGenImage get circle2 =>
      const AssetGenImage('assets/images/circle_2.png');

  /// File path: assets/images/confirm_email_image.png
  AssetGenImage get confirmEmailImage =>
      const AssetGenImage('assets/images/confirm_email_image.png');

  /// File path: assets/images/confirm_page_image.png
  AssetGenImage get confirmPageImage =>
      const AssetGenImage('assets/images/confirm_page_image.png');

  /// File path: assets/images/login_bg_header.png
  AssetGenImage get loginBgHeader =>
      const AssetGenImage('assets/images/login_bg_header.png');

  /// File path: assets/images/login_bg_plant.png
  AssetGenImage get loginBgPlant =>
      const AssetGenImage('assets/images/login_bg_plant.png');

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');

  /// File path: assets/images/logo_bg_header_two.png
  AssetGenImage get logoBgHeaderTwo =>
      const AssetGenImage('assets/images/logo_bg_header_two.png');

  /// File path: assets/images/logo_tr.png
  AssetGenImage get logoTr => const AssetGenImage('assets/images/logo_tr.png');

  /// File path: assets/images/onbaording_image.png
  AssetGenImage get onbaordingImage =>
      const AssetGenImage('assets/images/onbaording_image.png');

  /// File path: assets/images/plant.png
  AssetGenImage get plant => const AssetGenImage('assets/images/plant.png');

  /// File path: assets/images/r_logo.png
  AssetGenImage get rLogo => const AssetGenImage('assets/images/r_logo.png');

  /// File path: assets/images/rectancle.png
  AssetGenImage get rectancle =>
      const AssetGenImage('assets/images/rectancle.png');

  /// File path: assets/images/s_logo.png
  AssetGenImage get sLogo => const AssetGenImage('assets/images/s_logo.png');

  /// List of all assets
  List<dynamic> get values => [
        andLogo,
        appName,
        arrow,
        arrow2,
        arrowBack,
        baseItem,
        cartRectancle,
        circle1,
        circle2,
        confirmEmailImage,
        confirmPageImage,
        loginBgHeader,
        loginBgPlant,
        logo,
        logoBgHeaderTwo,
        logoTr,
        onbaordingImage,
        plant,
        rLogo,
        rectancle,
        sLogo
      ];
}

class $AssetsLottieGen {
  const $AssetsLottieGen();

  /// File path: assets/lottie/arrow.json
  String get arrow => 'assets/lottie/arrow.json';

  /// File path: assets/lottie/bot1.json
  String get bot1 => 'assets/lottie/bot1.json';

  /// File path: assets/lottie/bot2.json
  String get bot2 => 'assets/lottie/bot2.json';

  /// File path: assets/lottie/error.json
  String get error => 'assets/lottie/error.json';

  /// File path: assets/lottie/plant_grow.json
  String get plantGrow => 'assets/lottie/plant_grow.json';

  /// File path: assets/lottie/plants_loading.json
  String get plantsLoading => 'assets/lottie/plants_loading.json';

  /// File path: assets/lottie/success.json
  String get success => 'assets/lottie/success.json';

  /// List of all assets
  List<String> get values =>
      [arrow, bot1, bot2, error, plantGrow, plantsLoading, success];
}

class $AssetsTranslationsGen {
  const $AssetsTranslationsGen();

  /// File path: assets/translations/ar.json
  String get ar => 'assets/translations/ar.json';

  /// File path: assets/translations/en.json
  String get en => 'assets/translations/en.json';

  /// List of all assets
  List<String> get values => [ar, en];
}

class Assets {
  Assets._();

  static const $AssetsAudioGen audio = $AssetsAudioGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLottieGen lottie = $AssetsLottieGen();
  static const $AssetsTranslationsGen translations = $AssetsTranslationsGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
