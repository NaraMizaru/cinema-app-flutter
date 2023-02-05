import 'package:cinema_app/api_constants.dart';
import 'package:flutter/material.dart';

class ImageNetworkWidget extends StatelessWidget {
  const ImageNetworkWidget({
    super.key, 
    this.imageSrc, 
    required this.height, 
    required this.width,
    this.radius = 0.0
  });

  final String? imageSrc;
  final double height;
  final double width;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.network(
        '${ApiConstant.imgW500}$imageSrc',
        height: height,
        width: width,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) {
          return SizedBox(
            height: height,
            width: width,
            child: Icon(
              Icons.broken_image_rounded
            ),
          );
        },
      ),
    );
  }
}