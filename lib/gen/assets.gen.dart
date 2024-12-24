/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/Google_Gemini_logo.png
  AssetGenImage get googleGeminiLogo =>
      const AssetGenImage('assets/images/Google_Gemini_logo.png');

  /// File path: assets/images/avatar_null.png
  AssetGenImage get avatarNull =>
      const AssetGenImage('assets/images/avatar_null.png');

  /// File path: assets/images/avt1.png
  AssetGenImage get avt1 => const AssetGenImage('assets/images/avt1.png');

  /// File path: assets/images/avt2.png
  AssetGenImage get avt2 => const AssetGenImage('assets/images/avt2.png');

  /// File path: assets/images/avt3.png
  AssetGenImage get avt3 => const AssetGenImage('assets/images/avt3.png');

  /// File path: assets/images/avt4.png
  AssetGenImage get avt4 => const AssetGenImage('assets/images/avt4.png');

  /// File path: assets/images/avt5.png
  AssetGenImage get avt5 => const AssetGenImage('assets/images/avt5.png');

  /// File path: assets/images/logo.svg
  String get logo => 'assets/images/logo.svg';

  /// List of all assets
  List<dynamic> get values =>
      [googleGeminiLogo, avatarNull, avt1, avt2, avt3, avt4, avt5, logo];
}

class $AssetsJsonsGen {
  const $AssetsJsonsGen();

  /// File path: assets/jsons/splash_lotie.json
  String get splashLotie => 'assets/jsons/splash_lotie.json';

  /// File path: assets/jsons/success.json
  String get success => 'assets/jsons/success.json';

  /// List of all assets
  List<String> get values => [splashLotie, success];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsJsonsGen jsons = $AssetsJsonsGen();
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
    bool gaplessPlayback = true,
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
