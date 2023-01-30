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
            margin: const EdgeInsets.all(10),
            constraints: BoxConstraints(
              maxHeight: height,
            ),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => const LoadingIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          )
        : SizedBox(
            child: Text(caption),
          );
  }
}
