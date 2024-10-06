import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lottie/lottie.dart';

class MyDefaultImage extends StatelessWidget {
  final String url;
  const MyDefaultImage({
    super.key,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      progressIndicatorBuilder: (context, url, progress) {
        return Center(
          child: LottieBuilder.asset(
            "assets/lottie/plants_loading.json",
          ),
        );
      },
    );
  }
}
