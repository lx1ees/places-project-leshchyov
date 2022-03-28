import 'package:flutter/material.dart';
import 'package:places/constants/app_colors.dart';
import 'package:places/constants/app_constants.dart';

/// Виджет для отображения галереи достопримечательности
class SightDetailsImageGallery extends StatelessWidget {
  final String url;

  const SightDetailsImageGallery({
    required this.url,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppConstants.sightDetailsGalleryHeight,
      color: AppColors.sightImageMockColor,
      child: Image(
        image: AssetImage(url),
        fit: BoxFit.cover,
        loadingBuilder: (_, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
