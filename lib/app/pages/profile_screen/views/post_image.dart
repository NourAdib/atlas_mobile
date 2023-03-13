import 'package:atlas_mobile/app/widgets/loading_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PostImage extends StatelessWidget {
  final String imageUrl;
  final String caption;
  final double height;
  const PostImage(
      {required this.imageUrl,
      required this.caption,
      required this.height,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageUrl.isNotEmpty
        ? Container(
            constraints: BoxConstraints(
              maxHeight: height,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 0),
                placeholder: (context, url) => const LoadingIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          )
        : Container(
            alignment: Alignment.center,
            child: Text(caption),
          );
  }
}
