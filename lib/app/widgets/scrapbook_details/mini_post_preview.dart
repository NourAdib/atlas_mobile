import 'package:atlas_mobile/app/model/post.model.dart';
import 'package:atlas_mobile/app/widgets/loading_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MiniPostPreview extends StatelessWidget {
  final Post post;
  final double height;
  final String scrapbookId;
  final Function(Post post, String scrapbookId) onTap;
  const MiniPostPreview(
      {required this.post,
      required this.height,
      required this.scrapbookId,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(post, scrapbookId),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF6E9),
          border: Border.all(
            color: const Color(0xFF182335),
            width: 3,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              blurRadius: 4,
              offset: Offset(0, 4), // changes position of shadow
            )
          ],
        ),
        child: post.imageUrl?.isNotEmpty ?? false
            ? CachedNetworkImage(
                imageUrl: post.imageUrl ?? '',
                fadeInDuration: const Duration(milliseconds: 0),
                placeholder: (context, url) => const LoadingIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )
            : Container(
                alignment: Alignment.center,
                child: Text(post.caption ?? ''),
              ),
      ),
    );
  }
}
