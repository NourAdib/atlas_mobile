import 'package:atlas_mobile/app/model/post.model.dart';
import 'package:atlas_mobile/app/model/scrapbook.model.dart';
import 'package:atlas_mobile/app/widgets/loading_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MiniScrapbookPreview extends StatelessWidget {
  final Scrapbook scrapbook;
  final double height;
  final String postId;
  final String thumbnail;
  final Function(String postId, String scrapbookId) onTap;

  const MiniScrapbookPreview(
      {required this.scrapbook,
      required this.height,
      required this.postId,
      required this.thumbnail,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(postId, scrapbook.id ?? ''),
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
        child: scrapbook.posts?.isNotEmpty ?? false
            ? CachedNetworkImage(
                imageUrl: thumbnail,
                fadeInDuration: const Duration(milliseconds: 0),
                placeholder: (context, url) => const LoadingIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )
            : Container(
                alignment: Alignment.center,
                child: Text(scrapbook.caption ?? ''),
              ),
      ),
    );
  }
}
