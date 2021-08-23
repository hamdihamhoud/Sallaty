import 'package:ecart/models/product.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
// ...

class GalleryView extends StatelessWidget {
  static const routeName = '/gallery-view';
  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context).settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.title,
        ),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 1,
          child: ClipRect(
            child: PhotoViewGallery.builder(
              enableRotation: true,
              backgroundDecoration: BoxDecoration(
                color: Colors.white,
              ),
              scrollPhysics: BouncingScrollPhysics(),
              itemCount: product.imageUrls.length,
              loadingBuilder: (context, event) => Center(
                child: CircularProgressIndicator(),
              ),
              builder: (context, index) {
                return PhotoViewGalleryPageOptions(
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  maxScale: PhotoViewComputedScale.covered * 2,
                  imageProvider: NetworkImage(
                    product.imageUrls[index],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
