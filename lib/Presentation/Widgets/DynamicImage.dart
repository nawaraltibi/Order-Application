import 'package:flutter/material.dart';
import 'package:order_application/App/Color/Color.dart';

dynamicImage({required String imagePath, BoxFit box = BoxFit.contain}) {
  return Image.network(
    imagePath,
    fit: box,
    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) {
        return child;
      } else {
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                : null,
            strokeWidth: 2,
            color: AppColors.primary,
          ),
        );
      }
    },
    errorBuilder: (context, error, stackTrace) => const Icon(
      Icons.broken_image,
      size: 50,
      color: Colors.grey,
    ),
  );
}
