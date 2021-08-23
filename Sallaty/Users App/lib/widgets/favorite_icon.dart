import 'package:ecart/models/product.dart';
import 'package:ecart/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteIcon extends StatefulWidget {
  const FavoriteIcon({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  _FavoriteIconState createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Container(
      decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Center(
        child: IconButton(
          iconSize: 25,
          padding: const EdgeInsets.all(0),
          color: Colors.white,
          icon: widget.product.isFavorite
              ? Icon(Icons.favorite_rounded)
              : Icon(Icons.favorite_border_rounded),
          onPressed: () {
            setState(() {
              widget.product.toggleFav(
                authProvider.token,
                authProvider.id,
              );
            });
          },
        ),
      ),
    );
  }
}
