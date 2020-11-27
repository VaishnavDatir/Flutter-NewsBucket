import 'package:flutter/material.dart';

class HeroAndFadeInImage extends StatelessWidget {
  final String newsArticalTitle;
  final String newsArticalImageURL;

  const HeroAndFadeInImage({
    @required this.newsArticalTitle,
    @required this.newsArticalImageURL,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: newsArticalTitle,
      child: FadeInImage(
        placeholder: const AssetImage("dev_assets/NewsBucketLogo.png"),
        fit: BoxFit.cover,
        image: NetworkImage(
          newsArticalImageURL,
        ),
      ),
    );
  }
}
