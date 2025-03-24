
import 'package:flutter/material.dart';

ImageLoadingBuilder loadingBuilder() {
  return (context, child, loadingProgress) {
    if (loadingProgress == null) {
      return child;
    } else {
      return Center(
        child: CircularProgressIndicator(
          value: loadingProgress
              .expectedTotalBytes !=
              null
              ? loadingProgress
              .cumulativeBytesLoaded /
              (loadingProgress
                  .expectedTotalBytes ??
                  1)
              : null,
        ),
      );
    }
  };
}

ImageErrorWidgetBuilder errorBuilder() {
  return (BuildContext context,
      Object error,
      StackTrace? stackTrace) {
    return const Center(
      child: Text(
        'Failed to load image',
        style: TextStyle(color: Colors.red),
      ),
    );

  };

}