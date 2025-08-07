
import 'package:flutter/material.dart';
import 'package:pharmacy/gen/assets.gen.dart';


ImageLoadingBuilder loadingBuilder() {
  return (context, child, loadingProgress) {
    if (loadingProgress == null) {
      return child;
    } else {
      return Image.asset(Assets.images.pWatermarkV2.path);
    }
  };
}

ImageErrorWidgetBuilder errorBuilder(String imagePath) {
  return (BuildContext context,
      Object error,
      StackTrace? stackTrace) {
    return Image.asset(imagePath);

  };

}