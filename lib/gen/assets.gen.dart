/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/P_WatermarkV2.png
  AssetGenImage get pWatermarkV2 =>
      const AssetGenImage('assets/images/P_WatermarkV2.png');

  /// File path: assets/images/RPIcon.png
  AssetGenImage get rPIcon => const AssetGenImage('assets/images/RPIcon.png');

  /// File path: assets/images/admin.svg
  SvgGenImage get admin => const SvgGenImage('assets/images/admin.svg');

  /// File path: assets/images/arrow-left-svgrepo-com.svg
  SvgGenImage get arrowLeftSvgrepoCom =>
      const SvgGenImage('assets/images/arrow-left-svgrepo-com.svg');

  /// File path: assets/images/arrow-right-svgrepo-com.svg
  SvgGenImage get arrowRightSvgrepoCom =>
      const SvgGenImage('assets/images/arrow-right-svgrepo-com.svg');

  /// File path: assets/images/cart-no_item.svg
  SvgGenImage get cartNoItem =>
      const SvgGenImage('assets/images/cart-no_item.svg');

  /// File path: assets/images/cart_selected.svg
  SvgGenImage get cartSelected =>
      const SvgGenImage('assets/images/cart_selected.svg');

  /// File path: assets/images/cart_unselected.svg
  SvgGenImage get cartUnselected =>
      const SvgGenImage('assets/images/cart_unselected.svg');

  /// File path: assets/images/category-default_icon.svg
  SvgGenImage get categoryDefaultIcon =>
      const SvgGenImage('assets/images/category-default_icon.svg');

  /// File path: assets/images/dashboard-item.svg
  SvgGenImage get dashboardItem =>
      const SvgGenImage('assets/images/dashboard-item.svg');

  /// File path: assets/images/default_profile_image.svg
  SvgGenImage get defaultProfileImage =>
      const SvgGenImage('assets/images/default_profile_image.svg');

  /// File path: assets/images/delete-account.svg
  SvgGenImage get deleteAccount =>
      const SvgGenImage('assets/images/delete-account.svg');

  /// File path: assets/images/drug.png
  AssetGenImage get drug => const AssetGenImage('assets/images/drug.png');

  /// File path: assets/images/facebook.svg
  SvgGenImage get facebook => const SvgGenImage('assets/images/facebook.svg');

  /// File path: assets/images/google.svg
  SvgGenImage get google => const SvgGenImage('assets/images/google.svg');

  /// File path: assets/images/heart.svg
  SvgGenImage get heart => const SvgGenImage('assets/images/heart.svg');

  /// File path: assets/images/home-selected.svg
  SvgGenImage get homeSelected =>
      const SvgGenImage('assets/images/home-selected.svg');

  /// File path: assets/images/home-unselected.svg
  SvgGenImage get homeUnselected =>
      const SvgGenImage('assets/images/home-unselected.svg');

  /// File path: assets/images/logout.svg
  SvgGenImage get logout => const SvgGenImage('assets/images/logout.svg');

  /// File path: assets/images/more-selected.svg
  SvgGenImage get moreSelected =>
      const SvgGenImage('assets/images/more-selected.svg');

  /// File path: assets/images/orders-item.svg
  SvgGenImage get ordersItem =>
      const SvgGenImage('assets/images/orders-item.svg');

  /// File path: assets/images/orders.svg
  SvgGenImage get orders => const SvgGenImage('assets/images/orders.svg');

  /// File path: assets/images/remove.svg
  SvgGenImage get remove => const SvgGenImage('assets/images/remove.svg');

  /// File path: assets/images/report-item.svg
  SvgGenImage get reportItem =>
      const SvgGenImage('assets/images/report-item.svg');

  /// File path: assets/images/settings-selected.svg
  SvgGenImage get settingsSelected =>
      const SvgGenImage('assets/images/settings-selected.svg');

  /// File path: assets/images/settings-unselected.svg
  SvgGenImage get settingsUnselected =>
      const SvgGenImage('assets/images/settings-unselected.svg');

  /// File path: assets/images/share.svg
  SvgGenImage get share => const SvgGenImage('assets/images/share.svg');

  /// File path: assets/images/user-selected.svg
  SvgGenImage get userSelected =>
      const SvgGenImage('assets/images/user-selected.svg');

  /// File path: assets/images/user-unselected.svg
  SvgGenImage get userUnselected =>
      const SvgGenImage('assets/images/user-unselected.svg');

  /// File path: assets/images/users-item.svg
  SvgGenImage get usersItem =>
      const SvgGenImage('assets/images/users-item.svg');

  /// List of all assets
  List<dynamic> get values => [
        pWatermarkV2,
        rPIcon,
        admin,
        arrowLeftSvgrepoCom,
        arrowRightSvgrepoCom,
        cartNoItem,
        cartSelected,
        cartUnselected,
        categoryDefaultIcon,
        dashboardItem,
        defaultProfileImage,
        deleteAccount,
        drug,
        facebook,
        google,
        heart,
        homeSelected,
        homeUnselected,
        logout,
        moreSelected,
        ordersItem,
        orders,
        remove,
        reportItem,
        settingsSelected,
        settingsUnselected,
        share,
        userSelected,
        userUnselected,
        usersItem
      ];
}

class Assets {
  const Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const String pharmacyLoadingAnimation =
      'assets/pharmacy_loading_animation.json';

  /// List of all assets
  static List<String> get values => [pharmacyLoadingAnimation];
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

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
