import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reliable_hands/config/export.dart';

class ReliableImageLoader extends StatelessWidget {
  final String imageUrl;
  final BoxFit? fit;

  const ReliableImageLoader({Key? key, required this.imageUrl, this.fit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: Colors.white,
          image: DecorationImage(
            image: imageProvider,
            fit: fit ?? BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: APPColors.appBorderColor,
        ),
        child: const CupertinoActivityIndicator(),
      ),
      errorWidget: (context, url, error) => Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: APPColors.appBorderColor,
        ),
        child: const Icon(Icons.error),
      ),
    );
  }
}
