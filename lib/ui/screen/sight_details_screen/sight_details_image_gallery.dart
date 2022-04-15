import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/ui/widgets/image_placeholder.dart';

/// Виджет для отображения галереи достопримечательности
class SightDetailsImageGallery extends StatelessWidget {
  final String? url;

  const SightDetailsImageGallery({
    this.url,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppConstants.sightDetailsGalleryHeight,
      child: url != null
          ? Image.network(
              url ?? '',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return const ImagePlaceholder();
              },
              loadingBuilder: (_, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            )
          : const ImagePlaceholder(),
    );
  }
}
