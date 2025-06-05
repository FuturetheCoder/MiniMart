/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsPngsGen {
  const $AssetsPngsGen();

  /// File path: assets/pngs/Iphone_16.png
  AssetGenImage get iphone16 =>
      const AssetGenImage('assets/pngs/Iphone_16.png');

  /// File path: assets/pngs/Macbook_m4.png
  AssetGenImage get macbookM4 =>
      const AssetGenImage('assets/pngs/Macbook_m4.png');

  /// File path: assets/pngs/airpod.png
  AssetGenImage get airpod => const AssetGenImage('assets/pngs/airpod.png');

  /// File path: assets/pngs/google_pixel.png
  AssetGenImage get googlePixel =>
      const AssetGenImage('assets/pngs/google_pixel.png');

  /// File path: assets/pngs/search.png
  AssetGenImage get search => const AssetGenImage('assets/pngs/search.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    iphone16,
    macbookM4,
    airpod,
    googlePixel,
    search,
  ];
}

class $AssetsSvgsGen {
  const $AssetsSvgsGen();

  /// File path: assets/svgs/cart.svg
  String get cart => 'assets/svgs/cart.svg';

  /// File path: assets/svgs/delete.svg
  String get delete => 'assets/svgs/delete.svg';

  /// File path: assets/svgs/favorite.svg
  String get favorite => 'assets/svgs/favorite.svg';

  /// File path: assets/svgs/home.svg
  String get home => 'assets/svgs/home.svg';

  /// File path: assets/svgs/logo.svg
  String get logo => 'assets/svgs/logo.svg';

  /// File path: assets/svgs/notification.svg
  String get notification => 'assets/svgs/notification.svg';

  /// File path: assets/svgs/profile.svg
  String get profile => 'assets/svgs/profile.svg';

  /// List of all assets
  List<String> get values => [
    cart,
    delete,
    favorite,
    home,
    logo,
    notification,
    profile,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsPngsGen pngs = $AssetsPngsGen();
  static const $AssetsSvgsGen svgs = $AssetsSvgsGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

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
    FilterQuality filterQuality = FilterQuality.medium,
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

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
